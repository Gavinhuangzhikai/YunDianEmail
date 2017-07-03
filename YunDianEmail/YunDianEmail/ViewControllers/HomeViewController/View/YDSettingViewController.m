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
#import "YDLoginViewController.h"
#import "YDUserDataModel.h"
#import "YDUserDataManager.h"
#define  titleArray @[@"密码修改",@"新消息通知提醒",@"清除缓存",@"字体大小",@"检测更新",@"意见反馈"]
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
    
        
        UIView *logoutView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 55)];
        UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn setTitleColor:YDRGB(0, 86, 201) forState:UIControlStateNormal];
        logoutBtn.titleLabel.font = YDFont(13);
        logoutBtn.backgroundColor = YDRGB(229, 229, 229);
        [logoutBtn addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
        [logoutView addSubview:logoutBtn];
        [logoutBtn.layer setCornerRadius:5.0];
        [logoutBtn.layer setMasksToBounds:YES];
        
        
        
        [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(logoutView.mas_centerX);
            make.top.equalTo(logoutView.mas_top).with.offset(15);
            make.width.equalTo(@250);
            make.height.equalTo(@40);
        }];
        
        _settingTableView.tableFooterView =logoutView;
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
    }else if(indexPath.row == 2){
        NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
        NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
        //NSLog ( @"cachpath = %@" , cachePath);
        for ( NSString * p in files) {
            
            NSError * error = nil ;
            //获取文件全路径
            NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
            
            if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
                [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
            }
        }
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (indexPath.row ==3){
        UIAlertController *settingFontAlterView = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *smallAction = [UIAlertAction actionWithTitle:@"小号" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            SetTEXTFONT(@12);
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"默认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            SetTEXTFONT(@15);
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
              [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        UIAlertAction *middleAction = [UIAlertAction actionWithTitle:@"中号" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            SetTEXTFONT(@18);
               [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        UIAlertAction *bigAction = [UIAlertAction actionWithTitle:@"大号" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            SetTEXTFONT(@21);
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
      
        UIAlertAction *biggerAction = [UIAlertAction actionWithTitle:@"超大" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            SetTEXTFONT(@25);
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];

        [settingFontAlterView addAction:smallAction];
        [settingFontAlterView addAction:defaultAction];
        [settingFontAlterView addAction:middleAction];
        [settingFontAlterView addAction:bigAction];
        [settingFontAlterView addAction:biggerAction];
        [self presentViewController:settingFontAlterView animated:YES completion:nil];
        

        
    }else if (indexPath.row == 5){
  
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
        }
            cell.textLabel.text = @"密码修改";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = YDFont(15);
        
        return  cell;
        
    }else if (indexPath.row == 1){
        __weak __typeof__(self) weakSelf = self;
        YDNotificationTableViewCell *cell = [YDNotificationTableViewCell cellWithTableView:tableView];
        cell.titleName.text = titleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.switchbutton = ^(UISwitch *switc) {
            
        };
        
        return cell;
    }else if(indexPath.row == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideitifier];
        }
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%.2fMB",([self readCacheSize])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = YDFont(15);
        
        return  cell;
        
    }else if (indexPath.row == 3)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideitifier];
        }
            cell.textLabel.text = @"字体大小";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            NSNumber *textfont = TEXTFONT;
            if( [textfont   isEqual: @18])
            {
                cell.detailTextLabel.text =@"中号";
            }else if ([textfont   isEqual: @21]){
                
                cell.detailTextLabel.text =@"大号";
            }else if ([textfont   isEqual: @15]){
                
                cell.detailTextLabel.text =@"默认";
            }else if ([textfont   isEqual: @12]){
                
                cell.detailTextLabel.text =@"小号";
            }else if ([textfont   isEqual: @25]){
                
                cell.detailTextLabel.text =@"超大";
            }
        
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = YDFont(15);
        
        return  cell;
        
    }else if (indexPath.row == 4){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ideitifier];
        }
            cell.textLabel.text = @"检测更新";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text =@"当前版本";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = YDFont(15);
        
        return  cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideitifier];
        }
            cell.textLabel.text = @"意见反馈";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = YDFont(15);
        
        return  cell;
    }
    

}

- (void)logOut:(id)sender
{
     __weak __typeof__(self) weakSelf = self;
    UIAlertController *logoutAlterView = [UIAlertController alertControllerWithTitle:nil message:@"是否退出当前登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"退出登录" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
      
        weakSelf.hud = [YDTools HUDLoadingOnView:self.navigationController.view delegate:self];
        
        [weakSelf logoutRequestWithDictionary];
//        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    // 取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
      
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    }];
     [logoutAlterView addAction:cancelAction];
    [logoutAlterView addAction:logoutAction];
   
   
    [self presentViewController:logoutAlterView animated:YES completion:nil];

}

- (void)logoutRequestWithDictionary
{
    [YDHttpRequest currentRequestType:@"GET" requestURL:YDCheckLoginOutUrl parameters:nil success:^(id responseObj) {
        NSString * status = responseObj[@"result"];
        
        
        
        if ([YDValidate isEmpty:status]) {
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               [self analyseData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIWindow  *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
                    YDLoginViewController *controller = [[YDLoginViewController alloc] init];
                    window.rootViewController = controller;
                    [window makeKeyAndVisible];

                    
                    
                });
            });
            
        }else {
            [YDTools loadFailedHUD:self.hud text:status ];
            
        }
        
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
    
}

- (void)analyseData
{
    
    YDUserDataModel *userModel = [YDUserDataModel mj_objectWithKeyValues:[YDUserDataManager readUserData]];
    userModel.loginStatus = NO;
    userModel.session = nil;
    [YDUserDataManager saveUserData:userModel.mj_keyValues];
    
}

-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}




@end
