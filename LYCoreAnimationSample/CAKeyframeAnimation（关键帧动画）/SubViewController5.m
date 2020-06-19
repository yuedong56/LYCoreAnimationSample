//
//  SubViewController5.m
//  LYCoreAnimationSample
//
//  Created by 老岳 on 2020/6/19.
//  Copyright © 2020 LY. All rights reserved.
//

#define ScreenSize ([UIScreen mainScreen].bounds.size)

#import "SubViewController5.h"

@interface SubViewController5 ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *layer;

@end



@implementation SubViewController5

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.layer = [[CALayer alloc] init];
    self.layer.contents = (id)[UIImage imageNamed:@"image"].CGImage;
    self.layer.position = CGPointMake(150, 100);
    self.layer.bounds = CGRectMake(0, 0, 100, 120);
    [self.view.layer addSublayer:self.layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     //关键帧动画开发分为两种形式：一种是通过设置不同的属性值进行关键帧控制，另一种是通过绘制路径进行关键帧控制。后者优先级高于前者，如果设置了路径则属性值就不再起作用。
    //本例只介绍第一种，通过属性
    
    {   // 位置动画，position 为 layer 的属性
        //1.创建关键帧动画并设置动画属性
        CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyframeAnimation.delegate = self;
        
        //加上这两句，动画结束时不会闪一下
        keyframeAnimation.removedOnCompletion = NO;
        keyframeAnimation.fillMode = kCAFillModeForwards;
        
        {//法一：2.设置关键帧,这里有四个关键帧
            NSValue *key1 = [NSValue valueWithCGPoint:self.layer.position];//对于关键帧动画初始值不能省略
            NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(200, 220)];
            NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(145, 300)];
            NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(180, 400)];
            NSValue *key5 = [NSValue valueWithCGPoint:CGPointMake(120, 600)];

            NSArray *values = @[key1, key2, key3, key4, key5];
            keyframeAnimation.values = values;
            
            keyframeAnimation.keyTimes = @[@(0), @(0.1), @(0.2), @(0.3), @(1)];//设置每一帧的时间，不设置的话默认为平均值
        }
        
        {//法2：//2.设置路径，绘制贝塞尔曲线
//            CGMutablePathRef path = CGPathCreateMutable();
//            CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);//移动到起始点
//            CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
//
//            keyframeAnimation.path = path;//设置path属性
//            CGPathRelease(path);//释放路径对象
        }
        
        //设置其他属性
        keyframeAnimation.duration = 4.0;
        keyframeAnimation.beginTime = CACurrentMediaTime()+1;//设置延迟1秒执行
        
        //3.添加动画到图层，添加动画后就会执行动画
        [self.layer addAnimation:keyframeAnimation forKey:@"k_Position_Animation_Key"];
    }
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CAKeyframeAnimation *animation = (CAKeyframeAnimation *)anim;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; //对于非根图层，默认有隐式动画，需手动禁止
    
    self.layer.position = [animation.values.lastObject CGPointValue]; //不加这句，图片会重新回到原位置
    //[self.layer removeAllAnimations]; //移除动画

    [CATransaction commit];
}

@end
