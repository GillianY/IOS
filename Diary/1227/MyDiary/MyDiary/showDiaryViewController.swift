//
//  showDiaryViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/19.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class showDiaryViewController: UIViewController,UITextViewDelegate,UIPopoverPresentationControllerDelegate {
    
    var currentDiary : DiaryItem = DiaryItem();
    
    @IBOutlet weak var upperTool: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moodBtn: UIButton!
    @IBOutlet weak var weatherBtn: UIButton!
    
    @IBOutlet weak var diaryContentTextView: UITextView!
    
    @IBAction func closeDiary(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
//    @IBAction func toEditDiary(sender: UIBarButtonItem) {
//        
//        
//    }
    
    @IBAction func showPhoto(sender: AnyObject) {
        
        var photoID = DiaryDAO.getPhotoIDsbyDID(currentDiary.did);
        var ViewSize :CGSize? ;
       
        
        
        let pop = self.storyboard?.instantiateViewControllerWithIdentifier("showPhotoVC") as! ShowPhotoVC;
        
        if(photoID > 0)
        {
            ViewSize = CGSizeMake(400, 500);
            pop.DataType = 0; //photo
        }else
        {
            ViewSize = CGSizeMake(200, 200);
            pop.DataType = 0;
        }
        
        pop.diaryID =  currentDiary.did ;
    
        pop.modalPresentationStyle = .Popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = weatherBtn ; // btn
        pop.popoverPresentationController?.sourceRect = weatherBtn.bounds; //CGRectMake(100,100,0,0)
        pop.preferredContentSize = ViewSize!;
        pop.popoverPresentationController?.permittedArrowDirections = .Down
        self.presentViewController(pop, animated: true, completion: nil)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
        //view.backgroundColor = UIColor.clearColor() ;
        view.opaque = false
        
        diaryContentTextView.delegate = self;
        
        dayLabel.text = DiaryItem.dategetDay(currentDiary.date!) ;
        monthLabel.text = DiaryItem.dategetMonth(currentDiary.date!);
        yearLabel.text = DiaryItem.dategetYear(currentDiary.date!);
        titleLabel.text = currentDiary.title;
        
        diaryContentTextView.text = currentDiary.contents;
        
        print("contents: \(currentDiary.contents)");
      
        print("showDiary: \(currentDiary.title)");
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "editDiary")
        {
            let next = segue.destinationViewController as! addeditDiartyViewController ;
            
            let selectedSender = sender?.tag;
            
            if(selectedSender == 1)
            {
                next.currentdiary = self.currentDiary;
                print("to Edit");
            }
            print("prepareForSegue error");
        }
        print("prepareForSegue error");
    }
    
}
