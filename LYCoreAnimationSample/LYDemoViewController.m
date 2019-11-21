//
//  LYDemoViewController.m
//  LYCoreAnimationSample
//
//  Created by yuedongkui on 2019/11/21.
//  Copyright © 2019 LY. All rights reserved.
//

#import "LYDemoViewController.h"

#define ScreenSize ([UIScreen mainScreen].bounds.size)


@interface LYDemoViewController ()

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *label;

@end




@implementation LYDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 140, 200)];
    self.mainView.backgroundColor = [UIColor redColor];
    self.mainView.autoresizesSubviews = YES;
    [self.view addSubview:self.mainView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 180)];
    imageView.image = [UIImage imageNamed:@"image"];
    [self.mainView addSubview:imageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, 300, 20)];
    self.label.textColor = [UIColor blackColor];
    self.label.text = @"12345";
    [self.mainView addSubview:self.label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 140, 200)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 140*1.2, 200*1.2)];
    anim.duration = 1;
    [self.mainView.layer addAnimation:anim forKey:@"123"];
    
//    CABasicAnimation *labelAnim = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    labelAnim.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 140, 200)];
//    labelAnim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 140*1.2, 200*1.2)];
//    labelAnim.duration = 1;
//    [self.label.layer addAnimation:labelAnim forKey:@"333"];
}

@end
