//
//  CZRootViewController.m
//  10-抽屉视图
//
//  Created by apple on 11/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZRootViewController.h"
#import "CZNewsViewController.h"
#import "CZMenuViewController.h"
#import "CZSettingViewController.h"

@interface CZRootViewController ()
@property (nonatomic, weak) UINavigationController *navVC;
@end

@implementation CZRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 主视图
    CZNewsViewController *newsVC = [[CZNewsViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newsVC];
    self.navVC = nav;
    
    // 添加子视图控制器
    [self addChildViewController:nav];
    // 添加到mainView
    [self.mainView addSubview:nav.view];
    NSLog(@"nav view: %@", NSStringFromCGRect(nav.view.frame));
    
    // 2. 添加menu视图
    CZMenuViewController *menuVC = [[CZMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addChildViewController:menuVC];
    [self.leftView addSubview:menuVC.view];
    
    NSLog(@"menuVC view: %@", NSStringFromCGRect(menuVC.view.frame));
    
    // 3. 添加setting视图
    CZSettingViewController *settingVC = [[CZSettingViewController alloc] init];
    [self addChildViewController:settingVC];
    [self.rigthView addSubview:settingVC.view];
    
    NSLog(@"settings view: %@", NSStringFromCGRect(settingVC.view.frame));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectMenu:) name:@"MenuViewControllerSelectedItem" object:nil];
}

- (void)selectMenu:(NSNotification *)notification
{
    NSLog(@"%@", notification);
    // 使用notification.object字符串动态替换nav的跟视图控制器
    // 使用字符串创建视图控制器
    UIViewController *vc = [[NSClassFromString(notification.object) alloc] init];
    // 更改nav的根视图控制器
    // 经典的多态应用
    self.navVC.viewControllers = @[vc];
    
    // 恢复状态
    [self restoreLocation];
}

@end
