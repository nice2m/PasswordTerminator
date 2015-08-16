//
//  MyNextPasswordTableViewCell.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/16.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "MyNextPasswordTableViewCell.h"

@implementation MyNextPasswordTableViewCell

 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.customBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
        _customBackgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_customBackgroundView];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.textColor = [UIColor lightTextColor];
        [_customBackgroundView addSubview:_timeLabel];
        
        self.serialCodeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _serialCodeLabel.font = [UIFont systemFontOfSize:20.0f];
        _serialCodeLabel.textColor = [UIColor blackColor];
        [_customBackgroundView addSubview:_serialCodeLabel];
        
        self.codeTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _codeTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _codeTitleLabel.textColor = [UIColor lightTextColor];
        [_customBackgroundView addSubview:_codeTitleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
