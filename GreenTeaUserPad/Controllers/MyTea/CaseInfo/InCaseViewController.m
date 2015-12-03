//
//  InCaseViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/18.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "InCaseViewController.h"
#import "CaseManager.h"

@interface InCaseViewController ()

@property (nonatomic, retain) NSDictionary *caseDic;

@end

@implementation InCaseViewController

- (void)viewDidLoad {
    self.caseDic = [NSDictionary dictionary];
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.title = @"案件详情";
    self.caseDetailTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.caseDetailTextView.layer.borderWidth = 1;
    self.caseDetailTextView.layer.cornerRadius = 5;
    self.caseDetailTextView.layer.masksToBounds = YES;

    [self netWork];
}

- (void)netWork
{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    
//    NSDictionary *dic = @{@"cosmosPassportId":userId, @"lawcaseId":self.caseId};
    NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_CASE_LAWCASE_GET_BLOCK&cosmosPassportId=%@&lawcaseId=%@", SERVER_HOST_PRODUCT, userId,self.caseId];
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NetWork GET:urlString parmater:nil Block:^(NSData *data) {
        
        NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@", myDic);
        
        self.caseDic = [[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_CASE_LAWCASE_GET_BLOCK"] objectForKey:@"list"] firstObject] firstObject];
        CaseModel *model = [CaseManager caseModelWithDict:self.caseDic];
        self.caseNumLabel.text = model.caseNo;
        self.caseTypeLabel.text = model.businessTypeLabel;
        self.caseStateLabel.text = model.statusLabel;
        self.caseDetailTextView.text = model.descriptionStr;
        self.caseTitleFiled.text =model.caseTitle;

    }];
}

- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)changeClick:(id)sender
{
    NSLog(@"修改");
    [self netWorkForChange];
}

- (void)netWorkForChange
{
    
    NSString *userId = [AccountManager sharedInstance].account.userId;
    CaseModel *model = [CaseManager caseModelWithDict:self.caseDic];
    NSDictionary *dict = @{@"cosmosPassportId":userId, @"caseTitle":self.caseTitleFiled.text, @"businessType":model.businessType, @"description":self.caseDetailTextView.text, @"attachment":model.attachment, @"districtId":model.districtId, @"street":model.street, @"lawcaseId":self.caseId};
    
    NSString*url = [NSString stringWithFormat: @"%@scommerce.LC_CASE_LAWCASE_SAVE_ACTION", SERVER_HOST_PRODUCT];
    
    [NetWork POST:url parmater:dict Block:^(NSData *data) {
        if (data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"success"] intValue] == 0) {
                UIAlertView*alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"律师已接案、待律师接单中或处理完成的案件不能修改！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else{
                NSLog(@"%@",myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"lawcaseNo"]);
                UIAlertView*alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"案件修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                }
    
        }
    }];
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
