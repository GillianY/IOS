//
//  CaldenarViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/24.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class CaldenarViewController: UIViewController {
    
    @IBOutlet weak var segments: UISegmentedControl!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func back(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    };
    
    @IBAction func segmentControlValueChange(sender: UISegmentedControl) {
        print("segmentCtrlChange \(sender.selectedSegmentIndex)");
        if(sender.selectedSegmentIndex == 0)
        {
            print("Enties");
        performSegueWithIdentifier("mainDiaryViewController", sender: self)
            
        }else if(sender.selectedSegmentIndex == 1)
        {  //print("CalendarSegue");
           // performSegueWithIdentifier("CalendarSegue", sender: self)
            // sender.selectedSegmentIndex =0 ;
        }else if(sender.selectedSegmentIndex == 2)
        {   print("addDiarySegue");
            performSegueWithIdentifier("addDiarySegue", sender: self)
            //            let next = self.storyboard!.instantiateViewControllerWithIdentifier("addEditDiaryVCS") as! addeditDiartyViewController ;
            //            next.actionType = 1;
            
            //  next.modalTransitionStyle = .FlipHorizontal
            
            // self.presentViewController(next, animated: true, completion:nil)
        }else {
            print("segmentCtrlChange mistake");}
        
        
    }
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var tempture: UILabel!
    @IBOutlet weak var weatherCode: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    
    var weatherCondition: getWeatherInfo?;
    var weather:[String:String]? ;
    var getDataTime :String?;
    var today = NSDate();
    
    override func viewDidLoad(){
       // weatherCondition = getWeatherInfo();
        super.viewDidLoad();
        getTodayData();
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate ;
        weatherCondition = appDelegate.todayweather
    }
    
    
    
    func getTodayData(){
        yearLabel.text = DiaryItem.dategetYear(today);
        monthLabel.text = DiaryItem.dategetMonth(today);
        dayLabel.text = DiaryItem.dategetDay(today);
        weekLabel.text = DiaryItem.dategetWeek(today);
       //  NSThread.sleepForTimeInterval(3) ;
    }
    
    override func viewWillAppear(animated: Bool) {
        segments.selectedSegmentIndex = 1 ;
        weather = weatherCondition!.JsondataArray;
       //  print("2getTodayData-----\((weatherCondition!.JsondataArray)["text"]) \(weather!["temp"]) \(weather!["code"])");
        weatherCode.text = weather!["text"];
        getDataTime = weather!["date"];
        tempture.text = weather!["temp"];
        weatherImageView.image = (weatherCondition?.getWeatherImage())!;
        setBackgroundTheme("");
        // print("caledar\(weatherCode.text) ,\(tempture.text)");
    }
    
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        print("performSegueWithIdentifier");
        // let segueSender : UISegmentedControl = sender as! UISegmentedControl;  sender : this view Controller
        
        if(identifier == "addDiarySegue")
        {
            let callNewDiary = storyboard?.instantiateViewControllerWithIdentifier("addEditDiaryVCS") as! addeditDiartyViewController ;
            callNewDiary.actionType = 1;
            //sender = callNewDiary;
            presentViewController(callNewDiary, animated: true, completion:
                nil
            )
            //prepareForSegue(segue);
        }else if(identifier == "mainDiaryViewController")
        {
            print("mainDiaryViewController");
            self.dismissViewControllerAnimated(true, completion: nil)
//            let mainVC = storyboard?.instantiateViewControllerWithIdentifier("mainDiaryViewController") as! mainDiaryViewController ;
//        
//            mainVC.navigationController?.setNavigationBarHidden(false, animated: false);
//
//            presentViewController(mainVC, animated: true, completion:
//                nil
 //           )
        }else
        { print("error");
        }
        // mainDiaryViewController
    }

    
    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
    }

    
}
