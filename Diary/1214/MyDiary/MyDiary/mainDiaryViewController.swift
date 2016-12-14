//
//  mainDiaryViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/8.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class mainDiaryViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var countriesinEurope = ["11/1","11/2","11/4"]
    var countriesinAsia = ["10/30","10/7","10/14"]
    var countriesInSouthAmerica = ["9/9","9/12","9/18"]
    
    var diarylist : [DiaryItem]?
    
    @IBOutlet weak var naviBar: UINavigationItem!
    @IBOutlet weak var uptoolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(named: "BarBackground"),
                                         forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
       // uptoolbar.layer.borderWidth = 1;
       // uptoolbar.layer.borderColor =  UIColor.clearColor().CGColor;
        
        // navigationController?.navigationBar.frame.origin.y = 10
        setBackgroundTheme("");
        
        diarylist =  [DiaryItem]();
        getDiarylist();
        
        self.tableView.delegate = self as UITableViewDelegate;
        self.tableView.dataSource = self as UITableViewDataSource;
        self.tableView.backgroundColor = UIColor.clearColor();
        
       // navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default);
//    navigationController?.navigationBar.shadowImage = UIImage();
//       navigationController?.navigationBar.layer.borderWidth = 0;
        
       
      //shadowImage = UIImage();
        
     

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("diaryCell", forIndexPath: indexPath) as! mainDiaryCell
        cell.backgroundColor = UIColor.clearColor();
       // cell.contentView.backgroundColor = UIColor.clearColor();
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if section == 1{  return 2 }
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return  3;//1;
    }
    
    
    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
        
        
   
    }
    
    func tableView(tableView:UITableView, titleForHeaderInSection: Int)-> String?
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
        var adiaryitem = DiaryItem();
        diarylist?.append(adiaryitem);
        
       var adiaryitem2 = DiaryItem();
        adiaryitem2.date = DiaryItem.stringToDate("Wed, 12 Oct 2016 04:35");
        diarylist?.append(adiaryitem2);
        
       var adiaryitem3 = DiaryItem();
        adiaryitem3.date = DiaryItem.stringToDate("Sun, 30 Oct 2016 01:05");
        diarylist?.append(adiaryitem3);
       //  print("count \(diarylist!.count)------");
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // list  = ContactDAO.getContacts()
        //print("---------viewWillAppear")
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
