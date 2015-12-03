//
//  ViewHeadCollectionViewCell.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "ViewHeadCollectionViewCell.h"

@implementation ViewHeadCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGRect cellFrame = self.contentView.superview.bounds;
    [self.imageView setFrame:cellFrame];
    [self.contentView addSubview:self.imageView];
}


#pragma mark - getter &setter
- (UIImageView *)imageView{
    if (_theImageView == nil) {
        //_theImageView = [[UIImageView alloc]init];
    }
    return _theImageView;
}
@end
