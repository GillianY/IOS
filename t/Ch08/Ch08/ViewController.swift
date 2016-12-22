//
//  ViewController.swift
//  Ch08
//
//  Created by ucom Apple Instructor on 2016/11/30.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(ContactDAO.getContacts().count)
//        print(ContactDAO.getContactsByName("鋼鐵").count)
//        print(ContactDAO.getContactBySid(2).name)
//        let c1 = ContactDAO.getContactBySid(3)
        //Insert Test
        //ContactDAO.insert(c1)
//        print(ContactDAO.getContacts().count)
//        //Update Test
//        let c4 = ContactDAO.getContactBySid(4)
//        c4.name = ">>>"
//        ContactDAO.update(c4)
//        print(ContactDAO.getContactBySid(4).name)
        //Delete Test
        ContactDAO.delete(4)
        print(ContactDAO.getContacts().count)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

