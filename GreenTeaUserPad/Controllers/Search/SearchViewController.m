//
//  SearchViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
static NSString * cellIndentifier = @"SearchTableViewCell";
@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property(nonatomic,strong)NSMutableArray * resultArray;
@property (weak, nonatomic) IBOutlet UITextField *theSearchTextField;
@property (weak, nonatomic) IBOutlet UIButton *theSearchButton;
@property(nonatomic,strong)NSString * searchString;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTheSearchView];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadTheSearchView{
    self.resultTableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor blackColor];
    self.theSearchTextField.delegate = self;
    self.theSearchTextField.backgroundColor = [UIColor lightGrayColor];
    self.theSearchTextField.textColor = [UIColor whiteColor];
    [self.theSearchButton addTarget:self action:@selector(loadTheTableView) forControlEvents:(UIControlEventTouchUpInside)];
    self.theSearchTextField.placeholder = @"请输入您所需要搜索的内容";
    self.theSearchTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}
-(void)loadTheTableView{
    self.resultTableView.tableFooterView = nil;
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
    [self.resultTableView reloadData];
//    UINib * nib = [UINib nibWithNibName:cellIndentifier bundle:[NSBundle mainBundle]];
//    [self.resultTableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
//    [self searchBeginTheTextField];
}
-(void)searchBeginTheTextField{
    NSLog(@"%@",self.theSearchTextField.text);
}
#pragma mark textField代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIndentifier owner:nil options:nil] firstObject];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.theTitleName.text = @"搜索";
    cell.theDescriptionLabel.text= @"搜索的啥玩意嘛";\
    cell.theMoreButton.backgroundColor = [UIColor whiteColor];
    cell.theMoreButton.imageView.image = [UIImage imageNamed:@"ser_02"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
