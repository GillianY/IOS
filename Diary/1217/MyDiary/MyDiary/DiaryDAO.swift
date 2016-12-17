//
//  DiaryDAO.swift
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class DiaryDAO { //: NSObject
    
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
        print("\(target)");
        return target
    }
    
    //todo : limit data in one year
    static func getDiarys() -> [DiaryItem] {
        var diarys :[DiaryItem] = [DiaryItem]()
        let db = FMDatabase(path: DiaryDAO.dbPath)
        
        db.open()
        let result = db.executeQuery("Select * from  Diary order by date desc", withArgumentsInArray: [])
        var counter = 0;
        while result.next(){
            counter += 1;
            let data = DiaryItem();
            data.did = Int(result.intForColumn("did"))
            data.title = result.stringForColumn("title")
            data.contents = result.stringForColumn("Contents")
            data.date = DiaryItem.stringToDate(result.stringForColumn("date"))
            data.mood = Int(result.intForColumn("mood"))
            data.weather = Int(result.intForColumn("weather"))
           // data.time = stringForColumn("time"); //should add db
           // data.photo = result.dataForColumn("photo")
            diarys.append(data);
            
            
        }
        print("count:\(counter)");
        db.close();
        
        return diarys;
    }
  
    
  
    
    static func getDiaryByDid(did : Int)-> DiaryItem{
        let data :DiaryItem = DiaryItem()
        let db = FMDatabase(path: DiaryDAO.dbPath)
        db.open()
        let result = db.executeQuery("Select * from  Diary where did = ? ", withArgumentsInArray: [did])
        while result.next(){
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
        let result = db.executeQuery("Select * from  Diary where date = ? ", withArgumentsInArray: [date])
        
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
    // add!!!
    static func isNewDiary(did : Int)-> Bool{
    
        return false;
    }
    
    static func insert(data:DiaryItem){
        
        var dict = [String: AnyObject]();  // [NSDictionary]();
     // dict["did"] = data.did
        dict["title"] = data.title
        dict["contents"] = data.contents!
        dict["date"] = DiaryItem.dateToString(data.date!)
        dict["weather"] = data.weather
        dict["mood"] = data.mood
        print("insert :\(dict["date"]),\(dict["title"]),\(  dict["weather"]),\(dict["mood"]),\(dict["contents"])");
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("INSERT INTO Diary (date,title,weather,mood,Contents ) VALUES (:date,:title,:weather,:mood,:contents) ", withParameterDictionary: dict)
        print("insert data!");
       //  db.executeUpdate("INSERT INTO Diary (date,title,weather,mood,Contents ) VALUES (:date,'2',1,1,'4') ", withParameterDictionary: dict)
        //print("insert data!");
        db.close()
        
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
    
    static func delete(did:Int){
        
        var dict = [String: AnyObject]();  // [NSD ictionary]();
        dict["did"] = did
        
        let db = FMDatabase(path : DiaryDAO.dbPath)
        db.open();
        db.executeUpdate("delete  from  Diary where did =:did", withParameterDictionary: dict)
        db.close()
    }
    
}
