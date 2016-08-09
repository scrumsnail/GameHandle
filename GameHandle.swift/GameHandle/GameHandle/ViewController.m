//
//  ViewController.m
//  GameHandle
//
//  Created by allthings_LuYD on 16/8/9.
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CGFloat radius;
    CGPoint left;
    CGRect rightRect;
    CGPoint right;
}
@property (weak, nonatomic) IBOutlet UIImageView *leftBgImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightBgImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightHandle;
@property (weak, nonatomic) IBOutlet UIImageView *leftHandle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    radius = 75;
    left = _leftHandle.center;
    right = _rightHandle.center;
    rightRect = _rightBgImage.frame;
    UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(leftPanFrom:)];
    UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(rightPanFrom:)];
    [_rightHandle addGestureRecognizer:rightPan];
    [_leftHandle addGestureRecognizer:leftPan];
}

-(void)leftPanFrom:(UIPanGestureRecognizer*)recognizer{
    _leftHandle.image = [UIImage imageNamed:@"btn_pressed"];
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint center = recognizer.view.center;
    center.y += translation.y;
    center.x += translation.x;
    CGFloat x = center.x - left.x;
    CGFloat y = center.y - left.y;
    if (x*x + y*y >= radius*radius)
    {
        center.y -= translation.y;
        center.x -= translation.x;
    }
    NSLog(@"%@",[self directionForX:x Y:y]);
    recognizer.view.center = center;
    [recognizer setTranslation:CGPointZero inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded){

        [UIView animateWithDuration:0.08 animations:^{
            recognizer.view.center = left;
            _leftHandle.image = [UIImage imageNamed:@"btn_normal"];
        }];
    }
}

-(void)rightPanFrom:(UIPanGestureRecognizer*)recognizer{
    _rightHandle.image = [UIImage imageNamed:@"btn_pressed"];
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint center = recognizer.view.center;
    center.y += translation.y;
    if (center.y + 20 >= rightRect.size.height + rightRect.origin.y)
    {
        center.y = rightRect.size.height + rightRect.origin.y - 20;
    }
    if (center.y <= rightRect.origin.y + 20)
    {
        center.y = rightRect.origin.y + 20;
    }
    recognizer.view.center = center;
    CGFloat y = center.y - right.y;
    if (y < 0) {
        //要做的事
    }
    if (y > 0) {
        //要做的事
    }
    [recognizer setTranslation:CGPointZero inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded){
        //要做的事
        [UIView animateWithDuration:0.08 animations:^{
            recognizer.view.center = right;
            _rightHandle.image = [UIImage imageNamed:@"btn_normal"];
        }];
    }

}




- (NSString *)directionForX:(CGFloat)x Y:(CGFloat)y{
    CGFloat a = atan(y/x)*180.0/M_PI;
    /**
     *  第一象限
     */
    if (0 <= x && y <= 0) {
        if (a > -22.5) {
            return  @"right";
        }
        if (-67.5 <= a && a <= -22.5) {
            return  @"forwardright";
        }
        if (a < -67.5) {
            return  @"forward";
        }
    }
    /**
     *  第二象限
     */
    if (0 >= x && y <= 0) {
        if (a < 22.5) {
            return @"left";
        }
        if (22.5 <= a && a <= 67.5) {
            return @"forwardleft";
        }
        if (67.5 < a ) {
            return @"forward";
        }
    }
    /**
     *  第三象限
     */
    if (0 > x && y > 0) {
        if (a > -22.5) {
            return @"left";
        }
        if (- 22.5 >= a && a >= -67.5) {
            return @"backwardleft";
        }
        if (a < 67.5) {
            return @"backward";
        }

    }
    /**
     *  第四象限
     */
    if (0 <= x && y > 0) {
        if (a < 22.5) {
            return @"right";
        }
        if (22.5 <= a && a <= 67.5) {
            return @"backwardright";
        }
        if (a > 67.5) {
            return @"backward";
        }
    }
    return @"";
}
@end
