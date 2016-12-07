//
//  MainMenuViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController ,UITableViewDataSource{

    @IBOutlet weak var funcTableView: UITableView!
    
    var funcs = ["電話號碼","DIARY","注意事項"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //!!
        self.funcTableView.dataSource = self as UITableViewDataSource
        
        setBackgroundTheme("")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
            }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // Return the number of sections.
//        return 1
//    }
    
    // 每個section 數量不同
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if section == 1{  return 2 }
        print("funcs.count！！！！！")
        return funcs.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        //print("hi!!")
        // 3
        // Configure the cell...
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = self.funcs[indexPath.row]
        default:
            cell.textLabel?.text = "Other"
        }
        
        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         //if(segue.identifier == "update")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let selectedRow = self.funcTableView.indexPathForSelectedRow!.row
//        if(selectedRow == 1){
//            //passData
//            //next.
//            let next = segue.destinationViewController as! MainDiaryViewController
//        }
        
        
    }
    

}
