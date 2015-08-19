//
//  MyNextPasswordChoiceTableViewCell.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/19.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "MyNextPasswordChoiceTableViewCell.h"
#import "UIViewExt.h"

@implementation MyNextPasswordChoiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.customSeperatorView = [[UIView alloc]initWithFrame:CGRectZero];
        _customSeperatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_customSeperatorView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _customSeperatorView.frame = CGRectMake(0.0f, self.height - 1.0f, ScreenWidth, 1.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
