//
//  ViewController.m
//  ch05_Drawer
//
//  Created by ucom Apple 13 on 2016/12/1.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int dx;
   }
@property (strong,nonatomic) UIView * drwawer;
//int dx ;
- (IBAction)drawerhandler:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dx =0;
        self.drwawer =[[UIView alloc]initWithFrame:CGRectMake(dx-300, 0, 300, self.navigationController.view.frame.size.height)];
    self.drwawer.backgroundColor =[UIColor purpleColor];
    [self.navigationController.view addSubview:self.drwawer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawerhandler:(id)sender {
  
    CGRect rect = self.navigationController.view.frame;
    [UIView animateWithDuration:0.7 animations:^{
        
        if(rect.origin.x ==0 )
        {
            self.navigationController.view.frame =CGRectMake(300, 0, rect.size.width, rect.size.height);
        }else{
             self.navigationController.view.frame =CGRectMake(0, 0, rect.size.width, rect.size.height);
        
        }
       }];
  }
@end
