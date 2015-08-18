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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.customBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
        _customBackgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_customBackgroundView];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont systemFontOfSize:MyNextPasswordTimeLabelFont];
        _timeLabel.textColor = GlobalGray;
        [_customBackgroundView addSubview:_timeLabel];
        
        self.serialCodeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _serialCodeLabel.font = [UIFont systemFontOfSize:MyNextPasswordCodeLabelFont];
        _serialCodeLabel.textColor = [UIColor blackColor];
        [_customBackgroundView addSubview:_serialCodeLabel];
        
        self.codeTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _codeTitleLabel.font = [UIFont systemFontOfSize:MyNextPasswordTitleLabelFont];
        _codeTitleLabel.textColor = GlobalGray;
        [_customBackgroundView addSubview:_codeTitleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _customBackgroundView.frame = CGRectMake(0.0f, 0.0f, ScreenWidth, self.height - 20.0f);
    
    CGFloat timeLabelWidth = [UIKitHelper getTextWidthWithText:@"30秒后刷新" andMaxHeight:MyNextPasswordTimeLabelFont andFont:[UIFont systemFontOfSize:MyNextPasswordTimeLabelFont]];
    _timeLabel.frame = CGRectMake((ScreenWidth - timeLabelWidth)/2.0f, 10.0f, timeLabelWidth, MyNextPasswordTimeLabelFont);
    _timeLabel.text = @"30秒后刷新";
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
