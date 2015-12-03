//
//  RegisterViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+Validation.h"
#import "TFDatePickerView.h"
#import "ChangeSuccessViewController.h"


@interface RegisterViewController ()<UITextFieldDelegate, UIAlertViewDelegate, TFDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *companyRegister;
@property (weak, nonatomic) IBOutlet UIView *thePersonalRegister;
@property (weak, nonatomic) IBOutlet UIButton *thePersonButton;
@property (weak, nonatomic) IBOutlet UIButton *theCompanyButton;
@property (weak, nonatomic) IBOutlet UITextField *personalName; // 用户名
@property (weak, nonatomic) IBOutlet UITextField *personalKeyWord; // 设置密码
@property (weak, nonatomic) IBOutlet UITextField *conFirnpersonKey; // 确认密码
@property (weak, nonatomic) IBOutlet UITextField *personName; // 姓名
@property (weak, nonatomic) IBOutlet UITextField *personSex; // 性别
@property (weak, nonatomic) IBOutlet UITextField *personIdcard; // 身份证号
@property (weak, nonatomic) IBOutlet UITextField *personBirth; // 出生日期
@property (weak, nonatomic) IBOutlet UITextField *personOffice; // 签发机关
@property (weak, nonatomic) IBOutlet UITextField *personConfirm; // 验证码
@property (weak, nonatomic) IBOutlet UIButton *personConfirmButton; // 获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *personSubmmitConfirmButton; // 立即注册
@property (weak, nonatomic) IBOutlet UITextField *companyInfo; // 用户名
@property (weak, nonatomic) IBOutlet UITextField *companyConFirmKey; // 确认密码
@property (weak, nonatomic) IBOutlet UITextField *companyName; // 公司名称
@property (weak, nonatomic) IBOutlet UITextField *companyLegalName; // 法人代表
@property (weak, nonatomic) IBOutlet UITextField *companyNumber; // 注册号
@property (weak, nonatomic) IBOutlet UITextField *companyAdress; // 地址
@property (weak, nonatomic) IBOutlet UITextField *companyMoney; // 注册号
@property (weak, nonatomic) IBOutlet UITextField *companyConfirm; // 验证码
@property (weak, nonatomic) IBOutlet UITextField *companyKey; // 设置密码
/// 获取验证码
@property (weak, nonatomic) IBOutlet UIButton *companConfirmButton; // 获取验证码
@property (weak, nonatomic) IBOutlet UIButton *companySubmmitconfirmButton; //  立即注册
@property (nonatomic, retain) NSDictionary *genderDic; //
@property (nonatomic, retain) UIAlertView *genderAlert; // 性别提示框
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTheButton];
    self.title = @"注册";
    self.personSex.delegate = self;
    self.personBirth.delegate = self;
    self.genderDic = @{@"男":@"0", @"女":@"1"};
    [self loadBlackButton];
    // Do any additional setup after loading the view from its nib.
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.personSex) {
        self.genderAlert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择性别" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [self.genderAlert addButtonWithTitle:@"男"];
        [self.genderAlert addButtonWithTitle:@"女"];
        [self.genderAlert show];
    }
    if (textField == self.personBirth) {
        TFDatePickerView *datePickerView = [TFDatePickerView tfDatePickerViewWithDatePickerMode:UIDatePickerModeDate Delegate:self];
        [datePickerView tf_show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == self.genderAlert) {
        if (buttonIndex == 0) {
            self.personSex.text = @"男";
        } else if (buttonIndex == 1) {
            self.personSex.text = @"女";
        } else{
        }
    }
}

#pragma mark - DatePickerViewDelegate
- (BOOL)submitWithSelectedDate:(NSDate *)selectedDate
{
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:selectedDate] == NSOrderedAscending) {
        return NO;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [dateFormatter stringFromDate:selectedDate];
    
    NSLog(@"%@", dateStr);
    
    self.personBirth.text = dateStr;
    
    
    return YES;
}


