//
//  CaldenarViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/24.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class CaldenarViewController: UIViewController {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var tempture: UILabel!
    @IBOutlet weak var weatherCode: UILabel!
    var weatherCondition: getWeatherInfo?;
    var weather:[String:String]? ;
    var getDataTime :String?;
    var today = NSDate();
    
    override func viewDidLoad(){
        super.viewDidLoad();
        getTodayData();
        
    }
    
    func getTodayData(){
        weatherCondition = getWeatherInfo();
        weather = weatherCondition!.JsondataArray;
        weatherCode.text = weather!["code"];
        getDataTime = weather!["date"];
        tempture.text = weather!["tempture"];
        
        //DiaryItem.dateToString(NSDate());
        yearLabel.text = DiaryItem.dategetYear(today);
        monthLabel.text = DiaryItem.dategetMonth(today);
        dayLabel.text = DiaryItem.dategetDay(today);
        weekLabel.text = DiaryItem.dategetWeek(today);
        
        print("caledar\(weatherCode.text) ,\(tempture.text)");
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        //
    }
    
    
    
}
