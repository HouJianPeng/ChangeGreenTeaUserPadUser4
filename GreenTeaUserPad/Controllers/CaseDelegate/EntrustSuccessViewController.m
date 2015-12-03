//
//  EntrustSuccessViewController.m
//  greenTeaUser
//
//  Created by Herron on 15/7/9.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "EntrustSuccessViewController.h"
#import "CaseDelegateViewController.h"
#import "CaseManagerViewController.h"
//#import "CaseViewController.h"
//#import "CaseConsignViewController.h"

@interface EntrustSuccessViewController ()

@end

@implementation EntrustSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBlackButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    NSLog(@"%@",self.lawcaseNo);
    self.title = @"发布成功";
    self.theLawcaseNoLabel.text = [NSString stringWithFormat:@"案件编号:%@",self.lawcaseNo];
}
-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)publishAnotherCaseClick:(id)sender
{
    CaseManagerViewController * view = [[CaseManagerViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
 
}


- (IBAction)dealCaseClick:(id)sender
{
    CaseDelegateViewController * view = [[CaseDelegateViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
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
