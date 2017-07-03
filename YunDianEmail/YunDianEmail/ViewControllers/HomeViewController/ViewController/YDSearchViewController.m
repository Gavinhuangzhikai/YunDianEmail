//
//  YDSearchViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDSearchViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "EmailDataBase.h"
#import "YDInBoxModel.h"

@interface YDSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITextField *searchEmail;

@property (nonatomic,strong)UITableView *searchEmailTabelView;

@property (nonatomic,strong)UIButton *searchBtn;

@property(nonatomic ,strong) YDInBoxModel *searchModel;

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
    self.searchType = YUDIANMailSearchTYPESender;
}

#pragma mark - 界面初始化
- (void)initUIView
{
    [super initUIView];
    self.title = @"邮件搜索";
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
    [self.view addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchEmail.mas_centerY);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
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
- (UITextField *)searchEmail
{
    if (!_searchEmail) {
        _searchEmail = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, self.view.width -80, 30)];
        _searchEmail.placeholder = @"搜索所有邮件";
        _searchEmail.backgroundColor = YDRGB(230, 230, 230);
  
        UIImageView *searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 25, 25)];
        searchImage.contentMode = UIViewContentModeScaleAspectFit;
        searchImage.image = [UIImage imageNamed:@"tool_search.png"];
  
        
        _searchEmail.leftView = searchImage;
        _searchEmail.leftViewMode = UITextFieldViewModeAlways;
        [_searchEmail setBorderStyle:UITextBorderStyleRoundedRect];
        _searchEmail.autocorrectionType = UITextAutocorrectionTypeDefault;
        _searchEmail.delegate =self;
        _searchEmail.font = YDFont(15);
        _searchEmail.textColor = YDRGB(0, 0, 0);
        _searchEmail.keyboardType =UIKeyboardTypeDefault;
        _searchEmail.layer.cornerRadius = 6;
        _searchEmail.layer.masksToBounds = YES;

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

- (UIButton *)searchBtn
{
    if(!_searchBtn){
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        _searchBtn.backgroundColor = YDRGB(255, 255, 255);
        _searchBtn.titleLabel.font = YDFont(15);
        [_searchBtn setTitleColor:YDRGB(0, 0, 0) forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  30;
    }

    return 40;
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
        return [[[EmailDataBase sharedDataBase]querySearchInfo] count];
    }
    return self.searchModel.rows.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *searideitifier = @"SearchinfoEmailCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searideitifier ];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searideitifier];
        }
        cell.textLabel.text = [[EmailDataBase sharedDataBase]querySearchInfo][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return  cell;
    }else{
    
    
    static NSString *ideitifier = @"SearchEmailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideitifier ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ideitifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        YDInBoxRowsModel *cellModel = self.searchModel.rows[indexPath.row];
        
        switch (self.searchType) {
            case YUDIANMailSearchTYPESender:
            {
               cell.textLabel.text = cellModel.tomail;
            }
                break;
            case YUDIANMailSearchTYPERecipient:
            {
               cell.textLabel.text = cellModel.formmail;
            }
                
                break;
            case YUDIANMailSearchTYPESubject:
            {
                
                cell.textLabel.text = cellModel.bodyText;
            }
                
                break;
            case YUDIANMailSearchTYPEAll:
            {
               
            }
                
                break;
                
            default:
                break;
        }


    return  cell;
    }

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
                self.searchModel = [[YDInBoxModel alloc] initWithDictionary:responseObj] ;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.searchEmailTabelView  reloadData];
     
                    
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
    [self.view endEditing:YES];
    if (button.tag == 1000) {
          self.searchType = YUDIANMailSearchTYPESender;
        [self searchRequest];
    }else if (button.tag == 1001){
          self.searchType = YUDIANMailSearchTYPERecipient;
        [self searchRequest];
    }else if (button.tag == 1002){
          self.searchType = YUDIANMailSearchTYPESubject;
        [self searchRequest];
    }else if (button.tag == 1003){
          self.searchType = YUDIANMailSearchTYPEAll;
        [self searchRequest];
    }
    
}

- (void)searchAction:(id)sender
{
    [self.view endEditing:YES];
    self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];

    if (self.searchEmail.text.length > 0) {
        [[EmailDataBase sharedDataBase] addSearchInfo:self.searchEmail.text];
        [self searchRequest];
 }

}

- (void)searchRequest
{
    switch (self.searchType) {
        case YUDIANMailSearchTYPESender:
        {
            NSDictionary *dataDic = @{@"name":self.searchEmail.text};
            [self searchRequestWithType:@"GET" withURL:YDEmailFindoUrl withDictionary:dataDic];
        }
            break;
        case YUDIANMailSearchTYPERecipient:
        {
            NSDictionary *dataDic = @{@"name":self.searchEmail.text};
            [self searchRequestWithType:@"GET" withURL:YDEmailFindoUrl withDictionary:dataDic];
        }
            
            break;
        case YUDIANMailSearchTYPESubject:
        {
            NSDictionary *dataDic = @{@"subject":self.searchEmail.text};
            [self searchRequestWithType:@"GET" withURL:YDEmailFindoUrl withDictionary:dataDic];
        }
            
            break;
        case YUDIANMailSearchTYPEAll:
        {
            NSDictionary *dataDic = @{@"name":self.searchEmail.text};
            [self searchRequestWithType:@"GET" withURL:YDEmailFindoUrl withDictionary:dataDic];
        }
            
            break;
            
        default:
            break;
    }

}


@end
