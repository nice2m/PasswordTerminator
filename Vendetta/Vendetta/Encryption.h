//
//  Encryption.h
//  iCampus
//
//  Created by Siyu Yang on 14-8-6.
//  Copyright (c) 2014年 Siyu Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject
+ (NSString *)getSha1String:(NSString *)srcString;
+ (NSString *)getMd5String:(NSString *)srcString;
@end
