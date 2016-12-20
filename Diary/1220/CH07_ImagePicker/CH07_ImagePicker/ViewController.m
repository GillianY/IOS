//
//  ViewController.m
//  CH07_ImagePicker
//
//  Created by ucom Apple 13 on 2016/11/30.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController
- (IBAction)photoselectedControl:(UISegmentedControl *)sender {
    
    UIImagePickerController *picker =[[UIImagePickerController alloc]init];
    picker.delegate =self;
    
    if(sender.selectedSegmentIndex ==0){
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else{
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    }
    [self presentViewController:picker animated:true completion:nil ];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *img =info[UIImagePickerControllerOriginalImage];
    self.image.image =img;
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
