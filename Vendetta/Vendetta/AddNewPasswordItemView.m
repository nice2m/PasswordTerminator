//
//  AddNewPasswordItemView.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/21.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "AddNewPasswordItemView.h"

@implementation AddNewPasswordItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6.0f;
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(15.0f, 10.0f, 30.0f, 15.0f)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:GlobalGray forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_cancelButton];
        
        self.saveButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 45.0f, 10.0f, 30.0f, 15.0f)];
        [_saveButton setTitle:@"完成" forState:UIControlStateNormal];
        [_saveButton setTitleColor:GlobalGray forState:UIControlStateNormal];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_saveButton];
    }
    return self;
}
@end
