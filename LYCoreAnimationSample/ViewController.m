//
//  ViewController.m
//  LYCoreAnimationSample
//
//  Created by yuedongkui on 2019/11/21.
//  Copyright © 2019 LY. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController1.h"
#import "SubViewController2.h"
#import "SubViewController3.h"
#import "SubViewController4.h"
#import "BasicAnimationController.h"
#import "LYDemoViewController.h"
#import "SubViewController5.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *tableData;

@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableData = @[@"CALayer隐式动画",
                       @"UIView中的的CALayer动画",
                       @"CALayer做圆角和阴影",
                       @"CALayer的transform旋转",
                       @"CABasicAnimation",
                       @"UIView中核心动画",
//                       @"CATransition（转场动画）",
                       @"CAKeyframeAnimation（关键帧动画）",
//                       @"CAAnimationGroup（动画组）"
    ];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"indentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.tableData[indexPath.row];
    
    cell.detailTextLabel.text = @"";
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = @"此时无隐式动画";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    NSString *title = self.tableData[indexPath.row];
    if ([title isEqualToString:@"CALayer隐式动画"]) {
        vc = [[SubViewController1 alloc] init];
    }
    else if ([title isEqualToString:@"UIView中的的CALayer动画"]) {
        vc = [[SubViewController2 alloc] init];
    }
    else if ([title isEqualToString:@"CALayer做圆角和阴影"]) {
        vc = [[SubViewController3 alloc] init];
    }
    else if ([title isEqualToString:@"CALayer的transform旋转"]) {
        vc = [[SubViewController4 alloc] init];
    }
    else if ([title isEqualToString:@"CABasicAnimation"]) {
        vc = [[BasicAnimationController alloc] init];
    }
//    else if ([title isEqualToString:@"CATransition（转场动画）"]) {
////        vc = [[SubViewController5 alloc] init];
//    }
    else if ([title isEqualToString:@"CAKeyframeAnimation（关键帧动画）"]) {
        vc = [[SubViewController5 alloc] init];
    }
//    else if ([title isEqualToString:@"CABasicAnimation"]) {
////        vc = [[SubViewController5 alloc] init];
//    }
    else if ([title isEqualToString:@"UIView中核心动画"]) {
        vc = [[LYDemoViewController alloc] init];
    }
    else {
        
    }
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
