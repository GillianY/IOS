//
//  mainDiaryViewController.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/8.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class mainDiaryViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
 
    var diarylist : [DiaryItem]?
    var numbersOfDiaryByYearMonth : [String:Dictionary<String,Int>] = [:] ;
    var keyOfyearsArray = [String]()  ;
    //var years : [String]?;
    
    @IBOutlet weak var naviBar: UINavigationItem!
    @IBOutlet weak var uptoolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        let navigationBar = navigationController!.navigationBar
//        navigationBar.setBackgroundImage(UIImage(named: "BarBackground"),
//                                         forBarMetrics: .Default)
//        navigationBar.shadowImage = UIImage()
        // uptoolbar.layer.borderWidth = 1;
        // uptoolbar.layer.borderColor =  UIColor.clearColor().CGColor;
        // navigationController?.navigationBar.frame.origin.y = 10
        
        setBackgroundTheme("");
        
        // get Diarys and the count , from DB
        numbersOfDiaryByYearMonth = DiaryDAO.getNumbersOfDiaryByYM();
        keyOfyearsArray = Array(numbersOfDiaryByYearMonth.keys).sort{ $0 > $1}; //2016,2015..Desc
        diarylist = DiaryDAO.getDiarys();
        
        self.tableView.delegate = self as UITableViewDelegate;
        self.tableView.dataSource = self as UITableViewDataSource;
        self.tableView.backgroundColor = UIColor.clearColor();
        
       // navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default);
//    navigationController?.navigationBar.shadowImage = UIImage();
//       navigationController?.navigationBar.layer.borderWidth = 0;
      //shadowImage = UIImage();
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // switch (indexPath.section) 
        //indexPath.row
            let cell = tableView.dequeueReusableCellWithIdentifier("diaryCell", forIndexPath: indexPath) as! mainDiaryCell
            cell.backgroundColor = UIColor.clearColor(); // cell.contentView.backgroundColor = UIColor.clearColor();
        
            var arrayIndex = getCellArrayIndex(indexPath.section , row: indexPath.row);
        
            let currentDairy = diarylist![arrayIndex];
            cell.diarytitlelabel?.text = currentDairy.title ;
            cell.timelabel?.text = DiaryItem.dategetTime(currentDairy.date!);
            cell.weeklabel?.text = DiaryItem.dategetMonth(currentDairy.date!);
            cell.daylabel?.text = DiaryItem.dategetDay(currentDairy.date!);
        
            return cell
        }
    
    func getCellArrayIndex(section:Int, row :Int)-> Int {
        
        print("section:\(section) , row:\(row)");
        var currentMaxIndexCount = 0;
        var lastSectionIndex = 0;
        
        for ( var i = 0 ; i < numbersOfDiaryByYearMonth.count ; i += 1 ) //2016,2015, 2014....
        {
            var monthsDic :Dictionary<String,Int> = numbersOfDiaryByYearMonth[keyOfyearsArray[i]]!; //this year Dictionary
            var monthKeysArray = Array(monthsDic.keys).sort { $0 > $1 }; //Month Desc
            
            if( section < (lastSectionIndex +  monthsDic.count) )
            {
                var tempsection = (section - lastSectionIndex );
                
                for(var j = 0 ; j < tempsection ; j += 1)
                {
                    currentMaxIndexCount += monthsDic[monthKeysArray[j]]!;
                }
                var result = (  currentMaxIndexCount + row ) ;
                print("result: \(result)");
                return result;
            
            }else{
                for(var j = 0 ; j < monthKeysArray.count ; j += 1)
                {
                    currentMaxIndexCount += monthsDic[monthKeysArray[j]]!;
                }
            }
        }
        
        print("error in :getCellArrayIndex");
        return 0;
    }
    
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var tmpSection = section;
        for ( var i = 0 ; i < numbersOfDiaryByYearMonth.count ; i += 1 ) //2016,2015, 2014....
        {
            var monthsDic :Dictionary<String,Int> = numbersOfDiaryByYearMonth[keyOfyearsArray[i]]!; //this year Dictionary
            var monthKeysArray = Array(monthsDic.keys).sort { $0 > $1 }; //Month Desc
            if(tmpSection <= monthKeysArray.count)
            {   var whichmonth = monthKeysArray[tmpSection ];
                return monthsDic[whichmonth]!;
            }else{
                tmpSection -= monthKeysArray.count;
            }
        }
        return 0;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numbersOfSections = 0 ;
        
        let keyOfyears =  Array(numbersOfDiaryByYearMonth.keys)
        for keys in keyOfyears{
            let countsDic :Dictionary<String,Int> = numbersOfDiaryByYearMonth[keys]! ;
            numbersOfSections += countsDic.count;
        }
        print("sections:  \(numbersOfSections)");
            return numbersOfSections;
    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("!!!section:::\(section)");
        
        var tmpSection = section+1;
        print("viewForHeaderInSection: \(section) ,numbersOfDiaryByYearMonth.count:\(numbersOfDiaryByYearMonth.count)"); //1,1
        
        for ( var i = 0 ; i < numbersOfDiaryByYearMonth.count ; i += 1 ) //2016,2015..
        {
            var monthsDic :Dictionary<String,Int> = numbersOfDiaryByYearMonth[keyOfyearsArray[i]]!; //this year Dictionary
            var monthKeysArray = Array(monthsDic.keys).sort { $0 > $1 }; //Month Desc
            print("\(tmpSection) : monthKeysArray.count :\(monthKeysArray.count)"); //1,7
            if(tmpSection ==  1 ) //(monthKeysArray.count+1)
            {
                var whichmonth = monthKeysArray[tmpSection - 1 ];
                let cell  = tableView.dequeueReusableCellWithIdentifier("diaryHeaderWithYearCell")  as! dairyHeaderWithYearTVCell ;
                print("cellyear:\(whichmonth) : \(keyOfyearsArray[i]) : \(DiaryItem.monthNames[whichmonth])");
                cell.backgroundColor = UIColor.clearColor();
                cell.yearLabel.text = keyOfyearsArray[i];
                cell.monthLabel.text = DiaryItem.monthNames[whichmonth]!;
               return  cell ;
                
            }else if(tmpSection < (monthKeysArray.count+1)){
                var whichmonth = monthKeysArray[tmpSection - 1 ];
                let cell  = tableView.dequeueReusableCellWithIdentifier("diaryHeaderCell")  as! mainDiaryMonthTVHeaderCell ;
                 print("cellmonth:\(whichmonth) : \(keyOfyearsArray[i]) : \(DiaryItem.monthNames[whichmonth])");
                cell.backgroundColor = UIColor.clearColor();
                cell.monthLabel.text = DiaryItem.monthNames[whichmonth];
              
                return cell;
            }else
            { tmpSection -= monthKeysArray.count;
            }
        }
        print("ohoh");
        return nil;
    }
    
    
    func setBackgroundTheme(theme:String){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"sky2.png")!)
        
    }
    
