//
//  ViewController.swift
//  CH04_ModalView
//
//  Created by ucom Apple 13 on 2016/11/29.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit
//import "CodeCV.h " // objectC only

class ViewController: UIViewController {

 
    @IBAction func showXIBviewController(sender: AnyObject) {
         let next = XIBViewController(nibName: "XIBViewController",bundle: nil)
        next.modalTransitionStyle = .PartialCurl 
        self.presentViewController(next, animated: true, completion:nil)
        

        
    }
    @IBAction func showCodeVC(sender: AnyObject) {
        let next = self.storyboard!.instantiateViewControllerWithIdentifier("next")
        
        next.modalTransitionStyle = .FlipHorizontal

        self.presentViewController(next, animated: true, completion:nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

