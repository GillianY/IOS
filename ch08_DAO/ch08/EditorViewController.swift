//
//  EditorViewController.swift
//  ch08
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController ,UITextFieldDelegate{

    var sid = 0
    var current = Contact()
    //textField
    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    
    @IBAction func savehandler(sender: UIBarButtonItem) {
        current.name = nameInput.text!
        current.address = addressInput.text!
        
        current.photo =  UIImagePNGRepresentation( photoImg.image!) // UIImage -> NSData
        if sid == 0 {
            ContactDAO.insert(current)
        }else{
            ContactDAO.update(current)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func phtotPickerahndler(sender: UISegmentedControl) {
    
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if sid == 0{
            self.title  = "New"
        }else
        {
            self.title = "Edit"
            current = ContactDAO.getContactBySid(sid)
            nameInput.text = current.name as String
            addressInput.text = current.address as String
            if current.photo != nil{
                photoImg.image = UIImage(data: current.photo!)
            }
        }
        
        nameInput.delegate  = self
        addressInput.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
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
