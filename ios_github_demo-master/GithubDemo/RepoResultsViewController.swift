//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController {

    @IBOutlet weak var githubTableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos = [GithubRepo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.githubTableView.delegate = self
        self.githubTableView.dataSource = self
        self.githubTableView.rowHeight = UITableViewAutomaticDimension
        self.githubTableView.estimatedRowHeight = 100

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
//            for repo in newRepos {
//                print(repo)
//                print(repo)
//                //self.repos.append(repo)
//            }   

            self.repos = newRepos
            self.githubTableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
}

extension RepoResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  githubTableView.dequeueReusableCell(withIdentifier: "githubCell", for: indexPath) as! GithubCell
        
        cell.nameLabel.text = repos[indexPath.row].name!
        cell.forksLabel.text = "\(repos[indexPath.row].forks!)"
        cell.starsLabel.text = "\(repos[indexPath.row].stars!)"
        cell.ownerHandleLabel.text = "by " + repos[indexPath.row].ownerHandle!
        cell.descriptionLabel.text = repos[indexPath.row].descriptionMine!
        cell.ownerAvatarImageView.setImageWith(URL(string: repos[indexPath.row].ownerAvatarURL!)!)
        
        return cell
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
