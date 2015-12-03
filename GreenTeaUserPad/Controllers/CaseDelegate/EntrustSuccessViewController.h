//
//  EntrustSuccessViewController.h
//  greenTeaUser
//
//  Created by Herron on 15/7/9.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface EntrustSuccessViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *theLawcaseNoLabel;
@property(nonatomic,retain)NSString*lawcaseNo;
@end
