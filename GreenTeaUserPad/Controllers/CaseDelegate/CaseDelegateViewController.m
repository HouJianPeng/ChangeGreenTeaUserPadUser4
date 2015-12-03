//
//  CaseDelegateViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "CaseDelegateViewController.h"
#import "ZHPickView.h"
#import "ProvinceViewController.h"
#import "EntrustSuccessViewController.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
@interface CaseDelegateViewController ()<ZHPickViewDelegate,UITextFieldDelegate,UITextViewDelegate,ProvinceViewControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *caseTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseAreaTextField;
@property (weak, nonatomic) IBOutlet UITextView *caseDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *upResultTextField;
@property (weak, nonatomic) IBOutlet UIButton *caseUpDataButton;
@property (weak, nonatomic) IBOutlet UIButton *caseSubmmitButton;
@property (weak, nonatomic) NSString *districtId;
@property (strong, nonatomic) ZHPickView *pickViewTwo;
@end

@implementation CaseDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTheView];
    [self loadBlackButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)loadBlackButton{
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark 案件类型选择框
-(void)loadPickViewtwo{
    NSArray*array = @[@"公司法律事务",
                      @"银行与金融",
                      @"公司收购、兼并与重组",
                      @"房地产与建筑工程",
                      @"知识产权",
                      @"劳动争议",
                      @"民商事合同诉讼与仲裁",
                      @"刑事案件",
                      @"证券与资本市场",
                      @"私募股权与投资基金"
                      ];
    self.pickViewTwo =[[ZHPickView alloc]initPickviewWithArray:array isHaveNavControler:YES];
    self.pickViewTwo.delegate =self;
    [self.pickViewTwo show];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
-(void)loadTheView{
    

    self.title = @"案件委托";
    self.caseTypeTextField.delegate = self;
    self.caseTitleTextField.delegate = self;
    self.caseAreaTextField.delegate = self;
    self.caseDescriptionTextView.delegate = self;
    [self.caseSubmmitButton addTarget:self action:@selector(clickTheButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.caseUpDataButton addTarget:self action:@selector(submitClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.caseDescriptionTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.caseDescriptionTextView.layer.borderWidth = 0.5;
    self.caseDescriptionTextView.layer.cornerRadius = 5;
    self.caseDescriptionTextView.layer.masksToBounds = YES;

}
#pragma mark 省份选择
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.caseAreaTextField) {
        [self.view endEditing:YES];
        [self.pickViewTwo remove];
        ProvinceViewController*provice = [[ProvinceViewController alloc] init];
        provice.delegate = self;
        [self.navigationController pushViewController:provice animated:YES];
        return NO;
    }
    else if(textField==self.caseTypeTextField){
        [self.view endEditing:YES];
        [self loadPickViewtwo];
        return NO;
    }
    else{
        [self.pickViewTwo remove];
        return YES;
    }
}
#pragma mark 加载视图
- (void)doBack:(UIButton *)sender
{
    [self.pickViewTwo remove];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark 案件描述代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}
#pragma mark选择的省市
-(void)pushTheProvince:(NSMutableArray *)array{
    self.districtId = array[1];
    NSLog(@"%@ %@",self.districtId,array[0]);
    self.caseAreaTextField.text = array[0];
}
#pragma mark 选择结果显示
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    self.caseTypeTextField.text=resultString;
    [self.pickViewTwo remove];
}

-(void)clickTheButton{
    if ([self.caseTypeTextField.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件类型不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
    else
        if ([self.caseTitleTextField.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件标题不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }else if ([self.caseTitleTextField.text length] > 20){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"标题不超过20" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self.caseAreaTextField.text isEqualToString:@""])
    { UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"所在区域不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }else if ([self.caseDescriptionTextView.text length] < 50 || [self.caseDescriptionTextView.text length] > 500){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容不少于50，不多于500" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self.caseDescriptionTextView.text isEqualToString:@""]){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"案件描述不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
    else{
        if ([AccountManager sharedInstance].account.isLogin) {
            [self pushTheModel];
        }
        else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没有登陆不可以发布案件" delegate:self cancelButtonTitle:@"登陆" otherButtonTitles:@"取消", nil];
            alert.tag =3000;
            alert.delegate = self;
            [alert show];
         }
    }
    
}
#pragma mark 登陆页面
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==3000) {
        if (buttonIndex==0) {
            LoginViewController * login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }
 
}
#pragma mark post发送数据
-(void)pushTheModel{
    NSString *userId = [AccountManager sharedInstance].account.userId;
    NSDictionary*theDic = @{@"公司法律事务":@"A",
                            @"银行与金融":@"B",
                            @"公司收购、兼并与重组":@"C",
                            @"房地产与建筑工程":@"D",
                            @"知识产权":@"E",
                            @"劳动争议":@"F",
                            @"民商事合同诉讼与仲裁":@"G",
                            @"刑事案件":@"H",
                            @"证券与资本市场":@"I",
                            @"私募股权与投资基金":@"J"
                            };
    NSLog(@"%@",[theDic objectForKey:self.caseTypeTextField.text]);
    
    NSDictionary *dict = @{@"cosmosPassportId":userId, @"caseTitle": self.caseTitleTextField.text,@"businessType":theDic[self.caseTypeTextField.text],@"description":self.caseDescriptionTextView.text,@"attachment":self.upResultTextField.text,@"districtId":self.districtId,@"street":@""};
    NSString*url = [NSString stringWithFormat: @"%@scommerce.LC_CASE_LAWCASE_SAVE_ACTION", SERVER_HOST_PRODUCT];
        [NetWork POST:url parmater:dict Block:^(NSData *data) {
        if (data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"success"] intValue]==0) {
                UIAlertView*alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"案件发布失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
            }
            else{
                NSLog(@"%@",myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"lawcaseNo"]);
                [self pushTheNextView:[NSString stringWithFormat:@"%@", myDic[@"result"][@"scommerce"][@"LC_CASE_LAWCASE_SAVE_ACTION"][@"object"][@"lawcaseNo"]]];
                
            }
        }
    }];
    
}
-(void)pushTheNextView:(NSString*)string{
    EntrustSuccessViewController *entrustSuccessViewController = [[EntrustSuccessViewController alloc] init];
    entrustSuccessViewController.lawcaseNo = string;
    [self.navigationController pushViewController:entrustSuccessViewController animated:YES];
}
#pragma mark - event response
- (void)submitClick:(UIButton *)sender {

    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        

        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath RelPathEnum:RelPathApply success:^(NSString *assetId, NSString *fileName, NSString *fileUrl) {
            // 上传成功逻辑
            [self.upResultTextField setText:assetId];
//            self.assetId = assetId;
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        } failure:^(NSString *message) {
            // 上传失败逻辑
            NSLog(@"message = %@", message);
        }];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
