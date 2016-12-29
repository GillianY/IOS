//
//  getWeatherInfo.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/27.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class getWeatherInfo: NSObject,NSURLSessionDelegate, NSURLSessionDownloadDelegate {
    
    var weatherID = 1;
    var JsondataArray = [String:String]();
    
    override init() {
        super.init();
        print("init getWeatherInfo");
        getJsonFromSession();
        
        
        print("JsondataArray: \(JsondataArray["code"]) \(JsondataArray["temp"])");
    }
    
    func getJsonFromSession(){// classitself:AnyObject){
        //台北市立動物園公開資料網址
        let url = NSURL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%202306179%20and%20u%3D%22c%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys");
        //"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&amp;rid=a3e2b221-75e0-45c1-8f97-75acbd43d613"
        
        //建立一般的session設定
        let sessionWithConfigure = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        //設定委任對象為自己
        let session = NSURLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        //設定下載網址
        let dataTask = session.downloadTaskWithURL(url!)
        print("....getJsonFromSession....");
        //啟動或重新啟動下載動作
        dataTask.resume();
    }
    
    
    //MARK: session delegate
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        do {
            //JSON資料處理
            let dataDic = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: location)!, options: NSJSONReadingOptions.MutableContainers) as! [String:[String: AnyObject]]
            
            //依據先前觀察的結構，取得result對應中的results所對應的陣列
            var dataArray = dataDic["query"]! as! [String:AnyObject];
            dataArray = dataArray["results"] as! [String:AnyObject];
            dataArray = dataArray["channel"] as! [String:AnyObject];
            dataArray = dataArray["item"] as! [String:AnyObject];
           // var dataArray2 = dataDic["query"]!["results"]!["channel"]!["item"] as! [String:AnyObject];
             JsondataArray = dataArray["condition"] as! [String:String];
            print(".....Json.......\(JsondataArray["code"]),\(JsondataArray["date"]),\(JsondataArray["temp"]),\(JsondataArray["text"]) ");
        } catch {
            print("Error!")
        }
        print("hello");
    }
    
    
    func getWeatherCode()-> String{
        return (JsondataArray["code"])!;
    }
    func getWeatherTempture()-> String{
        return JsondataArray["temp"]!;
    }
    func getWeatherTime()-> String{
        return JsondataArray["date"]!;
    }
    func getWeatherText()-> String{
        return JsondataArray["text"]!;
    }
    
    
    func getWeatherImage()-> UIImage{
        var wcode :Int = 0;
        wcode =  Int(getWeatherCode())! ;
        return  getWeatherImageByCodeID(wcode);
    }
    
    func getWeatherImageByCodeID(code :Int)-> UIImage{
       
        var resultImgName : String = "Sun.png";
        //JsondataArray["code"]
       // if(weatherCode >= 0 & weatherCode< )
        
        switch (code){
        case 0,1,2,3,4,47,45,37,38,39,40:
            resultImgName = "Storm.png";
        case 5,6,7,13,14,15,16,17,35,41,42,43,46:
            resultImgName = "Snow.png";
        case 8,9,10,11,12,18:
            resultImgName = "Weather.png";
        case 19,20,21,22:
            resultImgName = "Fog Day.png";
        case 26,44:
            resultImgName = "Clouds.png";
        case 27,29:
            resultImgName = "Partly Cloudy Night.png";
        case 28,30:
            resultImgName = "Partly Cloudy Day.png";
        case 31,32,33,34,36:
            resultImgName = "Sun.png";
        case 23,24,25:
            resultImgName = "Windy.png";
        default:
            resultImgName = "Sun.png";
        }
        return UIImage(named: resultImgName)!;
    }
    
    
    static var weatherIconName = [
        "Clouds.png", "Fog Day.png", "Partly Cloudy Day.png", "Partly Cloudy Night.png" , "Partly Cloudy Rain.png" , "Rainy Weather.png", "Snow.png" , "Storm.png" ,"Sun.png" , "Umbrella.png" , "Windy.png" ,"Windy Weather.png"];
    
    static var weather_con = [
        "0":"龍捲風",
        "1":"熱帶風暴",
        "2":"颶風",
        "3":"強雷陣雨",
        "4":"雷陣雨",
        "5":"混合雨雪",
        "6":"混合雨雪",
        "7":"混合雨雪",
        "8":"冰凍小雨",
        "9":"細雨",
        "10":"凍雨",
        "11":"陣雨",
        "12":"陣雨",
        "13":"飄雪",
        "14":"陣雪",
        "15":"吹雪",
        "16":"下雪",
        "17":"冰雹",
        "18":"雨雪",
        "19":"多塵",
        "20":"多霧",
        "21":"陰霾",
        "22":"多煙",
        "23":"狂風大作",
        "24":"有風",
        "25":"冷",
        "26":"多雲",
        "27":"晴間多雲（夜）",
        "28":"晴間多雲（日）",
        "29":"晴間多雲（夜）",
        "30":"晴間多雲（日）",
        "31":"清晰的（夜）",
        "32":"晴朗",
        "33":"晴朗（夜）",
        "34":"晴朗（日）",
        "35":"雨和冰雹",
        "36":"炎熱",
        "37":"雷陣雨",
        "38":"零星雷陣雨",
        "39":"零星雷陣雨",
        "40":"零星雷陣雨",
        "41":"大雪",
        "42":"零星陣雪",
        "43":"大雪",
        "44":"多雲",
        "45":"雷陣雨",
        "46":"陣雪",
        "47":"雷陣雨",
        "3200":"資料錯誤"
    ];

}
