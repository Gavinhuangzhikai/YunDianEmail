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
#import "YDLoginViewController.h"
#import "YDContactsViewController.h"
#import "YDUserDataManager.h"
#import "YDUserDataModel.h"

#define  titleNameArray @[@"写信",@"收件箱",@"通讯录",@"草稿箱",@"已发送",@"已删除",@"垃圾箱"]
#define  titleNameImageArray @[@"write_letter.png",@"inbox.png",@"contacts.png",@"draft_box.png",@"been_sent.png",@"deleted.png",@"trash_cans.png"]
@interface YDHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *homeEmailTableView;


@property(nonatomic,strong)NSMutableArray *isNewsArray;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    YDLoginViewController *loginVtr = [[YDLoginViewController alloc] init];
//    [self.navigationController presentViewController:loginVtr animated:NO completion:^{
//        
//    }];
    
    
    
}

#pragma mark - ---------------- 初始化 -----------------
#pragma mark - 参数初始化
- (void)initParameters
{
    [super initParameters];
    self.isNewsArray = [NSMutableArray array];
}

#pragma mark - 界面初始化
- (void)initUIView
{
    [super initUIView];
 
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    UIButton *rightSearchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightSearchBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightSearchBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
  
    [rightSearchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightSettingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightSettingBtn.frame = CGRectMake(40, 0, 30, 30);
    [rightSettingBtn setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];

    [rightSettingBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightSearchBtn];
    [rightView addSubview:rightSettingBtn];
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
//    YDUserDataModel *userModel = [YDUserDataModel mj_objectWithKeyValues:[YDUserDataManager readUserData]];
//    if (userModel != nil && userModel.userName != nil) {
//        self.title = userModel.userName;
//    }
    self.title = @"云电邮箱";
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
        inboxVtr.mailType = YUDIANINBOXTYPE;
        [self.navigationController pushViewController:inboxVtr animated:NO];
        
    }else if (indexPath.row == 2)
    {
        YDContactsViewController *contactsVtr = [[YDContactsViewController alloc]init];
         contactsVtr.contactsType =  YUDIANContactsFromTYPEIsHome;
        [self.navigationController pushViewController:contactsVtr animated:NO];
        
    }else if (indexPath.row == 3)
    { 
        YDInboxViewController *inboxVtr = [[YDInboxViewController alloc] init];
        inboxVtr.mailType = YUDIANDraftBoxTYPE;
        [self.navigationController pushViewController:inboxVtr animated:NO];
        
    }else if (indexPath.row == 4)
    {
        YDInboxViewController *inboxVtr = [[YDInboxViewController alloc] init];
        inboxVtr.mailType = YUDIANBeenSentTYPE;
        [self.navigationController pushViewController:inboxVtr animated:NO];
        
    }else if (indexPath.row == 5)
    {
        YDInboxViewController *inboxVtr = [[YDInboxViewController alloc] init];
        inboxVtr.mailType = YUDIANBeenDeletedtTYPE;
        [self.navigationController pushViewController:inboxVtr animated:NO];
        
    }else if (indexPath.row == 6)
    {
        YDInboxViewController *inboxVtr = [[YDInboxViewController alloc] init];
        inboxVtr.mailType = YUDIANBeenTrashCansTYPE;
        [self.navigationController pushViewController:inboxVtr animated:NO];
        
    }else if (indexPath.row == 7)
    {
        
    }
}

- ( NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
     __weak typeof(self) weakself = self;
    UITableViewRowAction *readAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"标为已读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [weakself.homeEmailTableView  reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil]  withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    
    
    UITableViewRowAction *clearAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
      
        [weakself.homeEmailTableView  reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil]  withRowAnimation:UITableViewRowAnimationNone];
   
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
    cell.titleImage.image = [UIImage imageNamed:titleNameImageArray[indexPath.row]];
     cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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


- (void)isNewsRequestWithType:(NSString *)requestType   withURL:(NSString *)urlString    withDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:requestType requestURL:urlString parameters:dictionary success:^(id responseObj) {
        
     
        if ([responseObj isKindOfClass:[NSDictionary class]]){
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            dispatch_async(dispatch_get_main_queue(), ^{
            
                    
                    
                });
            });
        }else {
            [YDTools loadFailedHUD:self.hud text:@"请求失败" ];
            
        }
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
}


@end
