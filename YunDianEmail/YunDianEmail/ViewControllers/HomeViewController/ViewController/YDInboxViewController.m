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
   
    switch (self.mailType) {
        case YUDIANINBOXTYPE:
        {
             [self readRequestWithType:@"POST" withURL:YDReadEmailUrl withDictionary:nil];
        }
            break;
        case YUDIANDraftBoxTYPE:
        {
              [self readRequestWithType:@"GET" withURL:YDGetdelnumEmailUrl withDictionary:nil];
        }
            break;
        case YUDIANBeenSentTYPE:
        {
           

        }
            break;
        case YUDIANBeenDeletedtTYPE:
        {
            
        }
            break;
        case YUDIANBeenTrashCansTYPE:
        {
            
        }
           
            
        default:
            break;
    }
    
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
    
    YDInboxTableViewCell *cell = [YDInboxTableViewCell cellWithTableView:tableView];
    return cell;
}


- (void)rightBtnAction
{
      
    
}

- (void)readRequestWithType:(NSString *)requestType   withURL:(NSString *)urlString    withDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:requestType requestURL:urlString parameters:dictionary success:^(id responseObj) {
        NSString * status = responseObj[@"result"];
        
        if ([status isEqualToString:@"success"]) {
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                    [self analyseData:responseObj];
                dispatch_async(dispatch_get_main_queue(), ^{
             ;
                    
                });
            });
            
        }else {
            [YDTools loadFailedHUD:self.hud text:status ];
            
        }

        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
 

    
    
}


@end
