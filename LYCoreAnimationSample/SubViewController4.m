//
//  SubViewController4.m
//  LYCoreAnimationSample
//
//  Created by yuedongkui on 2019/11/21.
//  Copyright © 2019 LY. All rights reserved.
//

#import "SubViewController4.h"

#define ScreenSize ([UIScreen mainScreen].bounds.size)


@interface SubViewController4 ()

@end




@implementation SubViewController4

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    imageView.frame = CGRectMake(150, 200, 100, 120);
    [self.view addSubview:imageView];
    
    imageView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0); //加上这句图片会倒立
}

@end
