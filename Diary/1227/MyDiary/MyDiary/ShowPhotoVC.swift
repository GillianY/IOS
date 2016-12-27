//
//  ShowPhotoVC.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/27.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class ShowPhotoVC: UIViewController {
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var NoPhotoInfo: UILabel!
    var diaryID = -1;
    var photoID = -1;
    var DataType = 0; // 0 : showPhoto ; 1:showInfo
    var imgeData :NSData?;
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }

    override func viewWillAppear(animated: Bool) {
        //....
        
        if(DataType == 0) // photo
        {
            photoImage.hidden = false;
            NoPhotoInfo.hidden = true;
            
            photoImage.image =  UIImage(data:  DiaryDAO.getPhotofromPhotoID(photoID)); //UIImage(named: )
        }else{ // shoeinfo
            photoImage.hidden = true;
            NoPhotoInfo.hidden = false;
        }
    }
}
