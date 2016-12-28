//
//  addeditDiartyViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/15.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//
import UIKit;

class addeditDiartyViewController: UIViewController ,UITextViewDelegate, UIPopoverPresentationControllerDelegate{
    
    var actionType = 0; // 1-> add , 0 -> edit
    var currentdiary:DiaryItem? ;// = DiaryItem();
    //Upper Bar Contents
    var contextCompleteTollbar : UIToolbar?;
    var textFieldToolbar : UIToolbar?;
    var showKeyBoard :Bool = true;
    var editedtextField:Bool = true;
    var photoID = 0 ;
    var tfDelegate : EditDiaryTextFieldDelegate?;
    var yStartPoistion : CGFloat?;
    //var currentedditArea : Int = 1; // 1 textField //2
    
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
    
    @IBOutlet weak var tagsBtn: UIButton!
    
    @IBAction func weatherSelect(sender: AnyObject) {
        let pop = self.storyboard?.instantiateViewControllerWithIdentifier("selectedWeatherVC") as! selectWeather; // ViewController
        pop.modalPresentationStyle = .Popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = weatherBtn ; // btn
        pop.popoverPresentationController?.sourceRect = weatherBtn.bounds; //CGRectMake(100,100,0,0)
        pop.preferredContentSize = CGSizeMake(300, 200)
        pop.popoverPresentationController?.permittedArrowDirections =  .Up ;//.Down
        self.presentViewController(pop, animated: true, completion: nil)
        
     // weatherBtn
    }
    @IBOutlet weak var moodSelect: UIButton!
    
  
    // toolbar button Actions:
    @IBAction func saveDiary(sender: AnyObject) {
        if(actionType == 1) //add
        {
          saveCurrentDiaryfromUI(withDate: true);
          currentdiary?.did  = DiaryDAO.insert(currentdiary!);
          print("newdid \(currentdiary?.did)");
          actionType == 0;
          //DiaryDAO.getDiarys(); //?? why ??
            
        }else //update
        {
            saveCurrentDiaryfromUI(withDate: true);
            if(currentdiary?.did > 0)
            {
                DiaryDAO.update(currentdiary!);
            }else
            {   print("saveDiary :check this!!! wrong actionType");
                currentdiary?.did = DiaryDAO.insert(currentdiary!);
            }
        }
        //add Diary_photos
        
        let hasPhotoData : Bool = DiaryDAO.hasPhotoDatabyPhotoID(photoID);
       if(hasPhotoData)
       {
        //update Dairy_photo with rowid
        DiaryDAO.updateDidToPhotoData((currentdiary?.did)!,rowid: photoID);
        }
    }
    
 //   @IBAction func takePicture(sender: UIBarButtonItem) {
  //  }
    
