//
//  EditorViewController.m
//  Ch04_NaviagationController
//
//  Created by ucom Apple 13 on 2016/11/29.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *taskInput;



@end

@implementation EditorViewController
- (IBAction)didTaskChanged:(id)sender {
}
- (IBAction)saveHandler:(id)sender {
    //收集使用者input
    NSString *task = self.taskInput.text;
    
    // update array
    NSMutableArray * list = [NSMutableArray arrayWithContentsOfFile:self.targetPath];
    
    if(self.row == -1){
        [list addObject:task];
    }else{
        list[self.row] =task;
    }
    
    // update file
    [list writeToFile:self.targetPath atomically:YES];
    
    //back to last pages
        [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)hidekeyboard:(id)sender {
    
    [sender resignFirstResponder];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder]; //第一回應物件取消
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskInput.delegate =self;
    
    if(self.row == -1){
        self.title =@"New";
    }else{
        self.title =@"Edit";
        NSArray * list =[NSArray arrayWithContentsOfFile:self.targetPath];
        self.taskInput.text = list[self.row];
    
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)hidekeyborad:(id)sender {
}
@end
