//
//  InfoViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/12.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "BaseViewController.h"
#import "BasicInfoViewController.h"
#import "CertificateViewController.h"
#import "InfoViewControllerDelegate.h"

@interface InfoViewController : BaseViewController

//@property (weak, nonatomic) IBOutlet UILabel *info;//完善资料
//@property (weak, nonatomic) IBOutlet UIView *line;//横线
@property (weak, nonatomic) IBOutlet UIButton *basicInfo;//基本资料
@property (weak, nonatomic) IBOutlet UIButton *certificate;//相关证件

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) BasicInfoViewController *infoVC;//基本资料
@property (nonatomic, strong) CertificateViewController *certicateVC;//相关证件



/**
 *  基本资料
 *
 *  @param sender @author 侯建鹏
 */
- (IBAction)basicInfoBtn:(id)sender;
/**
 *  相关证件
 *
 *  @param sender @author 侯建鹏
 */
- (IBAction)certificateBtn:(id)sender;

@end
