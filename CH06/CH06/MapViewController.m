//
//  MapViewController.m
//  CH06
//
//  Created by ucom Apple 13 on 2016/12/1.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MKCoordinateSpan span ;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    MKCoordinateRegion region;
    region.span = span;
    region.center = self.location.coordinate;
    self.mapView.region = region;
    self.mapView.delegate = self;
    
    MKPointAnnotation *pin = [MKPointAnnotation new];
    pin.coordinate = self.location.coordinate;
    pin.title = @"Duomo Di Milano";
    pin.subtitle = @" hello Duomo";
    [self.mapView addAnnotation:pin];
    
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    MKAnnotationView * view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN"];
    if(view == nil){
        view = [[MKAnnotationView alloc]initWithAnnotation: annotation reuseIdentifier:@"PIN"];
    }
    view.image = [UIImage imageNamed:@"icon-red-placemark"];
    view.canShowCallout = YES;
    
    UIButton * website = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [website setBackgroundImage:[UIImage imageNamed:@"Website"
                                ] forState:UIControlStateNormal ];
    website.frame = CGRectMake(0, 0, 32, 32);
    website.tag =1;
    view.leftCalloutAccessoryView = website;
    
    UIButton * phone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [phone setBackgroundImage:[UIImage imageNamed:@"phone"
                                 ] forState:UIControlStateNormal ];
    phone.frame = CGRectMake(0, 0, 32, 32);
    phone.tag =2;
    view.RightCalloutAccessoryView = phone;
    
     // like = @"http://www.duomomilano.it/en/";
    return view;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSString * link = @"http://www.duomomilano.it/en/";
    if(control.tag == 2){
        link =@"tel://0225149191";
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
    
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

@end
