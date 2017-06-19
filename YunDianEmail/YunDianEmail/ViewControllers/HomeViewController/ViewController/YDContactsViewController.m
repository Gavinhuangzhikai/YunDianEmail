//
//  YDContactsViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/15.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDContactsViewController.h"
#import "FMDB.h"
#import "YDContactsModel.h"

@interface YDContactsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *contactsTabelView;

@property (nonatomic,strong)NSMutableArray *contactsArray;
@end

@implementation YDContactsViewController

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
      self.contactsArray = [NSMutableArray array];
}

#pragma mark - 界面初始化
- (void)initUIView
{
    [super initUIView];
    
    self.title = @"通讯录";
    
    
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{
      if (_contactsType == YUDIANContactsFromTYPEIsHome) {
    [self getContactsInfo];
      }else{
             [self getContactsInfo];
          //1.获得数据库文件的路径
          NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
          NSString *fileName=[doc stringByAppendingPathComponent:@"contacts.sqlite"];
          
          //2.获得数据库
          FMDatabase *db=[FMDatabase databaseWithPath:fileName];
          
          if(![db open])
              
          {
              
              return;
              
          }
          
 
          
      }
}

#pragma mark -创建控件
- (void)createInterface
{
    if (_contactsType == YUDIANContactsFromTYPEIsWritter) {
        UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 40, 30);
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(canncleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
    }
    
    [self.view addSubview:self.contactsTabelView];
    
}

#pragma mark - Layz init
- (UITableView *)contactsTabelView
{
    if (!_contactsTabelView) {
        _contactsTabelView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        _contactsTabelView.delegate = self;
        _contactsTabelView.dataSource = self;
        _contactsTabelView.separatorInset = UIEdgeInsetsZero;
        _contactsTabelView.preservesSuperviewLayoutMargins = NO;
        _contactsTabelView.layoutMargins = UIEdgeInsetsZero;
        _contactsTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _contactsTabelView;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_contactsType == YUDIANContactsFromTYPEIsWritter) {
        if(self.addContacts) {
            YDContactsInfoModel *nameModel  = self.contactsArray[indexPath.row];
            self.addContacts(nameModel.val);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellideitifier = @"WriteLetterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellideitifier ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellideitifier];
    }
    YDContactsInfoModel *contactsModel = self.contactsArray[indexPath.row];
    
    cell.textLabel.text = contactsModel.val;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return  cell;
    
}





- (void)getContactsInfo
{
    self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];    
    [self contactsInfoRequestWithDictionary];
}

- (void)contactsInfoRequestWithDictionary
{
    
    [YDHttpRequest currentRequestType:@"GET" requestURL:YDEmailContactstUrl parameters:nil success:^(id responseObj) {
        
        [self.hud hideAnimated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self analyseData:responseObj];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.contactsTabelView reloadData];
                ;
            });
        });
        
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
    

    
}

- (void)analyseData:(id)responseObj
{
    
    YDContactsModel *contactsModel = [[YDContactsModel alloc] initWithDictionary:responseObj] ;
    
    [self.contactsArray removeAllObjects];
    
    self.contactsArray=  [contactsModel.rows  mutableCopy];
    
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"contacts.sqlite"];
    
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    
    if(![db open])
        
    {
        
        return;
        
    }
    
    
//    NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
//    [db executeUpdate:@"INSERT INTO user (name, age) VALUES (?, ?);", name,@(arc4random_uniform(40))];
   
}

- (void)canncleBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
