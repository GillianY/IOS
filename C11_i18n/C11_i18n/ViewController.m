//
//  ViewController.m
//  C11_i18n
//
//  Created by ucom Apple 13 on 2016/12/2.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *uilabel;
@property (weak, nonatomic) IBOutlet UILabel *msglabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.uilabel.text = NSLocalizedString(@"LABEL_COMPANY", nil);
    self.msglabel.text = NSLocalizedStringFromTable(@"MSG_GREETING", @"Messages", nil );
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
