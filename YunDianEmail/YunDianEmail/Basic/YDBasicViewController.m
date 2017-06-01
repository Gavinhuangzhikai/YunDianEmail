//
//  YDBasicViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicViewController.h"

@interface YDBasicViewController ()

@end

@implementation YDBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
    }
    self.navigationController.navigationBar.translucent = NO;
    
    [self initParameters];
    [self initUIView];
    [self getDataFromNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ---------------- 初始化 -----------------
#pragma mark - 参数初始化
- (void)initParameters
{
}

#pragma mark - 界面初始化
- (void)initUIView
{
    
    UIButton *backBtn=[UIButton  buttonWithType:UIButtonTypeCustom ];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backSelect"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

#pragma mark - ---------------- 方法 ------------------
#pragma mark - 设置刷新控件
- (void)setRefreshControl:(UIScrollView *)scrollView flag:(NSString *)flag
{
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    
}

#pragma mark - 设置加载控件
- (void)setUploadControl:(UIScrollView *)scrollView
{
    scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadAction)];
}

#pragma mark -- 设置左侧按钮是否可点击
- (void)setLeftButtonEnabled:(BOOL)enabled
{
    [self.navigationItem.leftBarButtonItem setEnabled:enabled];
}

#pragma mark -- 设置右侧按钮是否可点击
- (void)setRightButtonEnabled:(BOOL)enabled
{
    [self.navigationItem.rightBarButtonItem setEnabled:enabled];
}

#pragma mark - ---------------- 事件 ------------------
#pragma mark - 返回
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES ];
}

#pragma mark - 刷新
- (void)refreshAction
{
    
}

#pragma mark - 加载
- (void)uploadAction
{
    
}


#pragma mark - ---------------- 请求 ------------------
#pragma mark - 网络请求
- (void)getDataFromNet
{
}

@end
