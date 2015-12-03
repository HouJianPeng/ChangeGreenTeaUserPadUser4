//
//  GuidanceViewController.m
//  greenTeaUser
//
//  Created by 侯建鹏 on 15/7/16.
//  Copyright (c) 2015年 com.cn.lawcheck. All rights reserved.
//

#import "GuidanceViewController.h"
#import "GuidanceCollectionViewCell.h"
#import "MainViewController.h"

@interface GuidanceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@end

@implementation GuidanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutPageSubviews];
    
    [self.collectionView registerNib:[GuidanceCollectionViewCell nibWithGuidanceCell] forCellWithReuseIdentifier:kGuidanceCollectionViewCell];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)layoutPageSubviews {
    self.flowLayout.itemSize = CGSizeMake(kScreenBoundWidth, kScreenBoundHeight);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    
//    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = YES;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuidanceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGuidanceCollectionViewCell forIndexPath:indexPath];
    NSString *imgStr = [NSString stringWithFormat:@"Guidance%@.jpg", @(indexPath.row)];
    cell.tf_backGroundView.backgroundColor = [UIColor redColor];
    cell.tf_backGroundView.image = [UIImage imageNamed:imgStr];
    
    if (indexPath.row == 4) {
        cell.tf_enterButton.hidden = NO;
        [cell.tf_enterButton addTarget:self action:@selector(enterClick:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        cell.tf_enterButton.hidden = YES;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==4) {
        [AccountManager changeRootVCWithMMDrawer];
    }
    
}
#pragma mark - event response
- (void)enterClick:(UIButton *)button {
    [AccountManager changeRootVCWithMMDrawer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
