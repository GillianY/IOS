//
//  diaryItem.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/1.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import Foundation
import UIKit

class diaryItem {
    
    var contents :String?
    var date :NSDate?
    var mood :Int = 0
    var tags :[Int]?
    var photos : NSData?  // photos //UIImage(name: "logo.png")
    var title :String = ""
    
    init() {
        
        tags = [1,3,4,7];
        date = diaryItem.stringToDate("Sat, 22 Oct 2016 07:45");
        title = "hihi 天氣真好 ";
        contents = "asdfjlkasdjasdf \n asgasdfaas"; // ?? 換行符號的處理 injection
        photos = UIImagePNGRepresentation( UIImage(named: "snowman")!);
        mood = 1;
        
    }
    
    func dealwithPhoto()->(){
        //        CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
        //        NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
        //        const uint8_t* bytes = [data bytes];
    }
    
    
    //move to where ? AppDele....公用程式
      static func stringToDate(datestr: String)-> NSDate{
        //let dateString = "Sat, 22 Oct 2016 07:45"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm "
        dateFormatter.locale = NSLocale(localeIdentifier: "en-US")
        dateFormatter;
        datestr;
        let dateObj :NSDate = dateFormatter.dateFromString(datestr)!
        
        return dateObj
    }
    
    static func dateToString(dateObj: NSDate)-> String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm "
        return dateFormatter.stringFromDate(dateObj);
    }
    
    static func dategetWeek(dateObj: NSDate)->String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.stringFromDate(dateObj);
        
    }
    static func dategetMonth(dateObj: NSDate)->String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.stringFromDate(dateObj);
    }
    static func dategetTime(dateObj: NSDate)->String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.stringFromDate(dateObj);
    }
    
    static func dategetDay(dateObj: NSDate)->String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(dateObj);
    }
    
    static func dategetYear(dateObj: NSDate)->String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.stringFromDate(dateObj);
    }
    
    
    
    //    func info() -> String {
    //        return "\(width)x\(height)"
    //    }
    
    
}

