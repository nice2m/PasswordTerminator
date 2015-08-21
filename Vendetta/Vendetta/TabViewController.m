//
//  TabViewController.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/12.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "TabViewController.h"
#import "GlobalHeader.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
    self.delegate=self;
    UITabBarItem *fuck=[self.tabBar.items objectAtIndex:0];
    UIImage *img1=[UIImage imageNamed:@"first"];
    UIImage *img1_selected=[UIImage imageNamed:@"firstSelected"];
    img1=[img1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    img1_selected=[img1_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fuck.image=img1;
    fuck.selectedImage=img1_selected;
    
    UITabBarItem *fuck1=[self.tabBar.items objectAtIndex:1];
    UIImage *img=[UIImage imageNamed:@"second"];
    UIImage *img_selected=[UIImage imageNamed:@"secondSelected"];
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    img_selected=[img_selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    fuck1.image=img;
    fuck1.selectedImage=img_selected;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName : GlobalGray} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName : GlobalGray} forState:UIControlStateSelected];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
