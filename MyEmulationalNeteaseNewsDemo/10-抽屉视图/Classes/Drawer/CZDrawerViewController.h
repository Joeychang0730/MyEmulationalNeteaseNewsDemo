//
//  CZDrawerViewController.h
//  10-抽屉视图
//
//  Created by apple on 11/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZDrawerViewController : UIViewController
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rigthView;
@property (nonatomic, strong) UIView *mainView;

// 恢复位置
- (void)restoreLocation;
@end
