//
//  SuggestionViewController.m
//  GreenTeaUserPad
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 BeiJingYunTai. All rights reserved.
//

#import "SuggestionViewController.h"
#import "SuggestionTableViewCell.h"

@interface SuggestionViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *theSuggestTableView;
@property (weak, nonatomic) IBOutlet UITextView *theSuggustTextView;
@property (weak, nonatomic) IBOutlet UIButton *theSubmmitButton;
@property(nonatomic,assign) NSInteger suggestNumber;
@end
@implementation SuggestionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"意见反馈";
    self.theSuggustTextView.text =@"请详细描述您的意见...";
    self.theSuggustTextView.delegate = self;
    self.theSuggustTextView.layer.borderWidth = 1;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.theSuggestTableView.tableHeaderView.backgroundColor = [UIColor darkGrayColor];
    self.theSuggestTableView.tableFooterView.backgroundColor = [UIColor lightGrayColor];
    [self.theSubmmitButton addTarget:self action:@selector(submmitTheView) forControlEvents:(UIControlEventTouchUpInside)];
    [self loadBlackButton];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * str = @"您对我们的服务还满意吗";
    return str ;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString * str = @"告诉绿茶您的意见,我们会做的更好";
    return str;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIndentifier = @"SuggestionTableViewCell";
    SuggestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIndentifier owner:nil options:nil] firstObject];
    }
    cell.theStateImage.backgroundColor = [UIColor yellowColor];
    return cell;
}
-(void)submmitTheView{
    NSLog(@"您点击了提交%@------%ld",self.theSuggustTextView.text,self.suggestNumber);
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您点击了提交" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.theSuggustTextView.text isEqualToString:@"请详细描述您的意见..."]) {
        self.theSuggustTextView.text = @"";
    }
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.suggestNumber = indexPath.row+1;
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
