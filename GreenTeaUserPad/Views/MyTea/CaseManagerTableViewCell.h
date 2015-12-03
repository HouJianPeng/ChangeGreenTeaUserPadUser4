//
//  CaseManagerTableViewCell.h
//  GreenTeaUserPad
//
//  Created by mac on 15/7/23.
//  Copyright (c) 2015年 BeiJingYuntai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseManagerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *thaCaseNumber;
@property (weak, nonatomic) IBOutlet UILabel *theCaseType;
@property (weak, nonatomic) IBOutlet UILabel *theTypeCase;
@property (weak, nonatomic) IBOutlet UIButton *theDetialButton;
@property (weak ,nonatomic) IBOutlet UILabel *theCaseTitle;
@end
