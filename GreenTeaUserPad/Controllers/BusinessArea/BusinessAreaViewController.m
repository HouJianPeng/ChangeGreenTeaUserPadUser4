//
//  BusinessAreaViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "BusinessAreaViewController.h"
#import "BusinessAreaCollectionViewCell.h"
static NSString * cellIndentifier = @"BusinessAreaCollectionViewCell";
@interface BusinessAreaViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *areaCollectionView;
@property (nonatomic, retain) UIAlertView *businessAlert; // 业务领域提示框
@end

@implementation BusinessAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商业领域";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self loadTheAreaCollectionView];
    [self loadBlackButton];
//    self.tabBarItem.image = [UIImage imageNamed:@"iPad_icon"];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadBlackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)doBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadTheAreaCollectionView{
    UINib * nib = [UINib nibWithNibName:cellIndentifier bundle:[NSBundle mainBundle]];
    [self.areaCollectionView registerNib:nib forCellWithReuseIdentifier:cellIndentifier];
    self.areaCollectionView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BusinessAreaCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    NSString * string = [NSString stringWithFormat:@"bd_%ld",indexPath.row+21];
    cell.areaImageView.image = [UIImage imageNamed:string];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/2-40, [UIScreen mainScreen].bounds.size.height/6);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"您点击了第%ld个",indexPath.row);
    self.businessAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲！工程师正在努力更新中。。。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self.businessAlert show];
}

@end
