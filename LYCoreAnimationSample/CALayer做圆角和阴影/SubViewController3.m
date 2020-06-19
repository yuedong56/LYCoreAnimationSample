//
//  SubViewController3.m
//  LYCoreAnimationSample
//
//  Created by yuedongkui on 2019/11/21.
//  Copyright © 2019 LY. All rights reserved.
//

#import "SubViewController3.h"

#define ScreenSize ([UIScreen mainScreen].bounds.size)

#define ImageWidth  100.0


@interface SubViewController3 ()<CALayerDelegate>

@end


//不使用 UIImageView，直接使用 CALayer 的代理方法 -drawLayer:(CALayer *)layer inContext: 进行图片绘制
@implementation SubViewController3

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, ImageWidth, ImageWidth);
    layer.position = CGPointMake(200, 200);
    layer.backgroundColor = [[UIColor redColor] CGColor];
    layer.cornerRadius = ImageWidth/2;
    layer.masksToBounds = YES;
    layer.delegate = self;
    
    //layer.contents = (id)[[UIImage imageNamed:@"image"] CGImage]; //直接设置 contents，也不会出现倒立问题
    
    [self.view.layer addSublayer:layer];
    [layer setNeedsDisplay]; //调用此方法才会执行下面的代理方法
}

#pragma mark - CALayerDelegate
/** 此处是通过代理 -drawLayer: inContext: 方法；
    若自定义图层，则通过 -drawInContext: 方法（类似 UIView 的 -drawRect:） */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);

    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -ImageWidth);

    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, ImageWidth, ImageWidth), [UIImage imageNamed:@"image"].CGImage);

    //CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //CGContextDrawPath(ctx, kCGPathFillStroke);

    CGContextRestoreGState(ctx);
}

@end
