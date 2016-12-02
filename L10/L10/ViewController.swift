//
//  ViewController.swift
//  L10
//
//  Created by ucom Apple 13 on 2016/12/2.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var comfirmHandler: UIButton!
    @IBOutlet weak var txtMsg: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btncomfirmHandler(sender: AnyObject) {
        
        self.txtMsg.resignFirstResponder() // close keyboard
        
        var localNotification : UILocalNotification = UILocalNotification() ;
        
        localNotification.fireDate = self.timePicker.date;
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = self.txtMsg.text ;
        
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1 ;
        
         UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
//        UIApplication.sharedApplication().scheduledLocalNotifications( localNotification ) ;
        
        print("Done");
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

