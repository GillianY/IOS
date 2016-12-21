//
//  PhotoPicker.h
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/21.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPicker : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)shotHandler:(UIBarButtonItem *)sender;


@end
