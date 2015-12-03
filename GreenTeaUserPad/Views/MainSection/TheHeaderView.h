//
//  TheHeaderView.h
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imagePlayerView.h"

@protocol TheHeaderViewDelegate <NSObject>

-(void)selectBusinessAreaTheIndex:(NSIndexPath*)index;

@end

@interface TheHeaderView : UICollectionReusableView


@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;


@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,assign)id<TheHeaderViewDelegate>delegate;
@end
