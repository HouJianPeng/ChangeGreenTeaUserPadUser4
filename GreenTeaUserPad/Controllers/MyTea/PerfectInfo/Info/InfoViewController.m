//
//  InfoViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "InfoViewController.h"
#define kContentScrollerViewHeight self.contentScrollView.frame.size.height
@interface InfoViewController ()<UIScrollViewDelegate, InfoViewControllerDelegate>

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"资料完善";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置scrollView
    self.contentScrollView.contentSize = CGSizeMake(kScreenBoundWidth * 2, 0);
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
    self.certicateVC.view.frame = CGRectMake(kScreenBoundWidth * 1, 0, kScreenBoundWidth, kContentScrollerViewHeight);
    [self.contentScrollView addSubview:self.certicateVC.view];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return_1"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    __weak InfoViewController*blcokself = self;
    //[self setRightBtn:@"确定" eventHandler:^(id sender) {
      //  [blcokself savetheData];
    //}];
}
-(void)savetheData{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //self.rollView.frame = CGRectMake(scrollView.contentOffset.x / 2 + 1, 100, 160, 4);
}

#pragma mark - InfoViewControllerDelegate
- (void)infoPushWithViewController:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - event response
/**
 *  基本资料
 *
 *  @param sender @author 侯建鹏
 */
- (IBAction)basicInfoBtn:(id)sender
{
    NSLog(@"基本资料");
    [UIView animateWithDuration:0.5 animations:^{
       // self.rollView.frame = CGRectMake(1, 100, 160, 4);
    } completion:^(BOOL finished) {
        
    }];
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    
}
/**
 *  相关证件
 *
 *  @param sender @author 侯建鹏
 */
- (IBAction)certificateBtn:(id)sender
{
    NSLog(@"相关证件");
    [UIView animateWithDuration:0.5 animations:^{
        //self.rollView.frame = CGRectMake(161, 100, 160, 4);
    } completion:^(BOOL finished) {
        
    }];
    self.contentScrollView.contentOffset = CGPointMake(kScreenBoundWidth, 0);

    
}


- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
