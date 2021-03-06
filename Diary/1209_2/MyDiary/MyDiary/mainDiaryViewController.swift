//
//  mainDiaryViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/8.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class mainDiaryViewController: UITableViewController {
    
    var countriesinEurope = ["11/1","11/2","11/4"]
    var countriesinAsia = ["10/30","10/7","10/14"]
    var countriesInSouthAmerica = ["9/9","9/12","9/18"]
    
    var diarylist : [diaryItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setBackgroundTheme("");
        
        diarylist =  [diaryItem]();
        getDiarylist();
        
       // self.tableView.delegate = self;
       // self.tableView.dataSource = self;
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! mainDiaryCell
        cell.backgroundColor = UIColor.clearColor();
        cell.contentView.backgroundColor = UIColor.clearColor();
            // Configure the cell...
            switch (indexPath.section) {
            case 0:
                cell.daylabel?.text = countriesinEurope[indexPath.row]
            case 1:
                cell.daylabel?.text = countriesinAsia[indexPath.row]
            case 2:
                cell.daylabel?.text = countriesInSouthAmerica[indexPath.row]
            //return sectionHeaderView
            default:
                cell.daylabel?.text = "Other"
            }
            return cell
        }
    
    
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if section == 1{  return 2 }
        return 3
    }
    
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return  3;//1;
    }
    
    
    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
    }
    
    override func tableView(tableView:UITableView, titleForHeaderInSection: Int)-> String?
    {
        if titleForHeaderInSection == 0 {
            return "November"
        }else
        {
            return "December"
        }
    }
    
    //get DiaryDatas
    func getDiarylist()->(){
        var adiaryitem = diaryItem();
        diarylist?.append(adiaryitem);
        
        adiaryitem = diaryItem();
        adiaryitem.date = diaryItem.stringToDate("Wed, 12 Oct 2016 04:35");
        diarylist?.append(adiaryitem);
        
        adiaryitem = diaryItem();
        adiaryitem.date = diaryItem.stringToDate("Sun, 30 Oct 2016 01:05");
        diarylist?.append(adiaryitem);
         print("count \(diarylist!.count)------");
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // list  = ContactDAO.getContacts()
        print("---------viewWillAppear")
        self.tableView.reloadData()
    }
    
    
//    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//            return ["November","October","December"];
//        }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    




}
