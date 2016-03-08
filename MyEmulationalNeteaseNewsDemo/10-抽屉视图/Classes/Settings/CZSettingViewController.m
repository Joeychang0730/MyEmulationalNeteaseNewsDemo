//
//  CZSettingViewController.m
//  10-抽屉视图
//
//  Created by apple on 11/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZSettingViewController.h"

@interface CZSettingViewController ()

@end

@implementation CZSettingViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.clipsToBounds = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(150, 80, 50, 50);
    [button setImage:[UIImage imageNamed:@"user_defaultavatar"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click
{
    NSLog(@"%s", __func__);
}

- (void)viewWillLayoutSubviews
{
    NSLog(@"%s", __func__);
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}

@end
