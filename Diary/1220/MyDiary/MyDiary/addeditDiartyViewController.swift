//
//  addeditDiartyViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/15.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class addeditDiartyViewController: UIViewController ,UITextViewDelegate {
    
    var actionType = 0; // 1-> add , 2 -> edit
    var currentdiary:DiaryItem? ;// = DiaryItem();
    //Upper Bar Contents
    
    @IBOutlet weak var outterContextView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var locationBtn: UIButton!
  
    @IBOutlet weak var titleTextFiled: UITextField!
   
    @IBOutlet weak var contentsTextView: UITextView!
    
    @IBOutlet weak var weatherBtn: UIButton!
    @IBOutlet weak var moodBtn: UIButton!
    
    @IBOutlet weak var tagsBtn: UIButton!
    
    @IBAction func weatherSelect(sender: AnyObject) {
    }
    @IBOutlet weak var moodSelect: UIButton!
  
    // toolbar button Actions:
    @IBAction func saveDiary(sender: AnyObject) {
        if(actionType == 1) //add
        {
          saveCurrentDiaryfromUI(withDate: true);
          DiaryDAO.insert(currentdiary!);
          DiaryDAO.getDiarys();
            
        }else //update
        {
            saveCurrentDiaryfromUI(withDate: true);
            if(currentdiary?.did != 0)
            {
                DiaryDAO.update(currentdiary!);
            }else
            {
                DiaryDAO.insert(currentdiary!);
            }
        }
    }
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
    }
    
    @IBAction func closeDiary(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)

        
    }
    
    
    // Cancel or removed
    @IBAction func cancelBtn(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        setBackgroundTheme("");
        contentsTextView.delegate = self;
        print("addeditDiartyViewController \(currentdiary?.date): \(currentdiary?.month) : \(currentdiary?.did)");
        
        if(actionType == 1) //add
        {
            if(currentdiary == nil)
            {currentdiary = DiaryItem();}
            setDateInUI(NSDate());
        }else //edit
        {
            updateUIfromCurrentDiary(WithDate: true);
        }
     
        
     //set title textField underline only, no border
        let bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, titleTextFiled.frame.height - 3, titleTextFiled.frame.width, 3.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor;
        titleTextFiled.borderStyle = UITextBorderStyle.None
    titleTextFiled.layer.addSublayer(bottomLine)
        
    }
    
    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n")
//        {
//        contentsTextView.resignFirstResponder() ;
//            return false;
//        }
//        return true;
//    }
  
    func saveCurrentDiaryfromUI(withDate setDate: Bool ){
        
        if(setDate)
        {
            let composedDate = "\(dayLabel.text!) \(monthLabel.text!) \(yearLabel.text!) \(timeLabel.text!)";
            
            currentdiary?.date = DiaryItem.UIStringToDate(composedDate) ;
        }
        currentdiary?.title = titleTextFiled.text! ; // what if empty?
        currentdiary?.contents = contentsTextView.text;
        currentdiary?.mood = moodBtn.tag;
        currentdiary?.weather = weatherBtn.tag;
    }
    
    
    func updateUIfromCurrentDiary(WithDate setDate:Bool){
        
        if(setDate)
        {
            setDateInUI( (currentdiary?.date)! );
        }
        titleTextFiled.text = currentdiary?.title ; // what if empty?
        contentsTextView.text = currentdiary?.contents ;
        
        //moodBtn.tag = currentdiary?.mood  ;
        //weatherBtn.tag = currentdiary?.weather ;
        
        //should call reloadView(); 非同步 ？
    }

    //set dateTime on UI
    func setDateInUI(date :NSDate)
    {
        dayLabel.text = DiaryItem.dategetDay(date);
        monthLabel.text = DiaryItem.dategetMonth(date);
        weekLabel.text = DiaryItem.dategetWeek(date);
        timeLabel.text = DiaryItem.dategetTime(date);
        yearLabel.text = DiaryItem.dategetYear(date);
    }

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        contentsTextView.resignFirstResponder() ;
    }
    
    //在鍵盤執行的時候, 按一下空白處就是收回鍵盤
//    func addKeyboradBack(){
//        // 增加一個觸控事件 TextView
//        let tap = UITapGestureRecognizer(
//            target: self,
//            action: #selector(self.hideKeyboard(_:)))
//        
//        tap.cancelsTouchesInView = false
//        
//        // 加在最基底的 self.view 上
//        self.view.addGestureRecognizer(tap)
//    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
            
             print("keyboardWillShow!!!----\(keyboardSize.height) : \(self.view.frame.origin.y)---!!!");
        }
    }
    
    func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        print("keyboardWasShown");
        UIView.animateWithDuration(0.5, animations: { () -> Void in
           self.view.frame.origin.y -= (keyboardFrame.height + 20)
            // self.contentsTextView.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            self.view.frame.origin.y += keyboardSize.height
            
            print("keyboardWillHide!!!----\(keyboardSize.height) : \(self.view.frame.origin.y)---!!!");
        }
    }

    
    func hideKeyboard(tapG:UITapGestureRecognizer){
        // 除了使用 self.view.endEditing(true)
        // 也可以用 resignFirstResponder()
        // 來針對一個元件隱藏鍵盤
        self.contentsTextView.resignFirstResponder()
    }
    
    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"n01.jpg")!)
    }


}