#pragma mark - 点击获取验证码（企业）
- (IBAction)gainVerificationForCompanyClick:(id)sender {

    if ([self.companyInfo.text validateMobile:self.companyInfo.text]) {
        
        NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_GET_USER_INFO_BLOCK&uname=%@", SERVER_HOST_PRODUCT, self.companyInfo.text];
        
        [NetWork POST:url parmater:nil Block:^(NSData *data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSNumber *success = (NSNumber *)[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_GET_USER_INFO_BLOCK"] objectForKey:@"object"] objectForKey:@"success"];
            if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户已经存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 12;
                [alert show];
            }
            else {
                NSDictionary *dic = @{@"phoneNumbers":self.companyInfo.text, @"content":@"【绿茶网】尊敬的用户，您在进行绿茶网的注册验证码：<vcode>，请妥善保管。", @"validateEvent":@"register"};
                
                [NetWork GET:VerificationMessageURL parmater:dic Block:^(NSData *data) {
                    
                    NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    
                    NSString *result = [[[[[myDic objectForKey:@"result"] objectForKey:@"config"] objectForKey:@"smsSender"] objectForKey:@"object"] objectForKey:@"succeed"];
                    
                    NSLog(@"succeed = %@", result);
                }];
                
                [self timeCountDownWithSender:sender];
            }
        }];
    }

}

