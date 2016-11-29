//
//  ViewController.m
//  Ch03_PickerView
//
//  Created by ucom Apple Instructor on 2016/11/28.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "ViewController.h"

//Delegation Step 1
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
//UI
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaLabel;
//Data
@property (strong,nonatomic) NSDictionary * datas;
@property (strong,nonatomic) NSArray * cities;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 : 欄位初始化
    self.cities = @[@"City1",@"City2"];
    self.datas = @{@"City1":@[@"Area11",@"Area12",@"Area13",@"Area14",@"Area15"],
                   @"City2":@[@"Area21",@"Area22",@"Area23"]};
    //2 : Delegation註冊
    //Delegation Step 2
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    //3 : 其他初始化邏輯
    NSString * city = self.cities[0];
    self.cityLabel.text = city;
    NSArray * array = self.datas[city];
    self.areaLabel.text = array[0];
}

//Delegation Step 3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0){
        return self.cities.count;
    }else{
        int selectedIndex = [pickerView selectedRowInComponent:0];
        NSString* city = self.cities[selectedIndex];
        NSArray * array = self.datas[city];
        return array.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0){
        return self.cities[row];
    }else{
        int selectedIndex = [pickerView selectedRowInComponent:0];
        NSString* city = self.cities[selectedIndex];
        NSArray * array = self.datas[city];
        return array[row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component==0){
        NSString* city = self.cities[row];
        NSArray * array = self.datas[city];
        self.cityLabel.text = city;
        self.areaLabel.text  = array[0];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }else{
        int selectedIndex = [pickerView selectedRowInComponent:0];
        NSString* city = self.cities[selectedIndex];
        NSArray * array = self.datas[city];
        self.areaLabel.text = array[row];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
