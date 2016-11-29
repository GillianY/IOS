//
//  ViewController.m
//  Ch02
//
//  Created by ucom Apple Instructor on 2016/11/25.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "ViewController.h"
#import "DragableImageView.h"
#define NUMS 50
@interface ViewController ()
@property(strong,nonatomic) UIImageView * target;
@property(nonatomic)int dx;
@property(nonatomic)int dy;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(NSHomeDirectory());
    //1
    self.view.backgroundColor = [UIColor blackColor];
    for (int i = 0; i< NUMS; i++){
        UIImageView * img1 = [[DragableImageView alloc] initWithImage:[UIImage imageNamed:@"smile"]];
        img1.userInteractionEnabled = YES;
        img1.center = CGPointMake(arc4random() % (int)self.view.frame.size.width, arc4random() % (int)self.view.frame.size.height);
        [self.view  addSubview:img1];
    }
    //2
    
    //3
    
    //[self testMovingCircle];
    //[self testView];
}

- (void) testMovingCircle{
    self.dx = 3;
    self.dy = 3;
    self.target = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smile"]];
    CGSize size = self.view.frame.size;
    CGFloat newX = arc4random() % (int) size.width;
    CGFloat newY = arc4random() % (int) size.height;
    self.target.center = CGPointMake(newX, newY);
    [self.view  addSubview:self.target];
    [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(moveHandler:) userInfo:nil repeats:YES];
}

- (void) moveHandler:(id)sender{
    CGSize size = self.view.frame.size;
    CGPoint current = self.target.center;
    CGPoint newPosition = current;
    
    if (self.dy > 0 && (current.y + self.dy <= size.height)){
        newPosition.y += self.dy;
    }else if (self.dy < 0 && (current.y + self.dy >= 0)){
        newPosition.y += self.dy;
    }else{
        self.dy *= -1;
        //newPosition.y = size.height;
    }
    
    if (self.dx > 0 && (current.x + self.dx <= size.width)){
        newPosition.x += self.dx;
    }else if (self.dx < 0 && (current.x + self.dx>= 0)){
        newPosition.x += self.dx;
    }else{
        self.dx *= -1;
        //newPosition.y = size.height;
    }
    self.target.center = CGPointMake(newPosition.x, newPosition.y);
}

- (void) testView{
    CGRect appRect = self.view.frame;
    NSLog(@"[%f,%f]",appRect.size.width,appRect.size.height);
    UIImageView * img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smile"]];
    [self.view  addSubview:img1];
    UIImageView * img2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Black_Widow"]];
    img2.frame = CGRectMake(0, 0, 50, 50);
    img2.center = CGPointMake(appRect.size.width/2, appRect.size.height/2);
    //[self.view  addSubview:img2];
    [self.view insertSubview:img2 belowSubview:img1
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear - 1");
    //restore status
    //1
    NSUserDefaults * nud = [NSUserDefaults standardUserDefaults];
    //2
    NSMutableArray * list = [nud objectForKey:@"LOCS"];
    if (list != nil && list.count == NUMS){
        int count = 0;
        for (UIView * view in self.view.subviews){
            if ([view isMemberOfClass:[DragableImageView class]]){
                //3
                NSString * centerStr = list[count];
                count++;
                //4
                CGPoint center = CGPointFromString(centerStr);
                //5
                view.center = center;
            }
        }
        //        //3
        //        for (NSString * centerStr in list){
        //            //4
        //            CGPoint center = CGPointFromString(centerStr);
        //            //5
        //            self.view.subviews[count].center = center;
        //            count++;
        //        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear - 2");
}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear - 3");
    //save status
    //1
    NSMutableArray * list = [NSMutableArray new];
    for (UIView * view in self.view.subviews){
        if ([view  isMemberOfClass:[DragableImageView class]]){
            //2
            CGPoint center = view.center;
            //3
            NSString * centerStr = NSStringFromCGPoint(center);
            //4
            [list addObject:centerStr];
        }
    }
    NSLog(@"COUNT : %d",list.count);
    //5
    NSUserDefaults * nud = [NSUserDefaults standardUserDefaults];
    //6
    [nud setObject:list forKey:@"LOCS"];
    //7
    [nud synchronize];
}
-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"viewDidDisappear - 4");
}

@end
