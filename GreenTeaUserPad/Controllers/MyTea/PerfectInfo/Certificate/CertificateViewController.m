//
//  CertificateViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/16.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "CertificateViewController.h"
#import "CameraTakeMamanger.h"
#import "UploadManager.h"
#import "CertTableViewCell.h"

@interface CertificateViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *theCertTableView;
@property(nonatomic,retain)NSArray*array;
@end
@implementation CertificateViewController
- (void)viewDidLoad {
    [self loadTheArray];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"相关证件";
    self.theCertTableView.delegate = self;
    self.theCertTableView.dataSource = self;
}
-(void)loadTheArray{
    self.array =@[@"身份证正面",@"身份证反面",@"企业执照"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellindetifier =@"CertTableViewCell";
    CertTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellindetifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellindetifier owner:nil options:nil] firstObject];
    }
    cell.theNameLabel.text = self.array[indexPath.row];
    NSLog(@"%@",self.array[indexPath.row]);
    NSString*str = [NSString stringWithFormat:@"idcard%ld",indexPath.row+1];
    cell.theCertImage.image = [UIImage imageNamed:str];
  
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)theSecond {
    NSLog(@"上传身份证正面");
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
                        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
                            
                            // 更新本地图片
//                            [AccountManager sharedInstance].account.headImage = fileUrl;
//                            [[AccountManager sharedInstance] saveAccountInfoToDisk];
//                            [self.theCertTableView reloadData];
        
                            // 调用图片更新
//                            [APIClient execute:self.apiRequestAlterUserImage];
                            
                            
                            
                            
        
                        } failure:^(NSString *message) {
                            DDLogInfo(@"message:%@",message);
                        }];
    }];
}

- (void)netWork{
    
//    NetWork POST:<#(NSString *)#> parmater:<#(NSDictionary *)#> Block:<#^(NSData *data)block#>
}



- (void)thefirst{
     NSLog(@"上传身份证反面");
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        //                [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
        //                    // 更新本地图片
        //                    [AccountManager sharedInstance].account.headImage = fileUrl;
        //                    [[AccountManager sharedInstance] saveAccountInfoToDisk];
        //                    [self.tableView reloadData];
        //
        //                    // 调用图片更新
        //                    [APIClient execute:self.apiRequestAlterUserImage];
        //
        //                } failure:^(NSString *message) {
        //                    DDLogInfo(@"message:%@",message);
        //                }];
    }];

    
}

- (void)theThird{
    NSLog(@"上传执业照");
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        //                [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *fileUrl, NSString *serverUrl, NSString *message) {
        //                    // 更新本地图片
        //                    [AccountManager sharedInstance].account.headImage = fileUrl;
        //                    [[AccountManager sharedInstance] saveAccountInfoToDisk];
        //                    [self.tableView reloadData];
        //
        //                    // 调用图片更新
        //                    [APIClient execute:self.apiRequestAlterUserImage];
        //
        //                } failure:^(NSString *message) {
        //                    DDLogInfo(@"message:%@",message);
        //                }];
    }];
    

}


#pragma mark - event response
- (void)submitClick:(UIButton *)sender {
    [[CameraTakeMamanger sharedInstance] cameraSheetInController:self handler:^(UIImage *image, NSString *imagePath) {
        
        [[UploadManager sharedInstance] uploadFileWithFilePath:imagePath success:^(NSString *assetId, NSString *fileName, NSString *fileUrl) {
            // 上传成功逻辑
            
        } failure:^(NSString *message) {
            // 上传失败逻辑
        }];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
