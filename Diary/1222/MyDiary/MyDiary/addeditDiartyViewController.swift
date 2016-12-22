//
//  addeditDiartyViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/15.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//
import UIKit;

class addeditDiartyViewController: UIViewController ,UITextViewDelegate, UITextFieldDelegate {
    
    var actionType = 0; // 1-> add , 2 -> edit
    var currentdiary:DiaryItem? ;// = DiaryItem();
    //Upper Bar Contents
    var contextCompleteTollbar : UIToolbar?;
    var showKeyBoard :Bool = true;
    var editedtextField:Bool = true;
    var photoID = 0 ;
    
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
    
 //   @IBAction func takePicture(sender: UIBarButtonItem) {
  //  }
    
    @IBAction func closeDiary(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)

        
    }
    
    
    // Cancel or removed
    @IBAction func cancelBtn(sender: AnyObject) {
        
        // if photoid >0 -> delete
    }
    
    
    override func viewDidLoad() {
        showKeyBoard = true;
        photoID = DiaryDAO.getNewPhotoID();
        setBackgroundTheme("");
        print("photo picker photoID\(photoID)");
       // PhotoID = self.view.tag ;
        titleTextFiled.delegate = self ;
        contentsTextView.delegate = self;
        contentsTextView.contentInset = UIEdgeInsetsMake(-11, -6, 0, 0);
        contentsTextView.scrollEnabled = true;
        contentsTextView.returnKeyType = UIReturnKeyType.Default ;
        
      //  print("addeditDiartyViewController \(currentdiary?.date): \(currentdiary?.month) : \(currentdiary?.did)");
        
        if(actionType == 1) //add
        {
            if(currentdiary == nil)
            {currentdiary = DiaryItem();
               // print("currentdiary :\(currentdiary )");
            }
            setDateInUI(NSDate());
        }else //edit
        {
            updateUIfromCurrentDiary(WithDate: true);
        }
     
        
        //set title textField underline only, no border
        //        let bottomLine = CALayer()
        //        bottomLine.frame = CGRectMake(0.0, titleTextFiled.frame.height - 3, titleTextFiled.frame.width, 3.0)
        //        bottomLine.backgroundColor = UIColor.blackColor().CGColor;
        //        titleTextFiled.borderStyle = UITextBorderStyle.None
        //        titleTextFiled.layer.addSublayer(bottomLine)
        addKeyboardToolbar();
        //  contentsTextView.becomeFirstResponder();
    }
    
    //    func textFieldDidBeginEditing(textField: UITextField) {
    //        editedtextField = true;
    //        print("text::::\(textField.text)");
    //    }
    
    
     func textViewDidChange(textView: UITextView) {
        //textView.caretRectForPosition(textView.selectedTextRange.)
    }
   
    
