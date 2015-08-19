//
//  MyTableViewController.m
//  Vendetta
//
//  Created by chen Yuheng on 15/8/12.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "MyTableViewController.h"
#import "UINavigationBar+Awesome.h"
#import "MyNextPasswordTableViewCell.h"
#import "MyNextPasswordChoiceTableViewCell.h"
#import "PasswordFactory.h"

@interface MyTableViewController ()
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger seconds;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *codeLabel;

@property (nonatomic) NSInteger passwordLength;
@property (nonatomic) BOOL hasUpperCase;
@property (nonatomic) BOOL hasSpecialCharac
;
@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideExtraCellLine];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.passwordLength = 6;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeUpdate:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.seconds = 0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:GlobalNavGray];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_timer fire];
}

- (void)timeUpdate:(id)sender
{
    if(self.seconds == 0)
    {
        [self timeRefresh];
        return;
    }
    self.seconds--;
    self.timerLabel.text = [NSString stringWithFormat:@"%ld秒后刷新",self.seconds];
}

- (void)timeRefresh
{
    self.seconds = CELL_UPDATE_INTERVAL;
    self.timerLabel.text = [NSString stringWithFormat:@"%ld秒后刷新",self.seconds];
    self.code = [PasswordFactory passwordWithLength:self.passwordLength withUppercase:self.hasUpperCase withSpecialCharacters:self.hasSpecialCharac];
    self.codeLabel.text = self.code;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 6;
            break;
        default:
            return 0;
            break;
    }
}

- (void) hideExtraCellLine
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            MyNextPasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstSectionCell"];
            if(!cell)
            {
                cell = [[MyNextPasswordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstSectionCell"];
                
                __weak MyTableViewController *weakSelf = self;
                cell.refreshBlock = ^(void){
                    [weakSelf timeRefresh];
                };
                self.timerLabel = cell.timeLabel;
                self.codeLabel = cell.serialCodeLabel;
            }
            return cell;
        }
            break;
        case 1:
        {
            MyNextPasswordChoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondSectionCell"];
            if(!cell)
            {
                cell = [[MyNextPasswordChoiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondSectionCell"];
                switch (indexPath.row) {
                    case 0:
                    {
                        cell.customChoiceTitleLabel.text = @"生成7位长度密码";
                    }
                        break;
                    case 1:
                    {
                        cell.customChoiceTitleLabel.text = @"生成8位长度密码";
                    }
                        break;
                    case 2:
                    {
                        cell.customChoiceTitleLabel.text = @"生成9位长度密码";
                    }
                        break;
                    case 3:
                    {
                        cell.customChoiceTitleLabel.text = @"生成10位长度密码";
                    }
                        break;
                    case 4:
                    {
                        cell.customChoiceTitleLabel.text = @"密码中带有大写英文字母";
                    }
                        break;
                    case 5:
                    {
                        cell.customChoiceTitleLabel.text = @"密码中带有特殊符号";
                    }
                        break;
                    default:
                        break;
                }
            }
            return cell;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 150.0f;
    }
    else
    {
        return 60.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return;
    }
    else
    {
        MyNextPasswordChoiceTableViewCell *cell = (MyNextPasswordChoiceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
            case 1:
            case 2:
            case 3:
            {
                if(self.passwordLength != indexPath.row + 7)
                {
                    if(self.passwordLength >= 7)
                    {
                        [(MyNextPasswordChoiceTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.passwordLength - 7 inSection:1]] contentView].backgroundColor = [UIColor clearColor];
                        [(MyNextPasswordChoiceTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.passwordLength - 7 inSection:1]] selectedIconImageView].hidden = YES;
                    }
                    self.passwordLength = indexPath.row + 7;
                    cell.selectedIconImageView.hidden = NO;
                    cell.contentView.backgroundColor = GlobalSelectedGray;
                }
                else
                {
                    self.passwordLength = 6;
                    cell.selectedIconImageView.hidden = YES;
                    cell.contentView.backgroundColor = [UIColor clearColor];
                }
            }
                break;
            case 4:
            {
                if(self.hasUpperCase)
                {
                    self.hasUpperCase = NO;
                    cell.selectedIconImageView.hidden = YES;
                    cell.contentView.backgroundColor = [UIColor clearColor];
                }
                else
                {
                    self.hasUpperCase = YES;
                    cell.selectedIconImageView.hidden = NO;
                    cell.contentView.backgroundColor = GlobalSelectedGray;
                }
            }
                break;
            case 5 :
            {
                if(self.hasSpecialCharac)
                {
                    self.hasSpecialCharac = NO;
                    cell.selectedIconImageView.hidden = YES;
                    cell.contentView.backgroundColor = [UIColor clearColor];
                }
                else
                {
                    self.hasSpecialCharac = YES;
                    cell.selectedIconImageView.hidden = NO;
                    cell.contentView.backgroundColor = GlobalSelectedGray;
                }
            }
                break;
            default:
                break;
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
