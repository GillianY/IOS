//
//  ContactDAO.swift
//  ch08
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class ContactDAO { //: NSObject
    
    static var dbPath :String {
        let target = "\(NSHomeDirectory())/Documents/Untitled.sqlite"
        let fileMgr = NSFileManager.defaultManager();
        if !fileMgr.fileExistsAtPath(target){
            let source = NSBundle.mainBundle().pathForResource("Untitled", ofType: "sqlite")
            try? fileMgr.copyItemAtPath(source!, toPath: target)
//            do{
//                 try fileMgr.copyItemAtPath(source!, toPath: target)
//            }catch  { // seldom
//            } //很少用這個 因為通常會先確定 , 除非網路下來的東西 ,但也會先確定是否存在連線
        }
        return target
    }
    
    static func getContacts() -> [Contact] {
        var contacts :[Contact] = [Contact]()
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        let result = db.executeQuery("Select * from  Contacts order by sid desc", withArgumentsInArray: [])
        while result.next(){
            let data = Contact();
            data.sid = Int(result.intForColumn("sid"))
            data.name = result.stringForColumn("name")
            data.address = result.stringForColumn("address")
            data.photo = result.dataForColumn("photo")
            contacts.append(data);
        }
        
        db.close();
        
        return contacts;
    }
    
    static func getContactBySid(sid : Int)-> Contact{
        let data :Contact = Contact()
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        let result = db.executeQuery("Select * from  Contacts where sid = ? ", withArgumentsInArray: [sid])
        while result.next(){
            data.sid = Int(result.intForColumn("sid"))
            data.name = result.stringForColumn("name")
            data.address = result.stringForColumn("address")
            data.photo = result.dataForColumn("photo")
                    }
        
        db.close();
        
        return data;
    
    }
    
    static func getContactsByName(name : String)-> [Contact]{
        var contacts :[Contact] = [Contact]()
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        let namecon = "'%"+name+"%'"
//        let result = db.executeQuery("Select * from  Contacts where name = ? ", withArgumentsInArray: [name]) // no need ''
         let result = db.executeQuery("Select * from  Contacts where name like \(namecon) ", withArgumentsInArray: [])
        
        while result.next(){
            let data = Contact();
            data.sid = Int(result.intForColumn("sid"))
            data.name = result.stringForColumn("name")
            data.address = result.stringForColumn("address")
            data.photo = result.dataForColumn("photo")
            contacts.append(data);
        }
        
        db.close();
        
        return contacts;

    }
    
    static func insert(data:Contact){
        
        var dict = [String: AnyObject]();  // [NSDictionary]();
       // dict["s"] = data.sid
        dict["n"] = data.name
        dict["a"] = data.address
        dict["p"] = data.photo
        
        let db = FMDatabase(path : ContactDAO.dbPath)
        db.open();
        db.executeUpdate("INSERT INTO Contacts (name,address,photo ) VALUES (:n,:a,:p) ", withParameterDictionary: dict)
        db.close()

    }
    
   static func update(data:Contact){
        var dict = [String: AnyObject]();  // [NSDictionary]();
        dict["s"] = data.sid
        dict["n"] = data.name
        dict["a"] = data.address
        dict["p"] = data.photo
        
        let db = FMDatabase(path : ContactDAO.dbPath)
        db.open();
        db.executeUpdate("UPdate Contacts set name=:n,address=:a,photo=:p where sid =:s", withParameterDictionary: dict)
        db.close()
    }
    static func delete(sid:Int){
        
        var dict = [String: AnyObject]();  // [NSD ictionary]();
        dict["s"] = sid
        
        let db = FMDatabase(path : ContactDAO.dbPath)
        db.open();
        db.executeUpdate("delete  from  Contacts where sid =:s", withParameterDictionary: dict)
        db.close()

    }
    
}