    @IBAction func closeDiary(sender: UIButton) {
        actionType = 1;
        if(!(DiaryDAO.hasPhotoDatabyPhotoID(photoID)))
        { //delete Dairy_photo with rowiD // not yet upick photo
            DiaryDAO.Photodelete(photoID)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Cancel or removed
    @IBAction func cancelBtn(sender: AnyObject) {
        
        // if photoid >0 -> delete
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
       // photoID = DiaryDAO.getNewPhotoID();
        
        
        showKeyBoard = true;
        setBackgroundTheme("");
       
       // PhotoID = self.view.tag ;
        tfDelegate = EditDiaryTextFieldDelegate();
        titleTextFiled.delegate = tfDelegate ;
       // titleTextFiled.addTarget(self, action:"textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        //swift2.2
        titleTextFiled.addTarget(self, action: #selector(addeditDiartyViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)

        contentsTextView.delegate = self;
        contentsTextView.contentInset = UIEdgeInsetsMake(-11, -6, 0, 0);
        contentsTextView.scrollEnabled = true;
        contentsTextView.returnKeyType = UIReturnKeyType.Default ;
         print("photo picker photoID\(photoID)");
      //  print("addeditDiartyViewController \(currentdiary?.date): \(currentdiary?.month) : \(currentdiary?.did)");
        
        if(actionType == 1) //add
        {
            photoID = DiaryDAO.getNewPhotoID();
            if(currentdiary == nil)
            {currentdiary = DiaryItem();
               // print("currentdiary :\(currentdiary )");
            }
            print("add newPid: \(photoID) ");
            setDateInUI(NSDate());
        }else //edit
        {
            photoID = DiaryDAO.getPhotoIDsbyDID((currentdiary?.did)!) ;
            print("edit oldPid: \(photoID) "); //-1

            if(photoID <= 0)
            {
                photoID = DiaryDAO.getNewPhotoID();
                print("edit newPid: \(photoID) ");

            }
            updateUIfromCurrentDiary(WithDate: true);
        }
     
        
        //set title textField underline only, no border
        //        let bottomLine = CALayer()
        //        bottomLine.frame = CGRectMake(0.0, titleTextFiled.frame.height - 3, titleTextFiled.frame.width, 3.0)
        //        bottomLine.backgroundColor = UIColor.blackColor().CGColor;
        //        titleTextFiled.borderStyle = UITextBorderStyle.None
        //        titleTextFiled.layer.addSublayer(bottomLine)
        yStartPoistion = self.view.frame.origin.y;
        addKeyboardToolbar();
        //  contentsTextView.becomeFirstResponder();
        
        moodSelect.tag = 1;
    }
    
    //    func textFieldDidBeginEditing(textField: UITextField) {
    //        editedtextField = true;
    //        print("text::::\(textField.text)");
    //    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        //currentedditArea = 2 ;
        tfDelegate!.editArea = 1
        tfDelegate!.editTextFiled = false;
        print("textViewDidBeginEditing\(tfDelegate!.editTextFiled)");
    }
    
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
    
    @IBAction func popUpMoodSelector(sender: UIButton) {
       
        //for XIB
//        let pop = ShowMoodPopViewController();
//        pop.modalPresentationStyle = .Popover
//        pop.popoverPresentationController?.delegate = self
//        pop.popoverPresentationController?.sourceView = moodSelect ; // btn
//        //pop.popoverPresentationController?.sourceRect = CGRectZero
//       pop.popoverPresentationController?.sourceRect = moodSelect.bounds
//        pop.preferredContentSize = CGSizeMake(300, 600)
//        pop.popoverPresentationController?.permittedArrowDirections =  .Up ;//.Down
//        self.presentViewController(pop, animated: true, completion: nil)
        
        
                let pop = self.storyboard?.instantiateViewControllerWithIdentifier("selectMoodVC") as! ShowMoodPopViewController;
                pop.modalPresentationStyle = .Popover
                pop.popoverPresentationController?.delegate = self
                pop.popoverPresentationController?.sourceView = moodSelect ; // btn
                //pop.popoverPresentationController?.sourceRect = CGRectZero
        pop.popoverPresentationController?.sourceRect = moodSelect.bounds; //CGRectMake(100,100,0,0)
        pop.preferredContentSize = CGSizeMake(300, 200)
                pop.popoverPresentationController?.permittedArrowDirections =  .Up ;//.Down
                self.presentViewController(pop, animated: true, completion: nil)

        
        //for navigationbar contoller
//        var popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("NewCategory") as UIViewController
//        var nav = UINavigationController(rootViewController: popoverContent)
//        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
//        var popover = nav.popoverPresentationController
//        popoverContent.preferredContentSize = CGSizeMake(500,600)
//        popover.delegate = self
//        popover.sourceView = self.view
//        popover.sourceRect = CGRectMake(100,100,0,0)
//        
//        self.presentViewController(nav, animated: true, completion: nil)

    
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
    func addKeyboardToolbar(){
      // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
      //  appDelegate.photoData;
        contextCompleteTollbar = UIToolbar();
        textFieldToolbar = UIToolbar();
        contextCompleteTollbar?.frame = CGRect(x: 0, y: 0, width: 320, height: 30)
        textFieldToolbar?.frame = CGRect(x: 0, y: 0, width: 320, height: 30)
        textFieldToolbar?.barStyle = UIBarStyle.Black;
        contextCompleteTollbar?.barStyle = UIBarStyle.Black;
        
        
        let doneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "resignKeyboard");
     //   let doneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.resignKeyboard))

        
        let emptyItem1 : UIBarButtonItem =  UIBarButtonItem.init(); //(barButtonSystemItem: nil, target: nil, action: nil);
        let emptyItem2 : UIBarButtonItem =  UIBarButtonItem.init();
        
        //定义完成按钮
        let btnArray = [doneButton ,emptyItem1 , emptyItem2];
        contextCompleteTollbar?.setItems(btnArray, animated: true)
        
        
     //     let txFielddoneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: tfDelegate, action: "resignKeyboardtxfiled")
        let txFielddoneButton : UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: tfDelegate, action: #selector(tfDelegate!.resignKeyboardtxfiled(_:)))
        
        
        
        let btnArray2 = [txFielddoneButton ,emptyItem1 , emptyItem2];
        textFieldToolbar?.setItems(btnArray2, animated: true)
        
        titleTextFiled.inputAccessoryView = textFieldToolbar;
        contentsTextView.inputAccessoryView = contextCompleteTollbar;
    }
    
    override func viewWillAppear(animated: Bool) {
        //添加键盘的监听事件
      //  NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow", name: UIKeyboardDidShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addeditDiartyViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil);
        
       //   NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHidden", name: UIKeyboardDidHideNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addeditDiartyViewController.keyboardDidHidden(_:)), name: UIKeyboardDidHideNotification, object: nil);
    }
    
    func resignKeyboard(){
        print("key");
        contentsTextView.resignFirstResponder();
    }
    
   
    
    func keyboardDidShow(notification: NSNotification){
    
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
           // contentsTextView.becomeFirstResponder();
            
           if(showKeyBoard)
           {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                var shifty :CGFloat = 0.0;
                if(self.tfDelegate?.editArea == 1) {
                    shifty = (keyboardSize.height - 100);
                }
             //   print("keyboardDidShow:\(shifty):\(self.yStartPoistion)\(keyboardSize.height)");
                self.view.frame.origin.y -= shifty;
            })
            showKeyBoard = false;
          //  print("keyboardDidHidden: \(showKeyBoard)");
            }
        }
    }
    
    func keyboardDidHidden(notification: NSNotification){
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if(!showKeyBoard)
            {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    var shifty :CGFloat = 0.0;
                    if(self.tfDelegate?.editArea == 1) {
                        shifty = (keyboardSize.height - 100);
                    }
                    print("keyboardDidHidden:\(shifty):\(self.yStartPoistion):\(keyboardSize.height)");
                    self.view.frame.origin.y += shifty;
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
        currentdiary?.mood = moodSelect.tag;
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

    
    func textFieldDidChange(textField: UITextField) {
        print("textField:\(textField.text)");
    
    }
    //performSegueWithIdentifier
//    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
//        
//        storyboard?.instantiateViewControllerWithIdentifier(identifier);
//       
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "pickPhoto")
        {
            let next = segue.destinationViewController as! PhotoPicker ; //photoPicker viewController
            let data_did = currentdiary?.did;
            
            // let actiontype = actionType ;
            //next.diaryDid = Int32(data_did!) ;
            next.rowID = Int32(photoID);
            print("prepareForSegue:\(next.rowID)");
        }
    }

}