//    func tableView(tableView:UITableView, titleForHeaderInSection: Int)-> String?
//    {
//        if titleForHeaderInSection == 0 {
//            return "November"
//        }else
//        {
//            return "December"
//        }
//    }
    
    
    
    //get DiaryDatas from DB
    func getDiarylist()->(){
        //get all diary
        diarylist =  [DiaryItem](); // Arraylist
        //var adiaryitem = DiaryItem();
        //diarylist?.append(adiaryitem);
       var adiaryitem2 = DiaryItem();
        adiaryitem2.date = DiaryItem.stringToDate("Wed, 12 Oct 2016 04:35");
        diarylist?.append(adiaryitem2);
        
       var adiaryitem3 = DiaryItem();
        adiaryitem3.date = DiaryItem.stringToDate("Sun, 30 Oct 2016 01:05");
        diarylist?.append(adiaryitem3);
       
        print("count------ \(diarylist!.count)------");
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // list  = ContactDAO.getContacts()
        //print("---------viewWillAppear")
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       // tableView.deselectRowAtIndexPath(indexPath, animated: true);
        print("didSelectRowAtIndexPath");
        var targetDiary :DiaryItem = diarylist![ getCellArrayIndex(indexPath.section , row: indexPath.row)];
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
 
        let next  = self.storyboard!.instantiateViewControllerWithIdentifier("showDiaryView") as! showDiaryViewController ;
        next.modalTransitionStyle =  UIModalTransitionStyle.CoverVertical //.FlipHorizontal//PartialCurl; //.CoverVertical // .OverCurrentContext;
            //UIModalTransitionStyle.PartialCurl;
        next.currentDiary = targetDiary;
        self.presentViewController(next,animated:true , completion: nil);
        
        
        
//        navigationController?.pushViewController(<#T##UIViewController#>, animated: true)
        
    }
    
    
    
//    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//            return ["November","October","December"];
//        }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    




}
