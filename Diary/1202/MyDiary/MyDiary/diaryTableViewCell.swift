//
//  diaryTableViewCell.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/1.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class diaryTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var dairytitle: UILabel!
    @IBOutlet weak var weekday: UILabel!
    @IBOutlet weak var day: UILabel!
   

    @IBOutlet weak var tagIcon: UIImageView!
    @IBOutlet weak var moodIcon: UIImageView!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    @IBAction func toPhotos(sender: AnyObject) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
