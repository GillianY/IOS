//
//  MainDiaryViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class MainDiaryViewController: UIViewController,UITableViewDataSource{ //UIViewController
    

    var countriesinEurope = ["11/1","11/2","11/4"]
    var countriesinAsia = ["10/30","10/7","10/14"]
    var countriesInSouthAmerica = ["9/9","9/12","9/18"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundTheme("");
        
        self.tableView.dataSource = self as UITableViewDataSource
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setBackgroundTheme(theme:String){
       self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
        
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 3
    }
    
    // 每個section 數量不同
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{  return 2 }
        return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MianDiaryCell", forIndexPath: indexPath) as! UITableViewCell
       
        // 3
        // Configure the cell...
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = countriesinEurope[indexPath.row]
        case 1:
            cell.textLabel?.text = countriesinAsia[indexPath.row]
        case 2:
            cell.textLabel?.text = countriesInSouthAmerica[indexPath.row]
        //return sectionHeaderView
        default:
            cell.textLabel?.text = "Other"
        }
        
        return cell
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
    
    
//    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        //return
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
