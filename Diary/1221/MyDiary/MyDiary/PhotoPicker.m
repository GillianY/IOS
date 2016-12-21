//
//  PhotoPicker.m
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/21.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "PhotoPicker.h"

@implementation PhotoPicker

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.navigationItem.rightBarButtonItem = nil;
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"裝置" message:@"裝置不支援相機功能！！" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [myAlertView show];
    }


}


- (IBAction)shotHandler:(UIBarButtonItem *)sender {
    UIImagePickerController *imgPickerUI = [UIImagePickerController new];
    imgPickerUI.delegate = self;
    imgPickerUI.allowsEditing = YES;
    [imgPickerUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:imgPickerUI animated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError :contextInfo:),nil);
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error){
        UIAlertView *alert = [[UIAlertView alloc]
                                initWithTitle:@"存檔失敗" message:@"無法儲存照片" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil
                              ];
    }

}

#pragma mark - UIImagePickerControllerDelegate
@end
