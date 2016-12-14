//
//  ViewController.swift
//  GinaTest
//
//  Created by ucom Apple 13 on 2016/12/13.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uptoolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(named: "BarBackground"),forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
 
        

        
    }
    
  
    override func viewWillAppear(animated: Bool) {
       // let img = UIImage();//UIImage(named: "BarBackground")
        let navigationBar = navigationController!.navigationBar
                navigationBar.setBackgroundImage(UIImage(named: "BarBackground"),
                                                 forBarMetrics: .Default)
                navigationBar.shadowImage = UIImage()
        
        
//                uptoolbar.layer.borderWidth = 1;
//                uptoolbar.layer.borderColor =  UIColor.clearColor().CGColor;
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

