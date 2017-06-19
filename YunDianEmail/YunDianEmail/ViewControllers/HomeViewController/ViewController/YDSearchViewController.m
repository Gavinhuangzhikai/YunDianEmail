//
//  YDSearchViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDSearchViewController.h"
#import <CoreGraphics/CoreGraphics.h>

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
//    [self.searchEmail mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(15);
//        make.top.equalTo(self.view.mas_top).with.offset(5);
//        make.right.equalTo(self.view.mas_right).with.offset(-15);
//        make.height.equalTo(@30);
//    }];
//    
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
        _searchEmail = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 10, self.view.width -80, 30)];
        _searchEmail.placeholder = @"搜索所有邮件";
        _searchEmail.backgroundColor =[UIColor whiteColor];
        UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
        //设置背景图片
        [_searchEmail setBackgroundImage:searchBarBg];
        //设置背景色
        [_searchEmail setBackgroundColor:YDRGB(230, 230, 230)];
        //设置文本框背景
        [_searchEmail setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
       

    }
    return _searchEmail;
}

- (UITableView *)searchEmailTabelView
{
    if (!_searchEmailTabelView) {
       
        _searchEmailTabelView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _searchEmailTabelView.delegate = self;
        _searchEmailTabelView.dataSource = self;
        _searchEmailTabelView.backgroundColor = [UIColor whiteColor];
        _searchEmailTabelView.separatorInset = UIEdgeInsetsZero;
        _searchEmailTabelView.preservesSuperviewLayoutMargins = NO;
        _searchEmailTabelView.layoutMargins = UIEdgeInsetsZero;
        _searchEmailTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
        
        // 修改标题文字
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"souSuo"];

    }
    return _searchEmailTabelView;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return  40;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
        backView.backgroundColor = YDRGB(245, 245, 245);
        NSArray *textArray = @[@"发件人",@"收件人",@"主题",@"全部"];
        
        for (int i = 0; i < 4; i++) {
            UIButton * textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [textBtn setTitle:textArray[i] forState:UIControlStateNormal];
            textBtn.frame =CGRectMake(i * tableView.width/4, 0,  tableView.width/4, 40);
            [textBtn setTitleColor:YDRGB(111, 111, 111) forState:UIControlStateNormal];
            textBtn.titleLabel.font =YDFont(15);
            textBtn.tag = 1000 + i;
            [textBtn addTarget:self action:@selector(searchClassification:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:textBtn];
        }
        
        for (int i = 1; i < 4; i++) {
            UIImageView * line = [[UIImageView alloc] init];
            line.backgroundColor = YDRGB(230, 230, 230);
            line.frame = CGRectMake(i * tableView.width/4, 10, 1, 20);
             [backView addSubview:line];
        }
        
        return backView;
    }
    return  nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 1 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *ideitifier = @"SearchEmailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideitifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return  cell;

}

- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    CGRect rect = (CGRect){0.f,0.f,1.0f,height};

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1.0f, height), NO, [UIScreen mainScreen].scale);
    
    //根据矩形画带圆角的曲线
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15.0f].CGPath);
    
    [img drawInRect:rect];
    
    //图片缩放，是非线程安全的
    img = UIGraphicsGetImageFromCurrentImageContext();
    

    
    UIGraphicsEndImageContext();
    
    return img;
}


- (void)searchRequestWithType:(NSString *)requestType   withURL:(NSString *)urlString    withDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:requestType requestURL:urlString parameters:dictionary success:^(id responseObj) {
        if ([responseObj isKindOfClass:[NSDictionary class]]){
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [self analyseData:responseObj];
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.inboxTableView  reloadData];
                    
                });
            });
        }else {
            [YDTools loadFailedHUD:self.hud text:@"请求失败" ];
            
        }
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
}

- (void)searchClassification:(UIButton *)button
{
    if (button.tag == 1000) {
        
    }else if (button.tag == 1001){
        
    }else if (button.tag == 1002){
        
    }else if (button.tag == 1003){
        
    }
    
}

@end
