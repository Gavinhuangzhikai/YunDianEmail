//
//  YDHomeViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDHomeViewController.h"
#import "YDHomeEmailTableViewCell.h"
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








@end
