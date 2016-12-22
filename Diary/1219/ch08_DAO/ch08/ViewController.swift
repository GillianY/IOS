//
//  ViewController.swift
//  ch08
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(ContactDAO.getContacts().count)
        print(ContactDAO.getContactBySid(2).name)
        print(ContactDAO.getContactsByName("Gina").count)
        
//        let c1 = ContactDAO.getContactBySid(2)
//        ContactDAO.insert(c1)
//        print(ContactDAO.getContacts().count)
//
//        let c4 = ContactDAO.getContactBySid(9)
//        c4.name = ">>>"
//        ContactDAO.update(c4)
//        print(ContactDAO.getContactBySid(9).name)
//        
//        ContactDAO.delete(6)
//        print(ContactDAO.getContacts().count)
//
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

