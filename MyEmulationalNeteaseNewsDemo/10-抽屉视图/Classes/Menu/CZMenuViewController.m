//
//  CZMenuViewController.m
//  10-抽屉视图
//
//  Created by apple on 11/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZMenuViewController.h"
#import "CZMenuCell.h"

static NSString *ID = @"MenuID";

@interface CZMenuViewController ()
@property (nonatomic, strong) NSArray *menuList;
@end

@implementation CZMenuViewController

- (NSArray *)menuList
{
    if (!_menuList) {
        _menuList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"navmenu.plist" ofType:nil]];
    }
    return _menuList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 修改单元格的高度
    self.tableView.rowHeight = (self.view.bounds.size.height - 100) / self.menuList.count;
    
    // 为表格注册可重用单元格，使用CZMenuCell实例化出来的单元格，是可重用单元格
    [self.tableView registerClass:[CZMenuCell class] forCellReuseIdentifier:ID];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    NSDictionary *dict = self.menuList[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:dict[@"imageName"]];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.menuList[indexPath.row];
    NSLog(@"%@", dict);
    
    // 通知RootViewController更新视图控制器
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MenuViewControllerSelectedItem" object:dict[@"className"] userInfo:nil];
}

@end
