//
//  ViewController.m
//  Ch07
//
//  Created by ucom Apple Instructor on 2016/11/30.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)photoChooserHandler:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoChooserHandler:(UISegmentedControl *)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if (sender.selectedSegmentIndex == 0){
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"imagePickerControllerDidCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"didFinishPickingMediaWithInfo");
    UIImage * img = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = img;
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
