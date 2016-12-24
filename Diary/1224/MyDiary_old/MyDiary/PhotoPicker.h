//
//  PhotoPicker.h
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/21.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoPicker : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic) int did ;
@property (nonatomic) int rowID;
@property (strong ,nonatomic) NSData *photoData ;
@property (strong,nonatomic) NSString* querystring;
@property (strong,nonatomic) NSDictionary *dict;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property ( nonatomic)int diaryDid ;
- (IBAction)shotPhoto:(UIBarButtonItem *)sender;
- (IBAction)pickPhotoDone:(UIBarButtonItem *)sender;

- (IBAction)CancelPickPhoto:(UIBarButtonItem *)sender;

- (IBAction)pickPhoto:(UIBarButtonItem *)sender;
-(void) savePhotoToDB;

@end
