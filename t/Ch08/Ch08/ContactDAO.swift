//
//  ContactDAO.swift
//  Ch08
//
//  Created by ucom Apple Instructor on 2016/11/30.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

import UIKit

class ContactDAO{
    static var dbPath : String{
        let target = "\(NSHomeDirectory())/Documents/db.sqlite"
        let fileMgr = NSFileManager.defaultManager()
        if !fileMgr.fileExistsAtPath(target) {
            let source = NSBundle.mainBundle().pathForResource("db", ofType: "sqlite")
            try? fileMgr.copyItemAtPath(source!, toPath: target)
//            do{
//                try fileMgr.copyItemAtPath(source!, toPath: target)
//            }catch{
//                
//            }
        }
        return target;
    }
    
    static func getContacts()->[Contact]{
        var ret = [Contact]()
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        let result = db.executeQuery("SELECT * FROM Contacts", withArgumentsInArray: [])
        while result.next(){
            let data = Contact()
            data.sid = Int(result.intForColumn("sid"))
            data.name = result.stringForColumn("name")
            data.address = result.stringForColumn("address")
            data.photo = result.dataForColumn("photo")
            ret.append(data)
        }
        db.close()
        return ret
    }
    
    static func getContactBySid(sid : Int)->Contact{
        let data = Contact()
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        let result = db.executeQuery("SELECT * FROM Contacts WHERE sid = \(sid)", withArgumentsInArray: [])
        while result.next(){
            data.sid = Int(result.intForColumn("sid"))
            data.name = result.stringForColumn("name")
            data.address = result.stringForColumn("address")
            data.photo = result.dataForColumn("photo")
            break;
        }
        db.close()
        return data

    }
    static func getContactsByName(name : String)->[Contact]{
        var ret = [Contact]()
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        let nameCondition =  "'%"+name+"%'"
        let result = db.executeQuery("SELECT * FROM Contacts WHERE name like \(nameCondition)", withArgumentsInArray: [])
        while result.next(){
            let data = Contact()
            data.sid = Int(result.intForColumn("sid"))
            data.name = result.stringForColumn("name")
            data.address = result.stringForColumn("address")
            data.photo = result.dataForColumn("photo")
            ret.append(data)
        }
        db.close()
        return ret
    }
    
    static func insert(data:Contact){
        //P8-11
        var dict = [String:AnyObject]()
        dict["n"] = data.name
        dict["a"] = data.address
        dict["p"] = data.photo
        
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        db.executeUpdate("INSERT INTO Contacts (name,address,photo) VALUES(:n,:a,:p)", withParameterDictionary: dict)
        db.close()
    }
    static func update(data:Contact){
        //P8-15
        var dict = [String:AnyObject]()
        dict["s"] = data.sid
        dict["n"] = data.name
        dict["a"] = data.address
        dict["p"] = data.photo
        
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        db.executeUpdate("UPDATE Contacts SET name=:n,address=:a,photo=:p WHERE sid = :s", withParameterDictionary: dict)
        db.close()
    }
    static func delete(sid:Int){
        //P8-13
        var dict = [String:AnyObject]()
        dict["s"] = sid
        
        let db = FMDatabase(path: ContactDAO.dbPath)
        db.open()
        db.executeUpdate("DELETE FROM Contacts WHERE sid = :s", withParameterDictionary: dict)
        db.close()
    }
}
