//
//  showDiaryViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/19.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class showDiaryViewController: UIViewController,UITextViewDelegate {
    
    var currentDiary : DiaryItem = DiaryItem();
    
    @IBOutlet weak var upperTool: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moodBtn: UIButton!
    @IBOutlet weak var weatherBtn: UIButton!
    
    @IBOutlet weak var diaryContentTextView: UITextView!
    
    @IBAction func closeDiary(sender: UIButton) {
        
    }
    
    
    
    override func viewDidLoad() {
        dayLabel.text = DiaryItem.dategetDay(currentDiary.date!) ;
        
        print("showDiary: \(currentDiary.title)");
    }
    
    
}
