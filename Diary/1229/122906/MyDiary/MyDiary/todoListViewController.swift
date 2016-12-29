//
//  todoListViewController.swift
//  MyDiary
//
//  Created by Gillian on 2016/12/25.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class todoListViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate,UIPopoverPresentationControllerDelegate {

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
        
        var myAlert: UIAlertController = UIAlertController(title:"新增",message: "請輸入新增項目",preferredStyle: .Alert);
        myAlert.addTextFieldWithConfigurationHandler({textField in textField.placeholder = "輸入項目"})
        let action = UIAlertAction(title: "Done" , style:UIAlertActionStyle.Default,handler: {action in
            // addToDB
        DiaryDAO.addTodoListContents(self.MemoID, contens:(myAlert.textFields!.first)!.text!) ;
             self.MemoItems = DiaryDAO.getTodoListItemsBymiD(self.MemoID);
            print("addTodoListIcon : \(self.MemoItems.count) ");
            self.tableView.reloadData();
           // print("\((myAlert.textFields!.first)!.text)")
        });
        myAlert.addAction(action);
        self.presentViewController(myAlert, animated: true , completion: nil);
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
    
    override func viewDidAppear(animated: Bool) {
        MemoItems = DiaryDAO.getTodoListItemsBymiD(MemoID);
        tableView.reloadData();
    }
  //  override func viewWillAppear(animated: Bool) {
       // MemoItems = DiaryDAO.getTodoListItemsBymiD(MemoID);
 //   }
  
    
    @IBAction func clickListTitleBtn(sender: UIButton) {
        //change title
        
    }
    
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//                if editingStyle == .Delete{
//                    DiaryDAO.deleteTodoList(MemoItems[indexPath.row].miid);
//                   tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//                }
//        // tableView.reloadData();
//    }
    
     func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        print("editActionsForRowAtIndexPath");
        
        let shareAction =  UITableViewRowAction(style:  UITableViewRowActionStyle.Default ,title: "Share" , handler: {
            (action, indexPath) -> Void in
            let defaultText = self.MemoItems[indexPath.row].title + " （測試中）";
            print(defaultText);
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.presentViewController(activityController ,animated: true , completion : nil );
            
        });
//        
//        if editingStyle == .Delete{
//            DiaryDAO.deleteTodoList(MemoItems[indexPath.row].miid);
//           tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
       // tableView.reloadData();
       
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {(action,indexPath) -> Void in
            print("___Delete :\(indexPath.row) : \(self.MemoItems[indexPath.row].miid)");
            let tmp =  self.MemoItems[indexPath.row].miid ;
            DiaryDAO.deleteTodoList(tmp);
            
           // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade);
            self.MemoItems = DiaryDAO.getTodoListItemsBymiD(self.MemoID);
            tableView.reloadData();
            
        });
        
        return [deleteAction, shareAction]
        
    }
    
    @IBAction func addtodolist(sender: UIButton) {
       // DiaryDAO.addTodoListContents(, contens: "")
        
        let pop = self.storyboard?.instantiateViewControllerWithIdentifier("selectMoodVC") as! ShowMoodPopViewController;
//        pop.modalPresentationStyle = .Popover
//        pop.popoverPresentationController?.delegate = self
//        pop.popoverPresentationController?.sourceView = moodSelect ; // btn
//        //pop.popoverPresentationController?.sourceRect = CGRectZero
//        pop.popoverPresentationController?.sourceRect = moodSelect.bounds; //CGRectMake(100,100,0,0)
//        pop.preferredContentSize = CGSizeMake(300, 200)
//        pop.popoverPresentationController?.permittedArrowDirections =  .Up ;//.Down
//        self.presentViewController(pop, animated: true, completion: nil)
        
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
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
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
     //   print("didSelectRowAtIndexPath \(indexPath)");
        var currentItem = MemoItems[indexPath.row];
        
        print("_____\(currentItem.title) , \(currentItem.miid), \(currentItem.mid)");
        let alertController = UIAlertController(
            title: "編輯",
            message: "可改變資料",
            preferredStyle: .Alert)
        
        // 建立輸入框
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.text = currentItem.title ;
            // 如果要輸入密碼 這個屬性要設定為 true
            //textField.secureTextEntry = true
        }
        // 建立[取消]按鈕
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .Cancel,
            handler: nil)
        alertController.addAction(cancelAction);
        
         let okAction = UIAlertAction(
            title: "更新",
            style: UIAlertActionStyle.Default) {
                (action: UIAlertAction!) -> Void in
                let data =
                    (alertController.textFields?.first)!
                        as UITextField ; //.text
               // print("update info...");
                DiaryDAO.updateTodoList(currentItem.miid, title: data.text!);
                self.MemoItems = DiaryDAO.getTodoListItemsBymiD(self.MemoID);
                tableView.reloadData();
        }
        alertController.addAction(okAction)
        
        self.presentViewController(
            alertController,
            animated: true,
            completion: nil)
    }
    
    func resignKeyboard(){
      //  contentsTextView.resignFirstResponder();
    }
    
    func addKeyboardToolbar(){
        var textFieldToolbar = UIToolbar();
        textFieldToolbar.frame = CGRect(x: 0, y: 0, width: 320, height: 30)
        textFieldToolbar.barStyle = UIBarStyle.Black;
       
        let doneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action:"resignKeyboard");
        //   let doneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.resignKeyboard))
        
        
        let emptyItem1 : UIBarButtonItem =  UIBarButtonItem.init(); //(barButtonSystemItem: nil, target: nil, action: nil);
        let emptyItem2 : UIBarButtonItem =  UIBarButtonItem.init();
        
        //定义完成按钮
        let btnArray = [doneButton ,emptyItem1 , emptyItem2];
     //   contextCompleteTollbar?.setItems(btnArray, animated: true)
        
        
      //  let txFielddoneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: tfDelegate, action: "resignKeyboardtxfiled")
        //   let txFielddoneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: tfDelegate, action: #selector(tfDelegate!.resignKeyboardtxfiled(_:)))
        
        
        
      //  let btnArray2 = [txFielddoneButton ,emptyItem1 , emptyItem2];
       // textFieldToolbar?.setItems(btnArray2, animated: true)
        
      //  titleTextFiled.inputAccessoryView = textFieldToolbar;
      //  contentsTextView.inputAccessoryView = contextCompleteTollbar;
    }

    
    func keyboardDidShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            // contentsTextView.becomeFirstResponder();
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -=  (keyboardSize.height - 100);
                })
        }
    }
    
    
    func keyboardDidHidden(notification: NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                           UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y += (keyboardSize.height - 100);
                })
        }
    }

    

}
