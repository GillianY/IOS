//
//  ViewController.m
//  CH06
//
//  Created by ucom Apple 13 on 2016/12/1.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"

@interface ViewController ()<CLLocationManagerDelegate>
//UI
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *map;
//Data
@property (strong,nonatomic) CLLocationManager * locationMgr;
@property (strong,nonatomic) CLLocation * localtion;

- (IBAction)detectHandler:(id)sender;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationMgr = [CLLocationManager new];
    [self.locationMgr requestWhenInUseAuthorization]; // +set plist :  NSLocationWhenInUseUsageDescription
    self.locationMgr.delegate =self;
    // [self.locationMgr requestAlwaysAuthorization]; // + set plist :NSLocationAlwaysUsageDescription
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"locationManager");
    self.localtion =locations[0];
    self.locationLabel.text  =[NSString stringWithFormat:@"%f  ,%f",self.localtion.coordinate.latitude,self.localtion.coordinate.longitude];
    CLGeocoder * geo = [CLGeocoder new];
    [geo reverseGeocodeLocation:self.localtion completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *pk = placemarks[0];
        self.addressLabel.text = [NSString stringWithFormat:@"(%@) %@ %@ %@",pk.postalCode,pk.administrativeArea,pk.locality,pk.thoroughfare,pk.subThoroughfare];
    }];
    self.map.enabled = YES;
    [manager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detectHandler:(id)sender {
    [self.locationMgr startUpdatingLocation];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MapViewController * next  = segue.destinationViewController;
    next.location = self.localtion;
}
@end
