//
//  MainViewController.m
//  Ch03_TableVewController
//
//  Created by ucom Apple Instructor on 2016/11/28.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
//Data
@property (strong,nonatomic) NSMutableArray * todoList;
@property (strong,nonatomic) NSString * targetPath;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.targetPath = [NSString stringWithFormat:@"%@/Documents/def.plist", NSHomeDirectory()];
    NSLog(self.targetPath);
    NSFileManager * fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:self.targetPath]){
        NSString * sourceFile  = [[NSBundle mainBundle] pathForResource:@"abc" ofType:@"plist"];
        [fileMgr copyItemAtPath:sourceFile toPath:self.targetPath error:nil];
    }
//    self.todoList = [[NSMutableArray alloc] initWithObjects:@"護照",@"機票",@"行李", nil];
    self.todoList = [[NSMutableArray alloc] initWithContentsOfFile:self.targetPath];
    self.tableView.contentInset = UIEdgeInsetsMake(22, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"待辦事項";
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Total : %d",self.todoList.count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.todoList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString * current = self.todoList[indexPath.row];
    cell.textLabel.text = current;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * current = self.todoList[indexPath.row];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"編輯" message:current preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:cancel];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //取得使用者輸入
        NSString * updatedText = alert.textFields[0].text;
        //更新todoList
        self.todoList[indexPath.row] = updatedText;
        //更新檔案
        [self.todoList writeToFile:self.targetPath atomically:YES];
        //更新畫面
        [self.tableView reloadData];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = current;
    }];
    
    [alert addAction:ok];
    

    [self presentViewController:alert animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //更新todoList
        [self.todoList removeObjectAtIndex:indexPath.row];
        //更新檔案
        [self.todoList writeToFile:self.targetPath atomically:YES];
        //更新畫面
        [tableView reloadData];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
