//
//  BasicInfoViewController.h
//  greenTea
//
//  Created by 侯建鹏 on 15/6/16.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "InfoViewControllerDelegate.h"

@interface BasicInfoViewController : BaseViewController

@property (nonatomic, assign) id<InfoViewControllerDelegate> basicDelegate;
@end
