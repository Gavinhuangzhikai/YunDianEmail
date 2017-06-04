//
//  YDInboxViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDInboxViewController.h"
#import "YDInboxTableViewCell.h"
#import "YDCheckMailViewController.h"
@interface YDInboxViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *inboxTableView;

@property(nonatomic ,strong) NSMutableArray *inboxArray;
@end

@implementation YDInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ---------------- 初始化 -----------------
#pragma mark - 参数初始化
- (void)initParameters
{
    [super initParameters];
}

#pragma mark - 界面初始化
- (void)initUIView
{
    [super initUIView];
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{
}

#pragma mark -创建控件
- (void)createInterface
{
    [self.view addSubview:self.inboxTableView];
    
    
    
}

#pragma mark - Layz init
- (UITableView *)inboxTableView
{
    if (!_inboxTableView) {
        _inboxTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _inboxTableView.delegate = self;
        _inboxTableView.dataSource = self;
        _inboxTableView.separatorInset = UIEdgeInsetsZero;
        _inboxTableView.preservesSuperviewLayoutMargins = NO;
        _inboxTableView.layoutMargins = UIEdgeInsetsZero;
        _inboxTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _inboxTableView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YDCheckMailViewController *checkMail = [[YDCheckMailViewController alloc] init];
    [self.navigationController pushViewController:checkMail animated:NO];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inboxArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    YDInboxTableViewCell *cell = [YDInboxTableViewCell cellWithTableView:tableView];
    return cell;
}


- (void)rightBtnAction
{
      
    
}




@end
