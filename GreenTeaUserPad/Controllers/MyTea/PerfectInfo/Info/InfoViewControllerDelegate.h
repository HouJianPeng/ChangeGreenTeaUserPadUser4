//
//  InfoViewControllerDelegate.h
//  greenTeaUser
//
//  Created by 陈腾飞 on 15/7/20.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InfoViewControllerDelegate <NSObject>

@required
- (void)infoPushWithViewController:(UIViewController *)vc;

@end

