//
//  diaryItem.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/1.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import Foundation
import UIKit

class DiaryItem {
    
    static var monthNames = ["01":"1","02":"2","03":"3","04":"4","05":"5","06":"6","07":"7","08":"8","09":"9","10":"10","11":"11","12":"12"]
    
    
    var did: Int = -1;
    var contents :String?
    var date :NSDate?
    var mood :Int = 0
    var weather :Int = 0
    var tags :[Int]?
    var photos : NSData?  // photos //UIImage(name: "logo.png")
    var title :String = ""
    var gpsLongtitude : String = ""
    var gpsLatitude :String = ""
   // var time: String = "";
    var year :Int = 0;
    var month :Int = 0 ;
    
    init() {
        
        tags = [1,3,4,7];
        date = DiaryItem.stringToDate("2016-11-12 18:03");
        title = "hihi 天氣真好 ";
        contents = "asdfjlkasdjasdf \n asgasdfaas"; // ?? 換行符號的處理 injection
        photos = UIImagePNGRepresentation( UIImage(named: "snowman")!);
        mood = 5; // normal
       // time = "23:59";
        
    }
    
    func dealwithPhoto()->(){
        //        CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
        //        NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
        //        const uint8_t* bytes = [data bytes];
    }
    
    static func UIStringToDate(datestr: String)-> NSDate{
        //17 December 2016 14:41
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm" ;
        dateFormatter.locale = NSLocale(localeIdentifier:"en_US" )//"zh_Hant_TW"
        dateFormatter;
        print("UIStringToDate:\(datestr)");
        let dateObj :NSDate = dateFormatter.dateFromString(datestr)!
        
        return dateObj
    
    }
    
      static func stringToDate(datestr: String)-> NSDate{
        //let dateString = "2016-11-12 18:03"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" ;  // "EEE, dd MMM yyyy hh:mm "
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter;
        print("stringToDate:\(datestr)");
        let dateObj :NSDate = dateFormatter.dateFromString(datestr)!
        
        return dateObj
    }
    
    static func DatetoCalendar(date :NSDate)-> NSDateComponents{

        let unitFlags: NSCalendarUnit = [.Hour, .Weekday, .Day, .Month, .Year]
        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate:date)
        return components;
    
    }
    
    static func dateToString(dateObj: NSDate)-> String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.stringFromDate(dateObj);
    }
    
    static func dategetWeek(dateObj: NSDate)->String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.stringFromDate(dateObj);
        
    }
    static func dategetMonth(dateObj: NSDate)->String{
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "MMMM"
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

