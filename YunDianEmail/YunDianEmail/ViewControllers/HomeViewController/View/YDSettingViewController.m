//
//  YDSettingViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDSettingViewController.h"
#import "YDNotificationTableViewCell.h"
#import "YDChangePasswordViewController.h"
#import "YDFeedbackViewController.h"
#define  titleArray @[@"密码修改",@"新邮件通知提醒",@"通知显示邮件详情",@"清除缓存",@"字体大小",@"检测更新",@"意见反馈"]
@interface YDSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIScrollView *bgScrollView;

@property(nonatomic,strong)UITableView *settingTableView;

@end

@implementation YDSettingViewController

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
    self.title = @"设置";
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{
}

#pragma mark -创建控件
- (void)createInterface
{
    [self.view addSubview:self.settingTableView];
    
    
    
}

#pragma mark - Layz init
- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.alwaysBounceHorizontal = NO;
    }
    
    return _bgScrollView;
}

- (UITableView *)settingTableView
{
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.separatorInset = UIEdgeInsetsZero;
        _settingTableView.preservesSuperviewLayoutMargins = NO;
        _settingTableView.layoutMargins = UIEdgeInsetsZero;
        _settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _settingTableView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        YDChangePasswordViewController *changPasswordVtr = [[YDChangePasswordViewController alloc]init];
        [self.navigationController pushViewController:changPasswordVtr animated:NO];
    }else if(indexPath.row == 3){
        
    }else if (indexPath.row ==4){
        
        
    }else if (indexPath.row == 6){
  
        YDFeedbackViewController *feedbackVtr = [[YDFeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedbackVtr animated:NO];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ideitifier = @"SettingCell";
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideitifier];
            cell.textLabel.text = @"密码修改";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return  cell;
        
    }else if (indexPath.row == 1 || indexPath.row ==2 ){
        YDNotificationTableViewCell *cell = [YDNotificationTableViewCell cellWithTableView:tableView];
        cell.titleName.text = titleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.row == 3){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideitifier];
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text =@"123KB";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return  cell;
        
    }else if (indexPath.row == 4)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideitifier];
            cell.textLabel.text = @"字体大小";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text =@"123KB";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return  cell;
        
    }else if (indexPath.row == 5){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideitifier];
            cell.textLabel.text = @"检测更新";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text =@"当前版本";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return  cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideitifier];
            cell.textLabel.text = @"意见反馈";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return  cell;
    }
    

}



@end
