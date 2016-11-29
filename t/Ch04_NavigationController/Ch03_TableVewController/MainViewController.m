//
//  MainViewController.m
//  Ch03_TableVewController
//
//  Created by ucom Apple Instructor on 2016/11/28.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "MainViewController.h"
#import "EditorViewController.h"
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
//    self.todoList = [[NSMutableArray alloc] initWithContentsOfFile:self.targetPath];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditorViewController * next = segue.destinationViewController;
    next.target = self.targetPath;
    if ([segue.identifier isEqualToString:@"update"]){
        next.row = [self.tableView indexPathForSelectedRow].row;
    }else{
        next.row = -1;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.todoList = [[NSMutableArray alloc] initWithContentsOfFile:self.targetPath];
    [self.tableView reloadData];
}
//-(void)viewDidAppear:(BOOL)animated{
//    self.todoList = [[NSMutableArray alloc] initWithContentsOfFile:self.targetPath];
//    [self.tableView reloadData];
//}


@end
