//
//  CZDrawerViewController.m
//  10-抽屉视图
//
//  Created by apple on 11/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZDrawerViewController.h"

#define kMaxOffsetY     60.0
#define kMaxRightX      280.0
#define kMaxLeftX       -220.0

@interface CZDrawerViewController ()
/** 是否拖动 */
@property (nonatomic, assign, getter = isDraging) BOOL draging;
/** 是否动画 */
@property (nonatomic, assign, getter = isAnimating) BOOL animating;
@end

@implementation CZDrawerViewController

/** 用代码建立界面的视图层次结构(所有可见的视图全部创建) */
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"sidebar_bg.jpg"];
    [self.view addSubview:imageView];
    
    // leftView
    self.leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.leftView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.leftView];
    
    // rightView
    self.rigthView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.rigthView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.rigthView];
    
    // mainView
    self.mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mainView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.mainView];
}

// 修改状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 添加一个观察者
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 如果动画设置frame，KVO不调整视图
    if (self.isAnimating) return;
    
    // 使用self.mainView的frame
    // 如果self.mainView.frame.origin.x > 0 向右
    if (self.mainView.frame.origin.x > 0) {
        // 显示左侧视图
        self.leftView.hidden = NO;
        self.rigthView.hidden = YES;
    } else {
        // 显示右侧视图
        self.leftView.hidden = YES;
        self.rigthView.hidden = NO;
    }
}

#pragma mark - 触摸事件
/** 使用偏移x值计算主视图目标的frame */
- (CGRect)rectWithOffsetX:(CGFloat)x
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    
    // 问题来源，在于x值跨越0值的时候，第一个y值的计算有问题
    // 计算目标mainView的frame
    CGRect frame = self.mainView.frame;
    // 1. x值的变化，是根据手势移动变化的
    frame.origin.x += x;
    // 2. 根据frame当前的x计算出，准确的y值，y值永远为正
    // ABS是取绝对值
    frame.origin.y = ABS(frame.origin.x * 60 / winSize.width);
    // 3. 计算宽高，计算比例
    CGFloat scale = (winSize.height - 2 * frame.origin.y) / winSize.height;
    frame.size.width = winSize.width * scale;
    frame.size.height = winSize.height * scale;
    
    return frame;
}

// 拖动手指
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 记录是拖动的
    self.draging = YES;
    
    // 取出触摸
    UITouch *touch = touches.anyObject;
    
    // 1> 当前触摸点
    CGPoint location = [touch locationInView:self.view];
    // 2> 之前触摸点
    CGPoint pLocation = [touch previousLocationInView:self.view];
    // 计算水平偏移量
    CGFloat offsetX = location.x - pLocation.x;
    
    // 3> 设置视图位置
//    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, offsetX, 0);
    self.mainView.frame = [self rectWithOffsetX:offsetX];
}

// 抬起手指时，让主视图定位
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 如果不是拖动的，直接恢复位置
    if (!self.isDraging && self.mainView.frame.origin.x != 0) {
        [self restoreLocation];
        return;
    }
    
    // 需要根据mainView.x值来确定目标位置
    // 1> x > w * 0.5 => 挪到右边去 =》 目标的X
    // 2> x + width < w * 0.5 => 挪到左边去 => 目标X
    // 3> 其他的和主窗口一般大小 => 目标的X
    CGRect frame = self.mainView.frame;
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    
    CGFloat targetX = 0;
    if (frame.origin.x > winSize.width * 0.5) {
        targetX = kMaxRightX;
    } else if (CGRectGetMaxX(frame) < winSize.width * 0.5) {
        targetX = kMaxLeftX;
    }
    // 计算出水平偏移量
    CGFloat offsetX = targetX - frame.origin.x;
    
    self.animating = YES;
    [UIView animateWithDuration:0.25 animations:^{
        if (targetX != 0) {
            self.mainView.frame = [self rectWithOffsetX:offsetX];
        } else {
            self.mainView.frame = self.view.bounds;
        }
    } completion:^(BOOL finished) {
        self.draging = NO;
        self.animating = NO;
    }];
}

// 恢复位置
- (void)restoreLocation
{
    self.animating = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        self.animating = NO;
    }];
}

@end
