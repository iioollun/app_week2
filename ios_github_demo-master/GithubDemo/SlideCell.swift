//
//  SlideCell.swift
//  GithubDemo
//
//  Created by CongTruong on 10/19/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

@objc protocol SlideProtocol {
    @objc optional func changeValueSlide(slider: SlideCell, value: Int);
}

class SlideCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var starSlider: UISlider!
    
    weak var delegate: SlideProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func changeValue(_ sender: UISlider) {
        delegate?.changeValueSlide!(slider: self, value: Int(sender.value))
    }
}
