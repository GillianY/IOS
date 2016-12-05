//
//  mainDiaryViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/5.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class mainDiaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBAction func mianDiarySegmentsChanged(sender: UISegmentedControl) {
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        UITableViewCell * cell = nil;
    
       return cell;
    }

}
