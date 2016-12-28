//
//  todoListViewController.swift
//  MyDiary
//
//  Created by Gillian on 2016/12/25.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class todoListViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate {

    @IBAction func closeWindow(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func addTodoListIcon(sender: UIButton) {
    }
    
    
    var MemoID = 1 ;
    var MemoItems = [ToDoListItem]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self ; //as! UITableViewDelegate  ;
        tableView.dataSource = self ;// as! UITableViewDataSource ;
        
       MemoItems = DiaryDAO.getTodoListItemsBymiD(MemoID);
      //  DiaryDAO.addTodoListContents(, contens: "")
        titleBtn.titleLabel?.text =  DiaryDAO.getMemoGroupTitle(MemoID) ;
        print( "dbpath: \(DiaryDAO.dbPath)");
    }
    
    @IBAction func clickListTitleBtn(sender: UIButton) {
        //change title
        
    }
    
    @IBAction func addtodolist(sender: UIButton) {
       // DiaryDAO.addTodoListContents(, contens: "")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveData(sender: UIBarButtonItem) {
    }
    
    @IBAction func closeToDoList(sender: UIBarButtonItem) {
      //(()->void)? //() -> Void in {}
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //@IBOutlet weak var closeNote: UIBarButtonItem!
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemoItems.count ;
      //  return 20 ;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("todoitemCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor(); // cell.contentView.backgroundColor = UIColor.clearColor();
        //cell.textLabel.text = "hello kitty";
        let itemdata = MemoItems[indexPath.row];
        cell.textLabel?.text = itemdata.title ;  //"hello";
        cell.tag = itemdata.miid ;
        cell.imageView?.image = UIImage(named: "f41.jpg");//UIImacontentsOfFile: ge("f41.jpg");
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath \(indexPath)");
    
    }
    

}
