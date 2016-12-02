//
//  ViewController.m
//  CH09_webview_network_JSON
//
//  Created by ucom Apple 13 on 2016/12/2.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "ViewController.h"
#define GET_LINK @"http://ikenapp.appspot.com/json/getCategory.jsp"
#define POST_LINK @"http://ikenapp.appspot.com/json/postProductsByCategory.jsp"
#define QUERYSTRING @"cateId=%d"

@interface ViewController()<UITableViewDelegate , UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSMutableArray * list;
@property (strong,nonatomic)  NSArray * options;


@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //ViewVillappear
   
    self.options = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    self.list = [NSMutableArray new];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    [self getByNSURLConnectionPOST];
   // [self getByNSURLSessionPOST];
   // [self getByNSString];
    // Do any additional setup after loading the view, typically from a nib.
}

//PickerView :

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    // if(component==0){
       // NSString* city = self.cities[row];
       // NSArray * array = self.datas[city];
       // self.cityLabel.text = city;
       // self.areaLabel.text  = array[0];
       // [pickerView reloadComponent:1];
       // [pickerView selectRow:0 inComponent:1 animated:YES];
    
    //request LINe
    NSMutableURLRequest * req =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:POST_LINK]] ;
    req.HTTPMethod = @"POST";
    
    //request body
    NSString * bodystring = [NSString stringWithFormat:QUERYSTRING,(row+1)];
    NSData * postData = [bodystring dataUsingEncoding:NSUTF8StringEncoding ];
    req.HTTPBody = postData;
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionTask * task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"error : \n %@",error);
            return;
        }
        NSString * result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"RESULT BY didSelectRow : \n %@",result);
        
        [self.list removeAllObjects];
        NSArray * jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        for(NSDictionary * dict in jsonArray){
            NSString * productName = dict[@"prod_name"];
            [self.list addObject:productName];
        
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
         // workingthread (bakcgroundthread , slow and error)-> UIthread (GCD)
        
    }];
    [task resume]; // !!!!!!!!

   
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //if (component == 0){
     //int selectedIndex = [pickerView selectedRowInComponent:0];
        return self.options[row];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int selectedIndex = [pickerView selectedRowInComponent:0];
   // if (component == 0){
        return self.options.count;
   }

//TableView :

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" ]; //forIndexPath:indexPath
    cell.textLabel.text = self.list[indexPath.row];
    //[NSString stringWithFormat:@"%li", indexPath.row]
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  self.list.count;
}


//Nertwork
-(void)getByNSURLSessionPOST{
    
    //request LINe
    NSMutableURLRequest * req =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:POST_LINK]] ;
    req.HTTPMethod = @"POST";
    
    //request body
    NSString * bodystring = [NSString stringWithFormat:QUERYSTRING,2];
    NSData * postData = [bodystring dataUsingEncoding:NSUTF8StringEncoding ];
    req.HTTPBody = postData;

    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionTask * task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"error : \n %@",error);
            return;
        }
        NSString * result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"RESULT BY NSURLSession : \n %@",result);

    }];
    [task resume]; // !!!!!!!!

}

-(void)getByNSURLConnectionPOST{
    //request LINe
    NSMutableURLRequest * req =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:POST_LINK]] ;
    req.HTTPMethod = @"POST";
    
  //request body
    NSString * bodystring = [NSString stringWithFormat:QUERYSTRING,2];
    NSData * postData = [bodystring dataUsingEncoding:NSUTF8StringEncoding ];
    req.HTTPBody = postData;
    
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError){
            NSLog(@"connectionError : \n %@",connectionError);
            return;
        }
        NSString * result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data]
        
        // for(int i =0; i< ){ list}
        NSLog(@"RESULT BY NSURLConnection : \n %@",result);
    }];
  
    
}

-(void)getByNSString{
    NSURL * url = [NSString stringWithContentsOfURL:url encoding: NSUTF8StringEncoding error:nil];
    NSLog(@"GET BY NSSTRING : \n%@, result");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
