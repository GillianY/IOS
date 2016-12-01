//
//  ViewController.m
//  ch05
//
//  Created by ucom Apple 13 on 2016/12/1.
//  Copyright © 2016年 Gillian_studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *holderImg;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapper  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandler:)];
    [self.holderImg addGestureRecognizer:tapper];
    
    UIPinchGestureRecognizer *pinner = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinHandler:) ];
    [self.holderImg addGestureRecognizer:pinner];
    
       UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationHandler:) ];
    [self.holderImg addGestureRecognizer:rotation];

    UILongPressGestureRecognizer *longpresser = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpressHandler:) ];
    [self.holderImg addGestureRecognizer:longpresser];

    
    UISwipeGestureRecognizer *swipper = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:) ];
    [self.holderImg addGestureRecognizer:swipper];
    

    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:) ];
    swipeleft.direction =UISwipeGestureRecognizerDirectionLeft;
    [self.holderImg addGestureRecognizer:swipeleft];

    pinner.delegate =self;
    rotation.delegate = self;
    
    
}


-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)tapHandler:(UITapGestureRecognizer *)sender{
    [UIView animateWithDuration:0.6 animations:^{
        CGFloat red = arc4random()%1000/ 1000.0 ;
        CGFloat green = arc4random()%1000/ 1000.0 ;
        CGFloat blue = arc4random()%1000/ 1000.0 ;
        NSLog(@"%f,%f,%f",red,green,blue);
        self.view.backgroundColor =[UIColor colorWithRed:red green:green blue:blue alpha:0.9];
    }];
    
    
    NSLog(@"tapHandler");
}
-(void)pinHandler:(UIPinchGestureRecognizer *)sender{
    NSLog(@"pinHandler...%f",sender.scale);
    self.holderImg.transform = CGAffineTransformScale(self.holderImg.transform, sender.scale, sender.scale);
     //CGAffineTransformMakeScale(sender.scale, sender.scale);
    sender.scale =1;
}

bool isBlack =true;
-(void)swipeHandler:(UISwipeGestureRecognizer *)sender{
    NSString * dir =@"";
    switch(sender.direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            dir=@"Left";
            break;
        case UISwipeGestureRecognizerDirectionRight:
            dir=@"Right";
            break;
        default:
            break;
    }
    if(isBlack)
    {
        self.holderImg.image =[UIImage imageNamed: @"wiiWheel"];
    }else{
          self.holderImg.image =[UIImage imageNamed: @"iphoneWheel"];
    
    }
    isBlack = !isBlack;
    NSLog(@"swipeHandler....%@",dir);
}
-(void)rotationHandler:(UIRotationGestureRecognizer *)sender{
    
    NSLog(@"rotationHandler....%f",sender.rotation);
    self.holderImg.transform = CGAffineTransformRotate(self.holderImg.transform, sender.rotation); //CGAffineTransformMakeRotation(sender.rotation);
    sender.rotation =0;
}
-(void)longpressHandler:(UILongPressGestureRecognizer *)sender{
    NSString * state = @"";
    switch (sender.state){
        case UIGestureRecognizerStateBegan:
            state = @"Began";
            break;
        case UIGestureRecognizerStateChanged:
            state = @"Changed";
            break;
        case UIGestureRecognizerStateEnded:
            state = @"Ended";
            break;
    }
    
    NSLog(@"longpressHandler...%@",state);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
