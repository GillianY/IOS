//
//  segTitleNavigationBar.swift
//  GinaTest
//
//  Created by ucom Apple 13 on 2016/12/14.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

import UIKit

class segTitleNavigationBar: UINavigationBar {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var newSize:CGSize = CGSizeMake( self.superview!.frame.size.width, 87);
        return newSize;
    }
  
}
