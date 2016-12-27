//
//  PhotoPicker.m
//  MyDiary
//
//  Created by ucom Apple 13 on 2016/12/21.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//
//#import "UIKit"
#import "PhotoPicker.h"
#import "FMDB.h"
#import "MyDiary-Swift.h"

@implementation PhotoPicker

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //if phtoExist -> show Photo
   // self navigationController.ti
    
    BOOL isOld = [DiaryDAO hasPhotoDatabyPhotoID:_rowID];
    
    if(isOld)
    {
        NSData *oldphoto = [DiaryDAO getPhotofromPhotoID:_rowID];
        UIImage *oldimage = [UIImage imageWithData:oldphoto];
        _imageView.image = oldimage ;
    }
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.navigationItem.rightBarButtonItem = nil;
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"裝置" message:@"裝置不支援相機功能！！" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [myAlertView show];
        
    }
}

//check photo whithvalue
-(void)savePhotoToDB{
    // _photoData = UIImagePNGRepresentation(self.imageView.image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDiary.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    
    if (![db open]) {
        NSLog(@"!!!!Could not open db");
        return ;
    }
    ;
    NSData *n = UIImagePNGRepresentation( [_imageView image]);
    
    NSMutableDictionary * argsDict = [NSMutableDictionary dictionary];
    [argsDict setObject:n forKey:@"photo"];
    [argsDict setObject: [NSNumber numberWithInt:_rowID] forKey:@"rowID"];
    
    _querystring = @"update diary_photos set photo =:photo where rowid = :rowID";
    
    [db executeUpdate:@"update diary_photos set photo =:photo where rowid = :rowID" withParameterDictionary:argsDict];
    
    [db close];
    argsDict = nil;
    
}


- (IBAction)shotPhoto:(UIBarButtonItem *)sender {
    
    UIImagePickerController *imgPickerUI = [UIImagePickerController new];
    imgPickerUI.delegate = self;
    imgPickerUI.allowsEditing = YES;
    [imgPickerUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:imgPickerUI animated:YES completion:nil];
}

- (IBAction)pickPhotoDone:(UIBarButtonItem *)sender {
    //savephoto
   [self savePhotoToDB] ;
    [self dismissViewControllerAnimated:YES completion:nil];
   
}

- (IBAction)CancelPickPhoto:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pickPhoto:(UIBarButtonItem *)sender {
    UIImagePickerController * controller = [[UIImagePickerController alloc] init];
    
    //設定選取照片的來源為PhotoLibrary，即照片APP中的相片
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    ////委派給self，即目前的controller，
    //以處後取得相片後的顯示相片的作業
    //當然目前的controller已實作UINavigationControllerDelegate
    //與 UIImagePickerControllerDelegate 2個協定
    controller.delegate = self;
    
    //轉換至UIImagePickerController，以選取照片
    [self presentViewController:controller
                       animated:YES
                     completion:nil];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //segue
    //Done and save
    
    //addeditDiartyViewController
   // UIActivityViewController *next = segue.destinationViewController  ;
   // NSLog(@"PhotoPicker prepareForSegue");
   // next.view.tag =  1; //NSInteger (photoID)
    
}

#pragma mark - UIImagePickerControllerDelegate
@end
