//
//  addTodoListViewController.swift
//  MyDiary
//
//  Created by Gillian on 2016/12/27.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class addTodoListViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var memoItemTextField: UITextField!
    
    @IBAction func addMemoItem(sender: UIButton) {
        let memotext = memoItemTextField.text;
        DiaryDAO.addTodoListContents(memoID, contens: memotext!);
        
    }
    
    var memoID = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoItemTextField.delegate = self;
        // Do any additional setup after loading the view.
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
