//
//  PasswordFactory.h
//  Vendetta
//
//  Created by chen Yuheng on 15/8/19.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Encryption.h"

@interface PasswordFactory : NSObject

+ (NSString *)passwordWithLength:(NSInteger)length
                   withUppercase:(BOOL)uppercase
           withSpecialCharacters:(BOOL)withSpecialChrac;
@end
