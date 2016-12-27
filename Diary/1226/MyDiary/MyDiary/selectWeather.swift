//
//  selectWeather.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/26.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class selectWeather: UIViewController ,NSURLSessionDelegate, NSURLSessionDownloadDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var iconTable: UITableView!
    
    
    @IBOutlet weak var chooseWeather: UIImageView!
    var weatherID = 8; //Sun
    
    static var weatherIconName = [
    "Clouds.png", "Clouds.png", "Partly Cloudy Day.png", "Partly Cloudy Night.png" , "Partly Cloudy Rain.png" , "Rainy Weather.png", "Snow.png" , "Storm.png" ,"Sun.png" , "Umbrella.png" , "Windy.png" ,"Windy Weather.png"];
    
    
    var OriginalView = addeditDiartyViewController();
    var JsondataArray = [String:String]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        getJsonFromSession();  //getWeather
       // print("123");
        iconTable.delegate = self;
        iconTable.dataSource = self;
        
      
       // print("test\(JsondataArray.count)");
    
    }
    
    override func viewWillAppear(animated: Bool) {
          OriginalView = self.popoverPresentationController?.delegate as! addeditDiartyViewController ;
    }
    
    func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("weatherIconCell", forIndexPath: indexPath) ;
        cell.backgroundColor = UIColor.clearColor();
        cell.tag = indexPath.row;
        
        //let screenSize: CGRect = UIScreen.mainScreen().bounds
       // image.frame = CGRectMake(0,0, screenSize.height * 0.2, 50)

        cell.imageView?.frame = CGRectMake(0,0, 20, 20)
        cell.imageView?.image = UIImage(named:selectWeather.weatherIconName[indexPath.row]);
        return cell;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  selectWeather.weatherIconName.count;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        weatherID = indexPath.row;
        var chooseIconImage =  UIImage(named:selectWeather.weatherIconName[weatherID]);
        chooseWeather.image =  chooseIconImage
        
        let workingQueue = dispatch_queue_create("my_queue", nil)
        //from
       
        
        
        //reload ?
        // settinging
    }
    
    
    
    
    // 派发到刚创建的队列中，GCD 会负责进行线程调度
   func dispatch_async(_: workingQueue) {
    // 在 workingQueue 中异步进行
    print("努力工作")
    NSThread.sleepForTimeInterval(2)  // 模拟两秒的执行时间
    OriginalView.weatherBtn.tag = weatherID;
    OriginalView.weatherBtn.imageView?.image =   UIImage(named:selectWeather.weatherIconName[weatherID]);
    
    
        dispatch_async(dispatch_get_main_queue()) {
            // 返回到主线程更新 UI
            OriginalView.weatherBtn.tag = weatherID;
            OriginalView.weatherBtn.imageView?.image =   UIImage(named:selectWeather.weatherIconName[weatherID]);
            OriginalView.weatherBtn.reload();
            print("结束工作，更新 UI")
    }
    }
    
    
    func getJsonFromSession(){
    //台北市立動物園公開資料網址
        let url = NSURL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%202306179%20and%20u%3D%22c%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys");
        //"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&amp;rid=a3e2b221-75e0-45c1-8f97-75acbd43d613"
    
    //建立一般的session設定
    let sessionWithConfigure = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    //設定委任對象為自己
    let session = NSURLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    
    //設定下載網址
    let dataTask = session.downloadTaskWithURL(url!)
    
    //啟動或重新啟動下載動作
    dataTask.resume()
    
        //    if let split = self.splitViewController {
        //    let controllers = split.viewControllers
        //    self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        //}
        
    }
    
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        do {
            
            //JSON資料處理
            let dataDic = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: location)!, options: NSJSONReadingOptions.MutableContainers) as! [String:[String: AnyObject]]
            
            //依據先前觀察的結構，取得result對應中的results所對應的陣列
            var dataArray = dataDic["query"]! as! [String:AnyObject];
            dataArray = dataArray["results"] as! [String:AnyObject];
            dataArray = dataArray["channel"] as! [String:AnyObject];
            dataArray = dataArray["item"] as! [String:AnyObject];
            JsondataArray = dataArray["condition"] as! [String:String];
            
            codeLabel.text = selectWeather.weather_con[JsondataArray["code"]!] // 11 rain
            //JsondataArray["code"]
            tempLabel.text = JsondataArray["temp"]
            dateLabel.text = JsondataArray["date"]
            
            print("\(JsondataArray["code"]) , \(JsondataArray["date"]) , \(JsondataArray["temp"])");
            
            
            } catch {
            print("Error!")
        }
        print("hello");
    }
    
    func getJsonFromNetwork22(){
        let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%202306179%20and%20u%3D%22c%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // or if you think the conversion might actually fail (which is unlikely if you built `parameters` yourself)
        //
         do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(NSData(), options: [])
         } catch {
            print(error)
         }
        
//        let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
//        println(dataString)
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard let data = data where error == nil else {
                print("error: \(error)")
                return
            }
            
            // this, on the other hand, can quite easily fail if there's a server error, so you definitely
            // want to wrap this in `do`-`try`-`catch`:
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                    let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
                    print("Success: \(success)")
                } else {
                    let jsonStr = String(data: data, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = String(data: data, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        
        task.resume()


    
    }
    
    
    
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