//    -(void)textViewDidChange:(UITextView *)textView {
//    CGRect line = [textView caretRectForPosition:
//    textView.selectedTextRange.start];
//    CGFloat overflow = line.origin.y + line.size.height
//    - ( textView.contentOffset.y + textView.bounds.size.height
//    - textView.contentInset.bottom - textView.contentInset.top );
//    if ( overflow > 0 ) {
//    // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
//    // Scroll caret to visible area
//    CGPoint offset = textView.contentOffset;
//    offset.y += overflow + 7; // leave 7 pixels margin
//    // Cannot animate with setContentOffset:animated: or caret will not appear
//    [UIView animateWithDuration:.2 animations:^{
//    [textView setContentOffset:offset];
//    }];
//    }
//    }
 
    
    
    
    func addKeyboardToolbar(){
      // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      //  appDelegate.photoData;
        contextCompleteTollbar = UIToolbar();
        contextCompleteTollbar?.frame = CGRect(x: 0, y: 0, width: 320, height: 30)
        contextCompleteTollbar?.barStyle = UIBarStyle.Black;
         let doneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.resignKeyboard))
        
        let emptyItem1 : UIBarButtonItem =  UIBarButtonItem.init(); //(barButtonSystemItem: nil, target: nil, action: nil);
        let emptyItem2 : UIBarButtonItem =  UIBarButtonItem.init();
        
        //定义完成按钮
        let btnArray = [doneButton ,emptyItem1 , emptyItem2];
        contextCompleteTollbar?.setItems(btnArray, animated: true)
        
        titleTextFiled.inputAccessoryView = contextCompleteTollbar;
        contentsTextView.inputAccessoryView = contextCompleteTollbar;
    }
    
    override func viewWillAppear(animated: Bool) {
        //添加键盘的监听事件
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addeditDiartyViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addeditDiartyViewController.keyboardDidHidden(_:)), name: UIKeyboardDidHideNotification, object: nil);
    }
    
    func resignKeyboard(){
        print("key");
        contentsTextView.resignFirstResponder();
    }
    
    func keyboardDidShow(notification: NSNotification){
    
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            contentsTextView.becomeFirstResponder();
           if(showKeyBoard)
           {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.frame.origin.y -= (keyboardSize.height - 30 )
                // self.contentsTextView.bottomConstraint.constant = keyboardFrame.size.height + 20
                
            })
            showKeyBoard = false;
            print("keyboardDidHidden: \(showKeyBoard)");
            }
        }
    }
    
    func keyboardDidHidden(notification: NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if(!showKeyBoard)
            {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.frame.origin.y += (keyboardSize.height - 30 )
                // self.contentsTextView.bottomConstraint.constant = keyboardFrame.size.height + 20
                })
                showKeyBoard = true;
                print("keyboardDidHidden: \(showKeyBoard)");
            }
        }
    }
  
    func saveCurrentDiaryfromUI(withDate setDate: Bool ){
        
        if(setDate)
        {
            let composedDate = "\(dayLabel.text!) \(monthLabel.text!) \(yearLabel.text!) \(timeLabel.text!)";
            print("\(composedDate)");
            currentdiary?.date = DiaryItem.UIStringToDate(composedDate) ;
                   }
        currentdiary?.title = titleTextFiled.text! ; // what if empty?
        currentdiary?.contents = contentsTextView.text;
        print("\(currentdiary?.contents)");
        currentdiary?.mood = moodBtn.tag;
        currentdiary?.weather = weatherBtn.tag;
    }
    
    
    func updateUIfromCurrentDiary(WithDate setDate:Bool){
        
        if(setDate)
        {
            setDateInUI( (currentdiary?.date)! );
        }
        print("updateUIfromCurrentDiary: \(currentdiary?.title)");
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

    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"n01.jpg")!)
    }
    

//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        contentsTextView.resignFirstResponder() ;
//    }
//    
    
//    func keyboardWillShow(notification: NSNotification) {
//        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y -= keyboardSize.height
//            
//             print("keyboardWillShow!!!----\(keyboardSize.height) : \(self.view.frame.origin.y)---!!!");
//        }
//    }
//    
//    func keyboardWasShown(notification: NSNotification) {
//        let info = notification.userInfo!
//        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//        print("keyboardWasShown");
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//           self.view.frame.origin.y -= (keyboardFrame.height + 20)
//            // self.contentsTextView.bottomConstraint.constant = keyboardFrame.size.height + 20
//        })
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            
//            self.view.frame.origin.y += keyboardSize.height
//            
//            print("keyboardWillHide!!!----\(keyboardSize.height) : \(self.view.frame.origin.y)---!!!");
//        }
//    }

    
//    func hideKeyboard(tapG:UITapGestureRecognizer){
//        // 除了使用 self.view.endEditing(true)
//        // 也可以用 resignFirstResponder()
//        // 來針對一個元件隱藏鍵盤
//        self.contentsTextView.resignFirstResponder()
//    }
    
    
    //    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    //        if(text == "\n")
    //        {
    //        contentsTextView.resignFirstResponder() ;
    //            return false;
    //        }
    //        return true;
    //    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pickPhoto")
        {
            let next = segue.destinationViewController as! PhotoPicker ; //photoPicker viewController
            let data_did = currentdiary?.did;
            
            // let actiontype = actionType ;
            //next.diaryDid = Int32(data_did!) ;
            next.rowID = Int32(photoID);
        }
    }

}
