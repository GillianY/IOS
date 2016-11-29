//
//  DragableImageView.m
//  Ch02
//
//  Created by ucom Apple Instructor on 2016/11/28.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "DragableImageView.h"

@implementation DragableImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
CGPoint startLocation;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan...");
    startLocation = [[touches anyObject] locationInView:self];
    [self.superview bringSubviewToFront:self];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesMoved...");
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    CGFloat dx = touchLocation.x - startLocation.x;
    CGFloat dy = touchLocation.y - startLocation.y;
    self.center = CGPointMake(self.center.x + dx , self.center.y + dy);
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded...");
}

@end
