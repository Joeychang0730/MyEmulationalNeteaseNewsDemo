//
//  CZAppDelegate.m
//  10-抽屉视图
//
//  Created by apple on 11/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZAppDelegate.h"
#import "CZRootViewController.h"

@implementation CZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[CZRootViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
