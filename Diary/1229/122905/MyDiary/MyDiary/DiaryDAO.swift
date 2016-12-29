//
//  DiaryDAO.swift
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

@objc class DiaryDAO : NSObject
    {
    static var dbPath :String {
        let target = "\(NSHomeDirectory())/Documents/MyDiary.sqlite"
        let fileMgr = NSFileManager.defaultManager();
        if !fileMgr.fileExistsAtPath(target){
            let source = NSBundle.mainBundle().pathForResource("MyDiary", ofType: "sqlite")
            //try? fileMgr.copyItemAtPath(source!, toPath: target)
                        do{
                             try fileMgr.copyItemAtPath(source!, toPath: target)
                        }catch  { // seldom
                            print("!!!!error!!!!!");
                        } //很少用這個 因為通常會先確定 , 除非網路下來的東西 ,但也會先確定是否存在連線
        }
        print("path::::\(target)");
        return target
    }
    
    
    static func hasPhotoDatabyPhotoID(photoID : Int)-> Bool{
        var answer: Bool = false;
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        
        var result = db.executeQuery("SELECT photo FROM Diary_photos where rowID= ?", withArgumentsInArray: [photoID]);
        
        while result.next(){
            if(result != nil)
            {
                if(!(result.dataForColumn("photo") == nil))
                { answer = true;}
            }
            else
            {
                print("result nil") ;
            }
        }
        db.close();
        return answer;
    }
    
    static func getNewPhotoID() -> Int{
        
        var lastrowid = 0;
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("insert into Diary_photos(gps_latitude) values (-1) ", withArgumentsInArray: [])
        let result = db.executeQuery("SELECT max(rowid)as maxrow FROM Diary_photos", withArgumentsInArray: []);
        while result.next(){
          lastrowid = Int(result.intForColumn("maxrow"));
        }
        db.close();
        //"delete  from Diary_photos where rowid = 1"
        return lastrowid;
    }
    
    static func updatePhotoInfo(photoItemData : photoItem){
        var dict = [String: AnyObject]();  // [NSDictionary]();
        dict["did"] = photoItemData.did
        dict["rowID"] = photoItemData.rowid
        //dict["photo"] = photoItemData.photodata
        dict["gps_latitude"] = photoItemData.gps_latitude
        dict["gps_longtitude"] = photoItemData.gps_longtitude
       
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("update diary_photos set did=:did where rowid = :rowID", withParameterDictionary: dict)
        
        db.close()
    }
    
//    static func getPhotoFromDID(){
//    }
    
//    static func RowIDhasPhotoData(photoID: Int) -> Bool
//    {
//        let db = FMDatabase(path : DiaryDAO.dbPath)
//        db.open();
//        
//    }
    
    static func getPhotofromPhotoID(photoID: Int) -> NSData {
        var resultphoto : NSData = NSData();
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        //var dict = [String: AnyObject]();  // [NSDictionary]
        
        let result = db.executeQuery( "select  photo from Diary_photos  where rowid =?" , withArgumentsInArray: [ photoID])
        
        
        while result.next(){
            resultphoto =  result.dataForColumn("photo"); //Int(result.intForColumn("rowID"));
            //print("getNewPhotoIDByDID:\(did)");
        }
        db.close()
        return resultphoto ;
    }
    
    
    static func updateDidToPhotoData(did : Int , rowid :Int)
    {
        var dict = [String: AnyObject]();
        dict["did"] = did ;
        dict["rowid"] = rowid ;
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("update diary_photos set did =:did where rowid = :rowid", withParameterDictionary: dict) ;
        db.close()
    
    }
    
    
    static func updatePhotodata(photoItemData : photoItem){
        var dict = [String: AnyObject]();  // [NSDictionary]();
        
        dict["rowID"] = photoItemData.rowid
        dict["photo"] = photoItemData.photodata
        dict["gps_latitude"] = photoItemData.gps_latitude
        dict["gps_longtitude"] = photoItemData.gps_longtitude
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        let result = db.executeUpdate("update diary_photos set photo =:photo where rowid = :rowID", withParameterDictionary: dict) ;
        db.close()
        //dict = nil;
    }
    
    static func getPhotoIDsbyDID(did : Int) -> Int{
        var photoID = -1;
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        let result = db.executeQuery( "select rowID from Diary_photos  where did =?" , withArgumentsInArray: [did])
        
        while result.next(){
            photoID =  Int(result.intForColumn("rowID"));
            print("getPhotoIDsbyDID:\(did) \(photoID)");
        }
         // print("getPhotoIDsbyDID: isEMPty pHoto \(did) ");
        
        db.close();
        return photoID;
    }

    
//    static func getNewPhotoIDByDID(did : Int) -> Int{
//        var lastrowid = 0;
//        let db = FMDatabase(path : DiaryDAO.dbPath)
//        db.open();
//        
//        var result = db.executeQuery( "select rowid from Diary_photos  where did = ?" , withArgumentsInArray: [ did ] )
//        
//        if(result != nil ){
//            print("\(did) had photo ");
//            while result.next(){
//                lastrowid = Int(result.intForColumn("rowid"));
//                print("getoldPhotoIDByDID:\(did) : \(lastrowid)");
//            }
//        }else{
//            db.executeUpdate("insert into Diary_photos(did) values (?) ", withArgumentsInArray: [did])
//            result = db.executeQuery("SELECT max(rowid) as rowid FROM Diary_photos", withArgumentsInArray: []);
//            
//            while result.next(){
//                lastrowid = Int(result.intForColumn("rowID"));
//                print("getNewPhotoIDByDID:\(did)");
//            }
//        }
//        db.close();
//        
//        //"delete  from Diary_photos where rowid = 1"
//        return lastrowid;
//    }
    
    
    //---
    static func getNewPhotoIDByDID(did : Int) -> Int{
        var lastrowid = 0;
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("insert into Diary_photos(did) values (?) ", withArgumentsInArray: [did])
        let result = db.executeQuery("SELECT max(rowid) FROM Diary_photos", withArgumentsInArray: []);
        
        while result.next(){
            lastrowid = Int(result.intForColumn("rowID"));
            print("getNewPhotoIDByDID:\(did)");
        }
        db.close();
        
        //"delete  from Diary_photos where rowid = 1"
        return lastrowid;
    }
    //---
    
    
    //todo : limit data in one year
    static func getDiarys() -> [DiaryItem] {
        var diarys :[DiaryItem] = [DiaryItem]()
        let db = FMDatabase(path: DiaryDAO.dbPath)
        
        db.open()
       // let result = db.executeQuery("Select * from  Diary order by date desc", withArgumentsInArray: [])
         let result = db.executeQuery(
            "select  substr(date,1,4)as year,substr(date,6,2)as month,* from Diary  order by year Desc,month Desc,date Desc" , withArgumentsInArray: []) ;

        var counter = 0;
        while result.next(){
            counter += 1;
            let data = DiaryItem();
            
            data.did = Int(result.intForColumn("did"))
            data.title = result.stringForColumn("title")
            data.contents = result.stringForColumn("Contents")
            data.date = DiaryItem.stringToDate(result.stringForColumn("date"))
            data.year = Int(result.stringForColumn("year"))!;
            data.month = Int(result.stringForColumn("month"))!;
            data.mood = Int(result.intForColumn("mood"))
            data.weather = Int(result.intForColumn("weather"))
           // data.time = stringForColumn("time"); //should add db
           // data.photo = result.dataForColumn("photo")
            diarys.append(data);
            
           // print("data contents: \(data.contents)");
            
        }
      //  print("count:\(counter)");
        db.close();
        
        return diarys;
    }
  
    
  
    
    static func getDiaryByDid(did : Int)-> DiaryItem{
        let data :DiaryItem = DiaryItem()
        let db = FMDatabase(path: DiaryDAO.dbPath)
        db.open()
        let result = db.executeQuery("Select substr(date,1,4)as year,substr(date,6,2)as month,* from  Diary where did = ? ", withArgumentsInArray: [did])
        while result.next(){
            data.year = Int(result.stringForColumn("year"))!;
            data.month = Int(result.stringForColumn("month"))!;
            data.did = Int(result.intForColumn("sid"))
            data.title = result.stringForColumn("title")
            data.contents = result.stringForColumn("Contents")
           // data.date = DiaryItem.dateToString(result.stringForColumn("date"));
            data.mood = Int(result.intForColumn("mood"))
            data.weather = Int(result.intForColumn("weather"))

        }
        db.close();
        
        return data;
    }
    
    static func getDiarysByDate(date : String)-> [DiaryItem]{
        var diarys :[DiaryItem] = [DiaryItem]()
        let db = FMDatabase(path: DiaryDAO.dbPath)
        db.open()
        //let namecon = "'%"+name+"%'"
        //        let result = db.executeQuery("Select * from  Contacts where name = ? ", withArgumentsInArray: [name]) // no need ''
        //where name like \(namecon)
        let result = db.executeQuery("Select substr(date,1,4)as year,substr(date,6,2)as month,* from  Diary where date = ? ", withArgumentsInArray: [date])
        
        while result.next(){
            let data = DiaryItem();
            data.did = Int(result.intForColumn("sid"))
            data.title = result.stringForColumn("title")
            data.contents = result.stringForColumn("Contents")
            data.date = DiaryItem.stringToDate(result.stringForColumn("date"))
            data.mood = Int(result.intForColumn("mood"))
            data.weather = Int(result.intForColumn("weather"))
            diarys.append(data);
        }
        db.close();
        
        return diarys;
    }
    
    static func getNumbersOfDiaryByYM() -> Dictionary<String,Dictionary<String,Int>> {
        var Numbers = [String : Dictionary<String,Int> ]();
        let querystr = "select  substr(date,1,4)as year,substr(date,6,2)as month ,count(did) as diarys from Diary  group by year,month order by year Desc ,month Desc";
        let db = FMDatabase(path: DiaryDAO.dbPath)
        db.open()
      
        let result = db.executeQuery(querystr, withArgumentsInArray: [])
        
        while( result.next() ){
            var  years :String = result.stringForColumn("year")
            print("Numbers[years]: \(Numbers[years])");
            if( Numbers[years] == nil)
            { Numbers[years] = [String:Int]();
                print("set  [String:Int]() : \(Numbers[years])");
            }
                var innerDic = Numbers[years];
                var months = result.stringForColumn("month")
                innerDic![months] = Int(result.intForColumn("diarys"));
                (Numbers[years])![months] = Int(result.intForColumn("diarys"));
             //   print("counts::\(years),\(months),\(innerDic![months]!) ,\((Numbers[years])![months])");
          //  print("Dictionary :\(Numbers["2016"])");
            
        }
        db.close();
        
        return Numbers;
    
    }
    
    // add!!!
//    static func isNewDiary(did : Int)-> Bool{
//    
//        return false;
//    }
    
    static func insert(data:DiaryItem)-> Int{
        var thisDid = -1;
        var dict = [String: AnyObject]();  // [NSDictionary]();
     // dict["did"] = data.did
        dict["title"] = data.title
        dict["contents"] = data.contents!
        dict["date"] = DiaryItem.dateToString(data.date!)
        dict["weather"] = data.weather
        dict["mood"] = data.mood
      //  print("insert :\(dict["date"]),\(dict["title"]),\(  dict["weather"]),\(dict["mood"]),\(dict["contents"])");
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("INSERT INTO Diary (date,title,weather,mood,Contents ) VALUES (:date,:title,:weather,:mood,:contents) ", withParameterDictionary: dict);
        
       let result = db.executeQuery("Select max(did)as did from  Diary ", withArgumentsInArray: [])
        while result.next(){
            thisDid = Int(result.intForColumn("did"));
        }
        db.close();
        
        return thisDid;
    }
    
    static func update(data:DiaryItem){
        var dict = [String: AnyObject]();  // [NSDictionary]();
        dict["did"] = data.did
        dict["title"] = data.title
        dict["contents"] = data.contents
        dict["date"] = DiaryItem.dateToString(data.date!)
        dict["weather"] = data.weather
        dict["mood"] = data.mood
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("update Diary set date=:date,title=:title,weather=:weather,mood=:mood,contents=:contents where did =:did", withParameterDictionary: dict)
        db.close()
    }
    
    static func Diarydelete(did:Int){
        
        var dict = [String: AnyObject]();  // [NSD ictionary]();
        dict["did"] = did
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("delete  from  Diary where did =:did", withParameterDictionary: dict)
        db.close()
    }
    
    static func Photodelete(rowID:Int){
        
        var dict = [String: AnyObject]();  // [NSD ictionary]();
        dict["rowID"] = rowID
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("delete  from  Diary_photos where rowID =:rowID", withParameterDictionary: dict)
        db.close()
    }
    
    
    static func getTodoListItemsBymiD(listID :Int)-> [ToDoListItem]
    {
        var result = [ToDoListItem]();
        var item = ToDoListItem();
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        let items = db.executeQuery("select miid,title  from MemoItems where mid = ?", withArgumentsInArray: [listID])
        while items.next(){
            item = ToDoListItem();
            item.mid = listID;
            item.miid = Int(items.intForColumn("miid"));
            item.title = items.stringForColumn("title");
            result.append(item) ;
            print("getTodoListItemsBymiD \(item.miid) : \(item.title)");
        }
        db.close();
      return result;
    }
    
    static func getMemoGroupTitle(mid: Int)-> String{
         var MemoTitle = "";
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        let items = db.executeQuery("select title  from MemoGroups where mgid = ?", withArgumentsInArray: [mid])
        while items.next(){
            MemoTitle = items.stringForColumn("title");
        }
        db.close();
        return MemoTitle;
    }
    
    
    //for todolist
    static func addTodoListContents(listid :Int , contens :String){
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        var dict = [String: AnyObject]();  // [NSD ictionary]();
        dict["mID"] = listid
        dict["title"] = contens
        
        db.executeUpdate("insert into memoitems (mid,title) values (:mID,:title)", withParameterDictionary: dict)
        //insert into MemoGroups(title,isDeleted,themeID)  values ("禁止事項", 0 , 1 )
        db.close();
      }
    
    
    static func updateTodoList(miid :Int, title:String ){
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        var dict = [String: AnyObject]();  // [NSD ictionary]();
        dict["miid"] = miid
        dict["title"] = title
        
        db.executeUpdate("update memoitems set title=:title where miid = :miid ", withParameterDictionary: dict)
        db.close();
    }
    
    static func deleteTodoList(miid: Int){
        print("deleteTodoList: \(miid)");
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        var dict = [String: AnyObject]();  // [NSD ictionary]();
        dict["miid"] = miid ;
        db.executeUpdate("delete from memoitems where miid = :miid ", withParameterDictionary: dict)
        db.close();
        print("deleteTodoList");
    
    }
    
}
