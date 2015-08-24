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
    
    NSMutableAttributedString *encodedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"明文密码 | %@",_item.encodedText]];
    [encodedStr setAttributes:[NSDictionary dictionaryWithObjects:@[[UIFont systemFontOfSize:14.0f],GlobalGray] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]] range:NSMakeRange(0, 7)];
    
    NSMutableAttributedString *usernameStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"用户名 | %@",_item.userName]];
    [usernameStr setAttributes:[NSDictionary dictionaryWithObjects:@[[UIFont systemFontOfSize:14.0f],GlobalGray] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]] range:NSMakeRange(0, 6)];
    
    _seperatorView.frame = CGRectMake(0.0f, self.height - 20.0f, ScreenWidth, 20.0f);
    
    CGFloat titleHeight = [UIKitHelper getTextHeightWithText:_item.passwordTitle andMaxWidth:self.width - 30.0f andFont:[UIFont boldSystemFontOfSize:20.0f]];
    _passwordTitleLabel.frame = CGRectMake(15.0f, 15.0f, self.width - 30.0f, titleHeight);
    _passwordCodeLabel.frame = CGRectMake(15.0f, _passwordTitleLabel.bottom + 10.0f, self.width - 30.0f, 23.0f);
    
    CGFloat linkHeight = [UIKitHelper getTextHeightWithText:[NSString stringWithFormat:@"密码链接地址 | %@",_item.passwordLink] andMaxWidth:self.width - 30.0f andFont:[UIFont systemFontOfSize:14.0f]];
    _passwordLinkTextView.frame = CGRectMake(15.0f, _passwordCodeLabel.bottom + 10.0f, self.width - 30.0f, linkHeight);
    
    CGFloat usernameHeight = [UIKitHelper getTextHeightWithText:[NSString stringWithFormat:@"用户名 | %@",_item.userName] andMaxWidth:self.width - 30.0f andFont:[UIFont systemFontOfSize:18.0f]];
    _passwordUsernameTextView.frame = CGRectMake(15.0f, _passwordLinkTextView.bottom + 10.0f, self.width - 30.0f, usernameHeight);
    
    _passwordTitleLabel.text = _item.passwordTitle;
    _passwordLinkTextView.text = [NSString stringWithFormat:@"密码链接地址 | %@",_item.passwordLink];
    _passwordUsernameTextView.attributedText = usernameStr;
    _passwordCodeLabel.attributedText = encodedStr;
}

- (void)initSubViews
{
    self.seperatorView = [[UIView alloc]initWithFrame:CGRectZero];
    _seperatorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:_seperatorView];
    
    self.passwordTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    _passwordTitleLabel.textColor = [UIColor blackColor];
    _passwordTitleLabel.numberOfLines = 0;
    _passwordTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_passwordTitleLabel];
    
    self.passwordLinkTextView = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordLinkTextView.font = [UIFont systemFontOfSize:14.0f];
    _passwordLinkTextView.textColor = GlobalGray;
    [self.contentView addSubview:_passwordLinkTextView];
    
    self.passwordUsernameTextView = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordUsernameTextView.font = [UIFont systemFontOfSize:18.0f];
    _passwordUsernameTextView.textColor = GlobalNavGray;
    [self.contentView addSubview:_passwordUsernameTextView];
    
    self.passwordCodeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _passwordCodeLabel.font = [UIFont systemFontOfSize:20.0f];
    _passwordCodeLabel.textColor = GlobalNavGray;
    [self.contentView addSubview:_passwordCodeLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
