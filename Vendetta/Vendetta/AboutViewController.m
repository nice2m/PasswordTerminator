//
//  AboutViewController.m
//  Vendetta
//
//  Created by Yh c on 15/10/19.
//  Copyright © 2015年 chen Yuheng. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *MainView;
@property (weak, nonatomic) IBOutlet UITextView *ContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *LinkLabel;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BackBtn.layer.cornerRadius = 4.0f;
    self.BackBtn.layer.masksToBounds = YES;
    self.MainView.frame = CGRectMake(0.0f, 0.0f,ScreenWidth , ScreenHeight);
    [self.ContentTextView sizeToFit];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jump)];
    [self.LinkLabel addGestureRecognizer:tap];
    [self.LinkLabel sizeToFit];
    // Do any additional setup after loading the view.
}

- (void)jump
{
    NSURL *url= [NSURL URLWithString:@"https://github.com/SergioChan/PasswordTerminator"];
    [[UIApplication sharedApplication] openURL:url];
}

- (CGFloat)getTextHeight:(UITextView *)textView
{
    UITextView *tmp_textView = [[UITextView alloc]initWithFrame:textView.frame];
    tmp_textView.font = textView.font;
    tmp_textView.text = textView.text;
    [tmp_textView sizeToFit];
    return tmp_textView.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
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