#pragma mark - 点击获取验证码(个人)
- (IBAction)gainVerification:(id)sender
{

    if ([self.personalName.text validateMobile:self.personalName.text]) {
        
        NSString *url = [NSString stringWithFormat:@"%@scommerce.LC_ACC_GET_USER_INFO_BLOCK&uname=%@", SERVER_HOST_PRODUCT, self.personalName.text];
        
        [NetWork POST:url parmater:nil Block:^(NSData *data) {
            NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSNumber *success = (NSNumber *)[[[[[myDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"LC_ACC_GET_USER_INFO_BLOCK"] objectForKey:@"object"] objectForKey:@"success"];
            if ([success isEqualToNumber:[NSNumber numberWithInt:1]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户已经存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 12;
                [alert show];
            }
            else {
                NSDictionary *dic = @{@"phoneNumbers":_personalName.text, @"content":@"【绿茶网】尊敬的用户，您在进行绿茶网的注册验证码：<vcode>，请妥善保管。", @"validateEvent":@"register"};
                
                [NetWork GET:VerificationMessageURL parmater:dic Block:^(NSData *data) {
                    
                    NSDictionary *myDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    
                    NSString *result = [[[[[myDic objectForKey:@"result"] objectForKey:@"config"] objectForKey:@"smsSender"] objectForKey:@"object"] objectForKey:@"succeed"];
                    
                    NSLog(@"succeed = %@", result);
                }];
                
                [self timeCountDownWithSender:sender];
            }
        }];
    }

}

#pragma mark - 检查输入（企业）
- (BOOL)checkListPersonInputForCompany
{
    if ([self.companyInfo.text length] == 0) {
        [self showAlertWithTitle:@"请输入企业用户名" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.companyConfirm.text length] == 0) {
        [self showAlertWithTitle:@"请输入验证码" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.companyKey.text length] == 0) {
        [self showAlertWithTitle:@"请输入密码" cancelButtonTitle:@"确定"];
        return NO;
    } else if (![self.companyConFirmKey.text isEqualToString:self.companyKey.text]) {
        [self showAlertWithTitle:@"两次密码不一致" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.companyName.text length] == 0) {
        [self showAlertWithTitle:@"请输入公司名称" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.companyLegalName.text length] == 0) {
        [self showAlertWithTitle:@"请输入法人代表" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.companyNumber.text length] == 0) {
        [self showAlertWithTitle:@"请输入注册号" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.companyMoney.text length] == 0) {
        [self showAlertWithTitle:@"请输入注册资本" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.companyAdress.text length] == 0) {
        [self showAlertWithTitle:@"请输入住所" cancelButtonTitle:@"确定"];
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - 检查输入（个人）
- (BOOL)checkListPersonInput
{
    if ([self.personalName.text length] == 0) {
        [self showAlertWithTitle:@"请输入个人用户名" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.personConfirm.text length] == 0) {
        [self showAlertWithTitle:@"请输入验证码" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.personalKeyWord.text length] == 0) {
        [self showAlertWithTitle:@"请输入密码" cancelButtonTitle:@"确定"];
        return NO;
    } else if (![self.conFirnpersonKey.text isEqualToString:self.personalKeyWord.text]) {
        [self showAlertWithTitle:@"两次密码不一致" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.personName.text length] == 0) {
        [self showAlertWithTitle:@"请输入姓名" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.personSex.text length] == 0) {
        [self showAlertWithTitle:@"请输入性别" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.personIdcard.text length] != 18) {
        [self showAlertWithTitle:@"身份证号位数不够" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.personBirth.text length] == 0) {
        [self showAlertWithTitle:@"请输入出生日期" cancelButtonTitle:@"确定"];
        return NO;
    } else if ([self.personOffice.text length] == 0) {
        [self showAlertWithTitle:@"请输入签发机关" cancelButtonTitle:@"确定"];
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - 提示框
- (void)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - 拼接请求参数(企业)
- (NSDictionary *)appendParmaterForCompany
{
    NSDictionary *extensionsDic =@{
                                   @"accountType":@"company",
                                   @"companyName":self.companyName.text,
                                   @"legalRepresentative":self.companyLegalName.text,
                                   @"registrationNumber":self.companyNumber.text,
                                   @"registeredAssets":self.companyMoney.text,
                                   @"residence":self.companyAdress.text};
    NSString *extensionsStr = [self transformWithDictionary:extensionsDic];
    
    NSDictionary *parmater = @{@"mcode":self.companyConfirm.text,
                               @"validateEvent":@"register",
                               @"validateObject":self.companyInfo.text,
                               @"validateType":@"mobile",
                               @"userName":self.companyInfo.text,
                               @"userType":@"company",
                               @"mobile":self.companyInfo.text,
                               @"userPassword":self.companyKey.text,
                               @"isMobileChecked":@"true",
                               @"exts":@"{}",
                               @"locked":@"false",
                               @"login":@"true",
                               @"extensions":extensionsStr};
    return parmater;
}


#pragma mark - 拼接请求参数(个人)
- (NSDictionary *)appendParmater
{
    NSDictionary *extensionsDic =@{
                                   @"accountType":@"individual",
                                   @"idCard":self.personIdcard.text,
                                   @"issuingAuthority":self.personOffice.text};
    NSString *extensionsStr = [self transformWithDictionary:extensionsDic];
    
    NSDictionary *parmater = @{@"mcode":self.personConfirm.text,
                               @"gender":[self.genderDic objectForKey:self.personSex.text],
                               @"validateEvent":@"register",
                               @"validateObject":self.personalName.text,
                               @"validateType":@"mobile",
                               @"userName":self.personalName.text,
                               @"realName":self.personName.text,
                               @"userType":@"individual",
                               @"mobile":self.personalName.text,
                               @"userPassword":self.personalKeyWord.text,
                               @"isMobileChecked":@"true",
                               @"birthday":self.personBirth.text,
                               @"exts":@"{}",
                               @"locked":@"false",
                               @"login":@"true",
                               @"extensions":extensionsStr};
    return parmater;
}


#pragma mark - 将字典转换成扩展字符串
- (NSString *)transformWithDictionary:(NSDictionary *)dic
{
    NSMutableString *string = [[NSMutableString alloc] init];
    for (NSString *key in dic) {
        NSString *str = [NSString stringWithFormat:@"%@<paramValue>%@<paramSplit>", key, [dic objectForKey:key]];
        [string appendString:str];
    }
    
    return string;
}


#pragma mark - 立即注册（企业）
- (IBAction)registNowForCompanyClick:(id)sender
{
    NSLog(@"企业注册");
    // 检查输入 如果输入正确就发送注册请求
    if ([self checkListPersonInputForCompany]) {
        
        NSDictionary *dic = [self appendParmaterForCompany];
        
        [NetWork GET:RegistURL parmater:dic Block:^(NSData *data) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dataDic == %@", dataDic);
            
            NSDictionary *accountDic = [[[[dataDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"CL_ACC_ACCOUNT_REGISTER_ACTION"] objectForKey:@"object"];
            
            NSString *success = [accountDic objectForKey:@"success"];
            NSLog(@"success = %@", success);
            
            NSNumber *result = (NSNumber *)success;
            if ([result isEqualToNumber:[NSNumber numberWithInt:1]]) {
                
                Account *account = [Account initAccount:accountDic];
                [AccountManager sharedInstance].account = account;
                [[AccountManager sharedInstance] saveAccountInfoToDisk];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
                ChangeSuccessViewController *success = [[ChangeSuccessViewController alloc] init];
                                success.showStr = @"注册成功";
                [self.navigationController pushViewController:success animated:YES];
                
                
            }else if ([result isEqualToNumber:[NSNumber numberWithInt:2]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名已经存在" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }];
    }

}

#pragma mark - 点击立即注册(个人)
- (IBAction)registNowAction:(id)sender
{
    NSLog(@"个人注册");
    // 检查输入 如果输入正确就发送注册请求
    if ([self checkListPersonInput]) {
        
        NSDictionary *dic = [self appendParmater];
        
        [NetWork GET:RegistURL parmater:dic Block:^(NSData *data) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dataDic == %@", dataDic);
            
            NSDictionary *accountDic = [[[[dataDic objectForKey:@"result"] objectForKey:@"scommerce"] objectForKey:@"CL_ACC_ACCOUNT_REGISTER_ACTION"] objectForKey:@"object"];
            
            NSString *success = [accountDic objectForKey:@"success"];
            NSLog(@"success = %@", success);
            
            NSNumber *result = (NSNumber *)success;
            if ([result isEqualToNumber:[NSNumber numberWithInt:1]]) {
                
                Account *account = [Account initAccount:accountDic];
                [AccountManager sharedInstance].account = account;
                [[AccountManager sharedInstance] saveAccountInfoToDisk];
                
                ChangeSuccessViewController *success = [[ChangeSuccessViewController alloc] init];
                success.showStr = @"注册成功";
                [self.navigationController pushViewController:success animated:YES];
                
                
            }else if ([result isEqualToNumber:[NSNumber numberWithInt:2]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名已经存在" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码有误" message:nil delegate: self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }];
    }
    
}


#pragma mark - 倒计时
- (void)timeCountDownWithSender:(UIButton *)sender
{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                sender.userInteractionEnabled = YES;
                sender.backgroundColor = [UIColor lightGrayColor];
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d秒后重发", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.userInteractionEnabled = NO;
                sender.backgroundColor = [UIColor lightGrayColor];
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


-(void)loadTheButton{
    [self.thePersonButton addTarget:self action:@selector(changeTheViewToFont) forControlEvents:(UIControlEventTouchUpInside)];
    [self.theCompanyButton addTarget:self action:@selector(changeTheViewFont) forControlEvents:(UIControlEventTouchUpInside)];
}


-(void)changeTheViewToFont{
    
    [self.thePersonButton setBackgroundImage:[UIImage imageNamed:@"z-01"] forState:UIControlStateNormal];
    [self.theCompanyButton setBackgroundImage:[UIImage imageNamed:@"z-02"] forState:UIControlStateNormal];
    [self.view endEditing:YES];
    
    [self.view bringSubviewToFront:self.thePersonalRegister];
    self.personalName.text = @"";
    self.personConfirm.text= @"";
    self.personalKeyWord.text = @"";
    self.conFirnpersonKey.text = @"";
    self.personName.text = @"";
    self.personSex.text = @"";
    self.personIdcard.text = @"";
    self.personBirth.text = @"";
    self.personOffice.text = @"";
}


-(void)changeTheViewFont{
    
    [self.thePersonButton setBackgroundImage:[UIImage imageNamed:@"person2"] forState:UIControlStateNormal];
    [self.theCompanyButton setBackgroundImage:[UIImage imageNamed:@"company2"] forState:UIControlStateNormal];
    [self.view endEditing:YES];
    [self.view bringSubviewToFront:self.companyRegister];
    self.companyInfo.text= @"";
    self.companyConFirmKey.text = @"";
    self.companyKey.text = @"";
    self.conFirnpersonKey.text = @"";
    self.companyName.text = @"";
    self.companyLegalName.text = @"";
    self.companyNumber.text = @"";
    self.companyNumber.text = @"";
    self.companyMoney.text = @"";
    self.companyAdress.text = @"";

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
