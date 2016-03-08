//
//  CZMenuCell.m
//  10-抽屉视图
//
//  Created by apple on 11/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CZMenuCell.h"

@implementation CZMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        
        // 取消选中样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected) { // 选中
        self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

@end
