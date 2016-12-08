//
//  mainMenuTableViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/7.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class mainMenuTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var itemtableView: UITableView!
    
     var funcs = ["電話號碼","DIARY","注意事項"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemtableView.dataSource = self as UITableViewDataSource
        
        setBackgroundTheme("")
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("mainMenuTVCell",forIndexPath: indexPath) as! mainMenuTVCell;
        
        switch (indexPath.section) {
        case 0:
            cell.funcLabel?.text = self.funcs[indexPath.row]
        default:
            cell.funcLabel?.text = "Other"
        }

        cell.iconImg?.image = UIImage(named:"gift.png");
        
        return cell;
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcs.count;
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
    }

    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        //if(segue.identifier == "update")
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        let selectedRow = self.funcTableView.indexPathForSelectedRow!.row
//        //        if(selectedRow == 1){
//        //            //passData
//        //            //next.
//        //            let next = segue.destinationViewController as! MainDiaryViewController
//        //        }
//        
//        
//    }

    


}
