//
//  BasicInfoViewController.m
//  greenTea
//
//  Created by 侯建鹏 on 15/6/16.
//  Copyright (c) 2015年 lawcheck. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "PersonTableViewCell.h"
#import "AdressTableViewCell.h"
@class InfoViewController;


@interface BasicInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *theDetialTableView;
@property(nonatomic,retain)NSArray*array;
@property(nonatomic,retain)NSArray*infoArray;
@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [self loadTheArray];
    [super viewDidLoad];
    self.theDetialTableView.delegate = self;
    self.theDetialTableView.dataSource = self;
    self.navigationController.navigationBar.hidden= YES;
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)loadTheArray{
    self.array = @[@"用户名",@"姓名",@"性别",@"身份证号",@"签发机关",@"职业证号",@"职业机构",@"职业证类型",@"发证机关",@"发证日期",@"邮箱地址"];
    self.infoArray = @[[AccountManager sharedInstance].account.displayName,@"王建",@"男",@"142429199011064439",@"北京",@"5345346346",@"34523435",@"律师",@"北京市",@"2015-06-09",@"234423@qq.com"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==self.array.count-1) {
        static NSString*cellidentifer = @"AdressTableViewCell";
        AdressTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellidentifer owner:nil options:nil ] firstObject];
        }
        cell.theAdressLabel.text = self.array[indexPath.row];
        cell.theAdresstextField.text = self.infoArray[indexPath.row] ;
        return  cell;
    }
    else{
        static NSString*cellidentifer = @"PersonTableViewCell";
        PersonTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellidentifer owner:nil options:nil ] firstObject];
        }
        cell.theDescriptionLabel.text = self.array[indexPath.row];
        cell.theDetialLabel.text = self.infoArray[indexPath.row] ;
        return  cell;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //
//    self.basicDelegate infoPushWithViewController:<#(UIViewController *)#>
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.theDetialTableView endEditing:YES];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
