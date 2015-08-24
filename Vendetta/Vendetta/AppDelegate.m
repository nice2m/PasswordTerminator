//
//  AppDelegate.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/11.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "AppDelegate.h"
#import "UIKit+Helper.h"
#import "UIImage+ImageEffects.h"

#define BlurViewTag 1001
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:keyWindow.bounds];
    view.tag = BlurViewTag;
    view.image = [[self convertViewToImage:[[UIKitHelper sharedInstance] getCurrentVC].view] applyBlurWithRadius:15.0f tintColor:[UIColor colorWithWhite:0.7f alpha:0.4f] saturationDeltaFactor:5.0f maskImage:nil];
    view.alpha = 0.0f;
    
    [UIView animateWithDuration:0.3 animations:^{
        [keyWindow addSubview:view];
        [keyWindow bringSubviewToFront:view];
        view.alpha = 1.0f;
    }];

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (UIImage *)convertViewToImage:(UIView *)view
{
    CGSize s = view.bounds.size;
    //下面方法，第一个参数表示区域大小。
    //第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。
    //第三个参数就是屏幕密度。
    
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *view = [keyWindow viewWithTag:BlurViewTag];
    if(view)
    {
        [UIView animateWithDuration:0.3 animations:^{
            view.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
