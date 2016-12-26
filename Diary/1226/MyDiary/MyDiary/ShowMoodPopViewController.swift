//
//  ShowMoodPopViewController.swift
//  MyDiary
//
//  Created by Gillian on 2016/12/24.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class ShowMoodPopViewController: UIViewController {

    
    struct faceIcon{
        var selectedIcon: UIImage  = UIImage(named: "f42.jpg")!
        var deselectedIcon : UIImage = UIImage(named:"f41.jpg")!
    }
    
    var sourceVC = addeditDiartyViewController();
    var iconImageArray = [faceIcon]();
    var buttonArray = [UIButton]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceVC =  self.popoverPresentationController?.delegate  as! addeditDiartyViewController ;
        // var sourceVC = self.delegate
        // Do any additional setup after loading the view.
    }

    func setFaceIconImageArray(){
        let sourceIconDeSelectedArray = ["f11.jpg","f21.jpg","f31.jpg","f41.jpg","f51.jpg","f61.jpg","f71.jpg","f81.jpg"];//,"f91.jpg","fa1.jpg"];
        let  sourceIconSelectedArray = ["f12.jpg","f22.jpg","f32.jpg","f42.jpg","f52.jpg","f62.jpg","f72.jpg","f82.jpg"];//,"f92.jpg","fa2.jpg"];
        
        iconImageArray = [faceIcon]();
        for index in 1...8{
            iconImageArray.append(faceIcon(selectedIcon:UIImage(named:sourceIconSelectedArray[index])! , deselectedIcon : UIImage(named: sourceIconDeSelectedArray[index])!)) ;
            var a = UIButton();
            a.addTarget(self, action: "setSelectedIconImgs" , forControlEvents: .TouchUpInside)
            a.addTarget(self, action: "setSelectedIconImgs:" , forControlEvents: .TouchUpInside)
            a.addTarget(self, action: "setSelectedIconImgs:_" , forControlEvents: .TouchUpInside)

            //#selector(myClass.pressed(_:))
        }
    
    }
    func setSelectedIconImgs(index : Int){
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
