//
//  CacheManager+Patch.h
//  Vendetta
//
//  Created by nice2meet on 2019/2/21.
//  Copyright © 2019 chen Yuheng. All rights reserved.
//

#import "CacheManager.h"

/**
 
 
 表示很喜欢这款应用，谢谢分享。
 
 
 
 
 
 0x0 问题：我的手机是 16GB 的，很多时候系统提示内存满了，然后再次打开password terminator，之前存储的密码就不见了，泪崩~
 
 0x1 原因：
由于 CacheManager.m 中 32行处，self.rootCachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]; 错误
 
 关键:Put data cache files in the Library/Caches/ directory. Cache data can be used for any data that needs to persist longer than temporary data, but not as long as a support file. Generally speaking, the application does not require cache data to operate properly, but it can use cache data to improve performance. Examples of cache data include (but are not limited to) database cache files and transient, downloadable content. Note that the system may delete the Caches/ directory to free up disk space, so your app must be able to re-create or download these files as needed.

 参考：https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW1
 
 0x2 解决：在用户升级安装的后，首次启动，检测以前的目录是否有内容：如果，有那么转移到Documents/目录下，并且新增的内容都存入到Documents/ 如果没有，以后的内容都存入到Documents/下；
 

 @param Patch 处理bug
 @return 无
 */
NS_ASSUME_NONNULL_BEGIN

@interface CacheManager (Patch)

- (void)nt_bugFix_for_build_3;

- (NSString *)rootCachePath;

@end

NS_ASSUME_NONNULL_END
