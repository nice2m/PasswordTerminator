//
//  PasswordFactory.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/19.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "PasswordFactory.h"

static NSString *lowerCaseLetters = @"abcdefghijklmnopqrstuvwxyz";
static NSString *upperCaseLetters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
static NSString *numbers = @"1234567890";
static NSString *characters = @":?+;!@[]*&/%$#@";

@implementation PasswordFactory

#pragma mark - 生成密码的方法
+ (NSString *)passwordWithLength:(NSInteger)length
                   withUppercase:(BOOL)uppercase
           withSpecialCharacters:(BOOL)withSpecialChrac
{
    NSString *code = [Encryption getMd5String:[Encryption getMd5String:[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]]]];
    code = [code substringToIndex:length];

    NSMutableString *resultString = [NSMutableString string];
    for(NSInteger i=0;i<code.length;i++)
    {
        int chrac = (int)[code characterAtIndex:i];
        if(i % 4 == 0)
        {
            if(uppercase)
            {
                [resultString appendString:[upperCaseLetters substringWithRange:NSMakeRange(chrac % 26, 1)]];
            }
            else
            {
                [resultString appendString:[lowerCaseLetters substringWithRange:NSMakeRange(chrac % 26, 1)]];
            }
        }
        if(i % 4 == 1)
        {
            if(withSpecialChrac)
            {
                [resultString appendString:[characters substringWithRange:NSMakeRange(chrac % 15, 1)]];
            }
            else
            {
                [resultString appendString:[numbers substringWithRange:NSMakeRange(chrac % 10, 1)]];
            }
        }
        if(i % 4 == 2)
        {
            [resultString appendString:[lowerCaseLetters substringWithRange:NSMakeRange(chrac % 26, 1)]];
        }
        if(i % 4 == 3)
        {
            [resultString appendString:[numbers substringWithRange:NSMakeRange(chrac % 10, 1)]];
        }
    }
    return resultString;
}

@end
