//
//  BasicAnimationController.m
//  LYCoreAnimationSample
//
//  Created by yuedongkui on 2019/11/21.
//  Copyright © 2019 LY. All rights reserved.
//

#import "SubViewController1.h"

#define ScreenSize ([UIScreen mainScreen].bounds.size)

#define MinWidth  50
#define MaxWidth  100


@interface SubViewController1 ()

@property (nonatomic, strong) CALayer *layer;

@end




@implementation SubViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.layer = [[CALayer alloc] init];
    self.layer.backgroundColor = [[UIColor redColor] CGColor];
    self.layer.position = CGPointMake(ScreenSize.width/2, ScreenSize.height/2);
    self.layer.bounds = CGRectMake(0, 0, MinWidth, MinWidth);
    self.layer.anchorPoint = CGPointMake(0.5, 0.5); //控制手的落脚点，默认是中心点（0.5, 0.5）
    
    self.layer.shadowColor = [[UIColor grayColor] CGColor];
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 1;
    
    [self.view.layer addSublayer:self.layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:self.view];
    
    //[CATransaction setDisableActions:YES];//禁用隐式动画

    self.layer.position = position;
    if (self.layer.bounds.size.width == MinWidth) {
        self.layer.bounds = CGRectMake(0, 0, MaxWidth, MaxWidth);
        self.layer.cornerRadius = 0;
    } else {
        self.layer.bounds = CGRectMake(0, 0, MinWidth, MinWidth);
        self.layer.cornerRadius = self.layer.bounds.size.width/2;
    }
}


@end
