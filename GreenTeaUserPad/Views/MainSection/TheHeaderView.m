//
//  TheHeaderView.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "TheHeaderView.h"
#import "ViewHeadCollectionViewCell.h"
static NSString * celllIndentifier = @"ViewHeadCollectionViewCell";
@interface TheHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;

@end

@implementation TheHeaderView


- (void)awakeFromNib {
    // Initialization code
    [self loadTheCollectionView];
    
}
-(void)loadTheCollectionView{
    self.theCollectionView.delegate = self;
    self.theCollectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:celllIndentifier bundle:[NSBundle mainBundle]];
    [self.theCollectionView registerNib:nib forCellWithReuseIdentifier:celllIndentifier];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewHeadCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:celllIndentifier forIndexPath:indexPath];
    NSLog(@"%@",self.array[indexPath.row]);
    cell.theImageView.image = [UIImage imageNamed:self.array[indexPath.row]];
//    cell.theImageView.image = [UIImage imageNamed:@"Home_business0"];
    return cell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/7, 120);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate selectBusinessAreaTheIndex:indexPath];
}
@end
