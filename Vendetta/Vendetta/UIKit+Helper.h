//
//  UIKit+Helper.h
//  Vendetta
//
//  Created by chen Yuheng on 15/8/18.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIKitHelper : UIViewController

+ (UIKitHelper*)sharedInstance;

+ (UIViewController*)viewControllerOfSuperView:(UIView *)subView;

//根据颜色生成图片
+ (UIImage *) imageFromColor:(UIColor *)color
                    andFrame:(CGRect)rect;

+ (CGFloat) getTextWidthWithText:(NSString *) text
                    andMaxHeight:(CGFloat) maxHeight
                         andFont:(UIFont *) font;

+ (CGFloat) getTextHeightWithText:(NSString *) text
                      andMaxWidth:(CGFloat) maxWidth
                          andFont:(UIFont *) font;

- (UIViewController *)getCurrentVC;
@end
