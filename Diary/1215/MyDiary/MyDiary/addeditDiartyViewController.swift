//
//  addeditDiartyViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/15.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class addeditDiartyViewController: UIViewController,UITe {
    
    var actionType = 0; // 0> add , i > edit
    var DiartID = 0;
    //Upper Bar Contents
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
    }
    
    // Cancel or removed
    @IBAction func cancelBtn(sender: AnyObject) {
    }
    
//    init(){
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        setBackgroundTheme("");
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)

        
     //set title textField underline only, no border
        let bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, titleTextFiled.frame.height - 3, titleTextFiled.frame.width, 3.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor;
        titleTextFiled.borderStyle = UITextBorderStyle.None
        titleTextFiled.layer.addSublayer(bottomLine)
  
      
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        print("!!!----\(keyboardSize.height) : \(self.view.frame.origin.y)---!!!");
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
          print("hide!!!----\(keyboardSize.height) : \(self.view.frame.origin.y)---!!!");
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            if view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//            else {
//                
//            }
//        }
//        
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            if view.frame.origin.y != 0 {
//                self.view.frame.origin.y += keyboardSize.height
//            }
//            else {
//                
//            }
//        }
//    }
    
    
    //在鍵盤執行的時候, 按一下空白處就是收回鍵盤
    func addKeyboradBack(){
        // 增加一個觸控事件 TextView
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.hideKeyboard(_:)))
        
        tap.cancelsTouchesInView = false
        
        // 加在最基底的 self.view 上
        self.view.addGestureRecognizer(tap)
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
