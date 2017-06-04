//
//  YDSearchViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDSearchViewController.h"

@interface YDSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UISearchBar *searchEmail;

@property (nonatomic,strong)UITableView *searchEmailTabelView;

@end

@implementation YDSearchViewController

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
    [self.view addSubview:self.searchEmail];
    [self.searchEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.view.mas_top).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@80);
    }];
    
    [self.view addSubview:self.searchEmailTabelView];
    [self.searchEmailTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.searchEmail.mas_bottom).with.offset(5);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - Layz init
- (UISearchBar *)searchEmail
{
    if (!_searchEmail) {
        _searchEmail = [[UISearchBar alloc]init];
        _searchEmail.placeholder = @"搜索所有邮件";
        _searchEmail.showsScopeBar=YES;
        _searchEmail.tintColor = YDRGB(0, 0, 0);
     
        _searchEmail.backgroundColor = [UIColor whiteColor];
        
        _searchEmail.autocorrectionType = UITextAutocorrectionTypeYes;
        _searchEmail.scopeButtonTitles = @[@"12",@"2",@"3",@"4"];
    }
    return _searchEmail;
}

- (UITableView *)searchEmailTabelView
{
    if (_searchEmailTabelView) {
       
        _searchEmailTabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _searchEmailTabelView.delegate = self;
        _searchEmailTabelView.dataSource = self;
        _searchEmailTabelView.separatorInset = UIEdgeInsetsZero;
        _searchEmailTabelView.preservesSuperviewLayoutMargins = NO;
        _searchEmailTabelView.layoutMargins = UIEdgeInsetsZero;
        _searchEmailTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    }
    return _searchEmailTabelView;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *ideitifier = @"SearchEmailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideitifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  cell;

}

@end
