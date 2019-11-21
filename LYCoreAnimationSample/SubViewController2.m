//
//  SubViewController2.m
//  LYCoreAnimationSample
//
//  Created by yuedongkui on 2019/11/21.
//  Copyright © 2019 LY. All rights reserved.
//

#import "SubViewController2.h"

#define ScreenSize ([UIScreen mainScreen].bounds.size)

#define MinWidth  50
#define MaxWidth  100

@interface SubViewController2 ()

@property (nonatomic, strong) UIView *blueView;

@end



@implementation SubViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.blueView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, MinWidth, MinWidth)];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:self.view];
    
    self.blueView.layer.position = position;
    if (self.blueView.layer.bounds.size.width == MinWidth) {
        self.blueView.layer.bounds = CGRectMake(0, 0, MaxWidth, MaxWidth);
        self.blueView.layer.cornerRadius = 0;
    } else {
        self.blueView.layer.bounds = CGRectMake(0, 0, MinWidth, MinWidth);
        self.blueView.layer.cornerRadius = self.blueView.layer.bounds.size.width/2;
    }
}

@end
