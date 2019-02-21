//
//  CacheManager+Patch.m
//  Vendetta
//
//  Created by nice2meet on 2019/2/21.
//  Copyright © 2019 chen Yuheng. All rights reserved.
//

#import "CacheManager+Patch.h"
#import <UIKit/UIKit.h>

@implementation CacheManager (Patch)

- (void)nt_bugFix_for_build_3
{
    if(![self nt_isPreviousPasswordExists]) return;
    [self nt_transferPreviousPassword];
}

- (void)nt_transferPreviousPassword
{
    NSData * data = [NSData dataWithContentsOfFile:[self nt_previousPasswordPath]];
    [[CacheManager sharedInstance] savePasswordData:data];
    
    NSError * err;
    [[NSFileManager defaultManager] removeItemAtPath:[self nt_previousPasswordPath] error:&err];
    
}

- (BOOL)nt_isPreviousPasswordExists
{
    NSFileManager *fileManager=[NSFileManager  defaultManager];
    NSString  *cacheFilePath=[self nt_previousPasswordPath];
    return [fileManager fileExistsAtPath:cacheFilePath];
}

- (NSString *)nt_previousPasswordPath
{
    NSString * rt = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"password"];
    return rt;
}

- (NSString *)rootCachePath
{
    NSString * rt = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return rt;
}

@end
