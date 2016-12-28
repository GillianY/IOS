//
//  EditDiaryTextFieldDelegate.swift
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/23.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class EditDiaryTextFieldDelegate:UIView, UITextFieldDelegate {
    var editArea :Int = 0; // 0: textField , 1:textView
    var editTextFiled :Bool = false ;
    var txField :UITextField = UITextField();
    
    //init{ }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    func textFieldDidBeginEditing(textField: UITextField) {
        editTextFiled = true ;
        editArea = 0 ;
        txField = textField;
       // print("textFieldBeginEditingendEdit");

    }
    func textFieldDidEndEditing(textField: UITextField) {
       // print("textFieldDidEndEditingendEdit");
    }
    
    func resignKeyboardtxfiled(textField: UITextField){
       // print("keytxfield");
        txField.resignFirstResponder();
    }
    
   

}
