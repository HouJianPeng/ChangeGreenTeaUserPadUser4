//
//  SearchTableViewCell.h
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *theTitleName;
@property (weak, nonatomic) IBOutlet UILabel *theDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *theMoreButton;

@end
