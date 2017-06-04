//
//  YDHomeViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDHomeViewController.h"
#import "YDHomeEmailTableViewCell.h"
#import "YDSettingViewController.h"
#import "YDWriteLetterViewController.h"
#import "YDInboxViewController.h"
#import "YDSearchViewController.h"

#define  titleNameArray @[@"写信",@"收件箱",@"通讯录",@"草稿箱",@"已发送",@"已删除",@"垃圾箱",@""]
#define  titleNameImageArray @[@"写信",@"收件箱",@"通讯录",@"草稿箱",@"已发送",@"已删除",@"垃圾箱",@""]
@interface YDHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *homeEmailTableView;

@end

@implementation YDHomeViewController

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
    self.title = @"111";
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    
    UIButton *rightSearchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightSearchBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightSearchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightSearchBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightSearchBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [rightSearchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightSettingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightSettingBtn.frame = CGRectMake(40, 0, 40, 40);
    [rightSettingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightSettingBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightSettingBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [rightSettingBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightSearchBtn];
    [rightView addSubview:rightSettingBtn];
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{
}

#pragma mark -创建控件
- (void)createInterface
{
    [self.view addSubview:self.homeEmailTableView];
    

    
}

#pragma mark - Layz init
- (UITableView *)homeEmailTableView
{
    if (!_homeEmailTableView) {
        _homeEmailTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _homeEmailTableView.delegate = self;
        _homeEmailTableView.dataSource = self;
        _homeEmailTableView.separatorInset = UIEdgeInsetsZero;
        _homeEmailTableView.preservesSuperviewLayoutMargins = NO;
        _homeEmailTableView.layoutMargins = UIEdgeInsetsZero;
        _homeEmailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _homeEmailTableView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        YDWriteLetterViewController *writeLetterVtr = [[YDWriteLetterViewController alloc] init];
        [self.navigationController pushViewController:writeLetterVtr animated:NO];
    
        
    }else if (indexPath.row == 1)
    {
        YDInboxViewController *inboxVtr = [[YDInboxViewController alloc] init];
        [self.navigationController pushViewController:inboxVtr animated:NO];
        
    }else if (indexPath.row == 2)
    {
        
    }else if (indexPath.row == 3)
    {
        
    }else if (indexPath.row == 4)
    {
        
    }else if (indexPath.row == 5)
    {
        
    }else if (indexPath.row == 6)
    {
        
    }else if (indexPath.row == 7)
    {
        
    }
}

- ( NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
     __weak typeof(self) weakself = self;
    UITableViewRowAction *readAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"全标已读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

   
    }];
    
    
    
    UITableViewRowAction *clearAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"清空" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
      
        
   
    }];
     clearAction.backgroundColor = YDRGB(255, 133, 0);
    
    return @[clearAction,readAction];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    YDHomeEmailTableViewCell *cell = [YDHomeEmailTableViewCell cellWithTableView:tableView];
    cell.titleName.text = titleNameArray[indexPath.row];
    return cell;
}

- (void)searchBtnAction
{
    YDSearchViewController *searchVtr = [[YDSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVtr animated:NO];
    
    
}

- (void)rightBtnAction
{
    YDSettingViewController *settingVtr = [[YDSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVtr animated:NO];
    
    
}





@end
