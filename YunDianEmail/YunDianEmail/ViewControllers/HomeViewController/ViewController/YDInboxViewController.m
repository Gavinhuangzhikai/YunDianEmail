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
#import "YDNoDataTableViewCell.h"
#import "YDInBoxModel.h"
#import "YDWriteLetterViewController.h"
#import "YDSearchViewController.h"


static NSString *const alertsNoDataCellIdentifier = @"alertsNoDataCellIdentifier";

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

    
    
    
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{
    self.hud = [YDTools HUDLoadingOnView:self.view delegate:self]; 
    switch (self.mailType) {
            
        case YUDIANINBOXTYPE:
        {
            self.title = @"收件箱";
            NSDictionary *dataDic = @{@"emailType":@"1"};
             [self readRequestWithType:@"GET" withURL:YDEmailFindoUrl withDictionary:dataDic];
        }
            break;
        case YUDIANDraftBoxTYPE:
        {
            self.title = @"草稿箱";
              [self readRequestWithType:@"GET" withURL:YDDraftFindUrl withDictionary:nil];
        }
            break;
        case YUDIANBeenSentTYPE:
        {
            self.title = @"已发送";
            NSDictionary *dataDic = @{@"emailType":@"0",@"status":@"1"};
            [self readRequestWithType:@"GET" withURL:YDEmailFindoUrl withDictionary:dataDic];


        }
            break;
        case YUDIANBeenDeletedtTYPE:
        {
            self.title = @"已删除";
            NSDictionary *dataDic = @{@"status":@"-1"};
            [self readRequestWithType:@"GET" withURL:YDEmailFindoUrl withDictionary:dataDic];

        }
            break;
        case YUDIANBeenTrashCansTYPE:
        {
            self.title = @"垃圾箱";
            [self readRequestWithType:@"GET" withURL:YDGetdelnumEmailUrl withDictionary:nil];
        }
           
            
        default:
            break;
    }
    
}

#pragma mark -创建控件
- (void)createInterface
{
    [self.view addSubview:self.inboxTableView];
     __weak __typeof__(self) weakSelf = self;
    self.inboxTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDataFromNet];
    }];

}

#pragma mark - Layz init
- (UITableView *)inboxTableView
{
    if (!_inboxTableView) {
        _inboxTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height -64) style:UITableViewStylePlain];
        _inboxTableView.delegate = self;
        _inboxTableView.dataSource = self;
        _inboxTableView.separatorInset = UIEdgeInsetsZero;
        _inboxTableView.preservesSuperviewLayoutMargins = NO;
        _inboxTableView.layoutMargins = UIEdgeInsetsZero;
        [_inboxTableView registerClass:[YDNoDataTableViewCell class] forCellReuseIdentifier:alertsNoDataCellIdentifier];
        [_inboxTableView registerClass:[YDInboxTableViewCell class] forCellReuseIdentifier:YDInboxTableViewIdentifier];
        _inboxTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _inboxTableView;
}

- (NSMutableArray *)inboxArray
{
    if (!_inboxArray) {
        _inboxArray = [NSMutableArray array];
    }
    return _inboxArray;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   if (self.inboxArray.count == 0) {
    return tableView.height;
    
}
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.inboxArray.count == 0) {
     
    }else{
    
    YDCheckMailViewController *checkMail = [[YDCheckMailViewController alloc] init];
        checkMail.inboxRows =  self.inboxArray[indexPath.row];
    [self.navigationController pushViewController:checkMail animated:NO];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.inboxArray.count == 0) {
        return 1;
    }
    return self.inboxArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.inboxArray.count == 0) {
        YDNoDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:alertsNoDataCellIdentifier];
        return cell;
    }
    
    NSLog(@"%ld",(long)indexPath.row);
    YDInboxTableViewCell *cell = [YDInboxTableViewCell cellWithTableView:tableView];
    [cell refreshDataWithCell:self.inboxArray[indexPath.row]];
    return cell;
}


- (void)rightBtnAction
{
    YDWriteLetterViewController *writeVtr = [[YDWriteLetterViewController alloc]init];
    [self.navigationController pushViewController:writeVtr animated:NO];
    
}

- (void)searchBtnAction
{
    
    YDSearchViewController *searchVtr = [[YDSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVtr animated:NO];
}

- (void)readRequestWithType:(NSString *)requestType   withURL:(NSString *)urlString    withDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:requestType requestURL:urlString parameters:dictionary success:^(id responseObj) {
        if ([responseObj isKindOfClass:[NSDictionary class]]){

            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self analyseData:responseObj];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.inboxTableView  reloadData];
                    
                });
            });
        }else {
            [YDTools loadFailedHUD:self.hud text:@"请求失败" ];
            
        }

        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
}

- (void)analyseData:(id)responseObj
{
      YDInBoxModel *inBoxModel = [[YDInBoxModel alloc] initWithDictionary:responseObj] ;
    
      [self.inboxArray removeAllObjects];
    
       self.inboxArray=  [inBoxModel.rows  copy];
    
    
}




@end
