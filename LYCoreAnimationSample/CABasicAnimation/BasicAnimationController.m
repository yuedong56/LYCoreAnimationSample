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
    self.layer.bounds = CGRectMake(0, 0, 100, 120);
    
    [self.view.layer addSublayer:self.layer];
    
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [pauseButton setTitle:@"暂停/恢复" forState:UIControlStateNormal];
    pauseButton.frame = CGRectMake(150, 100, 80, 40);
    [pauseButton addTarget:self action:@selector(pauseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    {   // 位置动画，position 为 layer 的属性
        CABasicAnimation *pAnim = [CABasicAnimation animationWithKeyPath:@"position"];
        pAnim.fromValue = [NSValue valueWithCGPoint:self.layer.position];
        pAnim.toValue = [NSValue valueWithCGPoint:location];
        pAnim.duration = 1;
        pAnim.delegate = self;

        //加上这两句，动画结束时不会闪一下
        pAnim.removedOnCompletion = NO;
        pAnim.fillMode = kCAFillModeForwards;

        [self.layer addAnimation:pAnim forKey:@"k_Position_Animation_Key"];
    }
    
    {   // 旋转动画
        CABasicAnimation *tAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        tAnim.fromValue = @(0);
        tAnim.toValue = @(M_PI_2 *4);
        tAnim.duration = 2;
        //tAnim.autoreverses = YES; //旋转后再转回原来位置
        tAnim.repeatCount = 1;  //设置循环次数 (无线循环：HUGE_VALF;)
        tAnim.removedOnCompletion = YES;

        //若修改旋转中心，则修改 anchorPoint，默认是中心点(0.5, 0.5)
        //self.layer.anchorPoint = CGPointMake(1, 1); //旋转动画是以锚点为中心旋转的

        [self.layer addAnimation:tAnim forKey:@"k_Tansform_Animation_Key"];
    }
}

#pragma mark -
- (void)pauseButtonAction:(UIButton *)button
{
    CAAnimation *animation = [self.layer animationForKey:@"k_Position_Animation_Key"];
    if (animation) {
        if (self.layer.speed == 0) {//重启
            //获得暂停的时间
            CFTimeInterval beginTime= CACurrentMediaTime() - self.layer.timeOffset;
            //设置偏移量
            self.layer.timeOffset = 0;
            //设置开始时间
            self.layer.beginTime = beginTime;
            //设置动画速度，开始运动
            self.layer.speed = 1.0;
        } else {//暂停
            //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
            CFTimeInterval interval = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
            //设置时间偏移量，保证暂停时停留在旋转的位置
            self.layer.timeOffset = interval;
            //速度设置为0，暂停动画
            self.layer.speed = 0;
        }
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
    //[self.layer removeAllAnimations]; //移除动画

    [CATransaction commit];
}


@end
