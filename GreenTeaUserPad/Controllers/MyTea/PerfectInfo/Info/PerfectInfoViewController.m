//
//  PerfectInfoViewController.m
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/28.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "PerfectInfoViewController.h"
#import "BasicInfoViewController.h"
#import "CertificateViewController.h"
#import "InfoViewControllerDelegate.h"
#import "UIView+Frame.h"

#define kContentScrollerViewHeight self.contentScrollView.frame.size.height
#define kInfoButtonHeight 40
#define kHealthBlueViewWidth 60
#define kBtnSelectedColor [UIColor colorWithString:@"#c90916"]
#define kBtnDefaultColor  [UIColor colorWithString:@"#666666"]

@interface PerfectInfoViewController ()<UIScrollViewDelegate, InfoViewControllerDelegate>

@property (nonatomic, strong) BasicInfoViewController *infoVC;//基本资料
@property (nonatomic, strong) CertificateViewController *certicateVC;//相关证件

@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIButton *baseBtn;
@property (weak, nonatomic) IBOutlet UIButton *certBtn;

@property (nonatomic, strong) UIView *btnLineView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation PerfectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title =@"资料完善";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置scrollView
    self.contentScrollView.contentSize = CGSizeMake(kScreenBoundWidth * 2, kContentScrollerViewHeight);
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    self.contentScrollView.scrollEnabled = NO;
    self.contentScrollView.delegate = self;
    
    //将二个页面添加到ContentScrollView上面
    self.infoVC = [[BasicInfoViewController alloc] init];
    self.infoVC.view.frame = CGRectMake(kScreenBoundWidth * 0, 0, kScreenBoundWidth, kContentScrollerViewHeight);
    self.infoVC.basicDelegate = self;
    [self.contentScrollView addSubview:self.infoVC.view];
    
    self.certicateVC = [[CertificateViewController alloc] init];
    self.certicateVC.certificateDelegate = self;
    self.certicateVC.infoVC = self;
    self.certicateVC.view.frame = CGRectMake(kScreenBoundWidth * 1, 0, kScreenBoundWidth, kContentScrollerViewHeight);

    [self.contentScrollView addSubview:self.certicateVC.view];
    
    // 设置BtnLine
    CGFloat btnLineViewHeight = 2;
    CGFloat btnLineViewX = kScreenBoundWidth / 4 - kHealthBlueViewWidth / 2;
    CGFloat btnLIneViewY = kInfoButtonHeight - btnLineViewHeight;
    self.btnLineView = [[UIView alloc] init];
    self.btnLineView.frame = CGRectMake(btnLineViewX, btnLIneViewY, kHealthBlueViewWidth, btnLineViewHeight);
    self.btnLineView.backgroundColor = kBtnSelectedColor;
    [self.view addSubview:self.btnLineView];
    
    [self.baseBtn setTitleColor:kBtnSelectedColor forState:UIControlStateNormal];
    [self.certBtn setTitleColor:kBtnDefaultColor forState:UIControlStateNormal];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
//    __weak InfoViewController*blcokself = self;
    __weak typeof(self) weakSelf = self;
    [self setRightBtn:@"确定" eventHandler:^(id sender) {
        [weakSelf savetheData];
    }];
}

//viewWillLayoutSubviews
- (void)viewWillLayoutSubviews {
    self.infoVC.view.frame = CGRectMake(kScreenBoundWidth * 0, 0, kScreenBoundWidth, kContentScrollerViewHeight);
    self.certicateVC.view.frame = CGRectMake(kScreenBoundWidth * 1, 0, kScreenBoundWidth, kContentScrollerViewHeight);
    
    
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
-(void)savetheData{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

#pragma mark - InfoViewControllerDelegate
- (void)infoPushWithViewController:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - event response
- (IBAction)BaseBtnClick:(UIButton *)sender {
    
    [self.baseBtn setTitleColor:kBtnSelectedColor forState:UIControlStateNormal];
    [self.certBtn setTitleColor:kBtnDefaultColor forState:UIControlStateNormal];
    [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat btnLineViewX = kScreenBoundWidth / 4 - kHealthBlueViewWidth / 2;
        self.btnLineView.x = btnLineViewX;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)CertBtnClick:(UIButton *)sender {
    
    [self.baseBtn setTitleColor:kBtnDefaultColor forState:UIControlStateNormal];
    [self.certBtn setTitleColor:kBtnSelectedColor forState:UIControlStateNormal];
    [self.contentScrollView setContentOffset:CGPointMake(kScreenBoundWidth, 0) animated:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat btnLineViewX = kScreenBoundWidth / 4 * 3 - kHealthBlueViewWidth / 2;
        self.btnLineView.x = btnLineViewX;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
