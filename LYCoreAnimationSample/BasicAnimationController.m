//
//  SubViewController5.m
//  LYCoreAnimationSample
//
//  Created by yuedongkui on 2019/11/21.
//  Copyright © 2019 LY. All rights reserved.
//

#import "BasicAnimationController.h"

#define ScreenSize ([UIScreen mainScreen].bounds.size)

@interface BasicAnimationController () <CAAnimationDelegate>

@property (nonatomic, strong) CALayer *layer;

@end



@implementation BasicAnimationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.layer = [[CALayer alloc] init];
    self.layer.contents = (id)[UIImage imageNamed:@"image"].CGImage;
    self.layer.position = CGPointMake(ScreenSize.width/2, ScreenSize.height/2);
    self.layer.anchorPoint=CGPointMake(1, 1); //旋转动画是以锚点为中心旋转的
    self.layer.bounds = CGRectMake(0, 0, 100, 120);
    
    [self.view.layer addSublayer:self.layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    {   // 位置动画，position 为 layer 的属性
        CABasicAnimation *pAnim = [CABasicAnimation animationWithKeyPath:@"position"];
        pAnim.fromValue = [NSValue valueWithCGPoint:self.layer.position];
        pAnim.toValue = [NSValue valueWithCGPoint:location];
        pAnim.duration = 1.0;
        pAnim.delegate = self;

        [self.layer addAnimation:pAnim forKey:@"k_Position_Animation_Key"];
    }
    
    {   // 旋转动画
        CABasicAnimation *tAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //tAnim.fromValue = @(M_PI_2);
        tAnim.toValue = @(M_PI_2 *3);
        tAnim.duration = 2.0;
        tAnim.autoreverses = YES; //旋转后再转回原来位置
        tAnim.repeatCount = 2;  //设置循环次数 (无线循环：HUGE_VALF;)
        tAnim.removedOnCompletion = YES;
        
        [self.layer addAnimation:tAnim forKey:@"k_Tansform_Animation_Key"];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; //对于非根图层，默认有隐式动画，需手动禁止
    
    self.layer.position = [animation.toValue CGPointValue]; //不加这句，图片会重新回到原位置
    
    [CATransaction commit];
}


@end
