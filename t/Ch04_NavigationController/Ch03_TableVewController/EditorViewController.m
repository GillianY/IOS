//
//  EditorViewController.m
//  Ch04_NavigationController
//
//  Created by ucom Apple Instructor on 2016/11/29.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "EditorViewController.h"
//Delegation Step 1
@interface EditorViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *taskInput;
- (IBAction)saveHandler:(id)sender;

@end

@implementation EditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Delegation Step 2
    self.taskInput.delegate = self;
    if (self.row == -1){
        //New
        self.title = @"新增";
    }else{
        //Update
        self.title = @"編輯";
        NSArray * list = [NSArray arrayWithContentsOfFile:self.target];
        self.taskInput.text = list[self.row];
    }
}
//Delegation Step 3
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

- (IBAction)saveHandler:(id)sender {
    //收集使用者輸入
    NSString * task = self.taskInput.text;
    //更新Array
    NSMutableArray * list = [NSMutableArray arrayWithContentsOfFile:self.target];
    if (self.row == -1){
        [list addObject:task];
    }else{
        list[self.row] = task;
    }
    //更新檔案
    [list writeToFile:self.target atomically:YES];
    //回上一頁
    [self.navigationController popViewControllerAnimated:YES];
}
@end
