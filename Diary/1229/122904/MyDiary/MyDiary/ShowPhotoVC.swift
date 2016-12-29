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
    
    
    @IBAction func closeView(sender: UIButton) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //photoImage.hidden = false;
       // NoPhotoInfo.hidden = false;

        
        if(DataType == 0) // photo
        {
            photoImage.image =  UIImage(data:  DiaryDAO.getPhotofromPhotoID(photoID)); //UIImage(named: )
            
            photoImage.hidden = false;
            NoPhotoInfo.hidden = true;
            
            print("tetst");
        }else{ // shoeinfo
            photoImage.hidden = true;
            NoPhotoInfo.hidden = false;
            print("no photo");
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        //....
        
         }
}
