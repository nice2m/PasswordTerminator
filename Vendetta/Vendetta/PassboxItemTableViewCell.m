//
//  PassboxItemTableViewCell.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/16.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "PassboxItemTableViewCell.h"

@implementation PassboxItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _seperatorView.frame = CGRectMake(0.0f, self.height - 20.0f, ScreenWidth, 20.0f);
}

- (void)initSubViews
{
    self.seperatorView = [[UIView alloc]initWithFrame:CGRectZero];
    _seperatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_seperatorView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
