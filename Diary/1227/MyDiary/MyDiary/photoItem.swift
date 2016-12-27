//
//  photoItem.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/22.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class photoItem: NSObject {
    var photodata : NSData?;
    var did :Int?;
    var rowid :Int?;
    var gps_latitude : String;
    var gps_longtitude : String;
    
    
    override init() {
        did = 0;
        rowid = 0 ;
        photodata = nil;
        gps_latitude = "0" ;
       gps_longtitude = "0";
    }
}
