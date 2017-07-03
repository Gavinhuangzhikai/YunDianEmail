//
//  YDCheckMailViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDCheckMailViewController.h"
#import "YDEmailFileFindModel.h"
#import "YDViewAttachmentsViewController.h"

@interface YDCheckMailViewController ()

//@property (nonatomic,strong)UIScrollView *checkMailScrollView;

@property (nonatomic,strong)UILabel *captionLabel;


@property (nonatomic,strong)UILabel *theSenderLabel;

@property (nonatomic,strong)UILabel *theRecipientLabel;

@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)UILabel *theRecipientTitle;

@property (nonatomic,strong)UILabel *timeTitle;

@property (nonatomic,strong)UITextView *contentEmail;

@property (nonatomic,strong)UIButton *annexBtn;

@property (nonatomic,strong)UIView *nextView;

@property (nonatomic,strong)YDEmailFileFindModel *emailFile;

@end

@implementation YDCheckMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看邮件";
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
{   self.hud = [YDTools HUDLoadingOnView:self.view delegate:self]; 
     NSDictionary *dataDic = @{@"id":self.emailID};
    [self getEmailRequestWithType:@"GET" withURL:YDEmailGetUrl withDictionary:dataDic];
    
 
}

#pragma mark -创建控件
- (void)createInterface
{
//    [self.view addSubview:self.checkMailScrollView];
    
    [self.view addSubview:self.captionLabel];
    [self.captionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.equalTo(@40);
    }];
    
    UILabel *senderLabel = [[UILabel alloc] init];
    senderLabel.text = @"发件人:";
    senderLabel.font = YDFont(12);
    senderLabel.textAlignment = NSTextAlignmentRight;
    senderLabel.textColor =YDRGB(111, 111, 111);
    [self.view addSubview:senderLabel];
    [senderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.captionLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@45);
        make.height.equalTo(@20);
    }];

    [self.view addSubview:self.annexBtn];
    [self.annexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.top.equalTo(self.captionLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(40);;
        make.height.equalTo(@20);
    }];
    
    
    [self.view addSubview:self.theSenderLabel];
    [self.theSenderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(senderLabel.mas_right).with.offset(5);
        make.top.equalTo(self.captionLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -110);;
        make.height.equalTo(@20);
    }];

    

    
    
    [self.view insertSubview:self.nextView atIndex:0];
    [self.nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);;
        make.height.equalTo(@30);
    }];
    
    [self.theRecipientTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@0);
        make.height.equalTo(@0);
    }];
    
    [self.view addSubview:self.theRecipientLabel];
    [self.theRecipientLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.theRecipientTitle.mas_right).with.offset(5);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(0);;
        make.height.equalTo(@0);
    }];
    
    [self.timeTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.theRecipientLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@0);
        make.height.equalTo(@0);
    }];
    
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeTitle.mas_right).with.offset(5);
        make.top.equalTo(self.theRecipientLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(0);;
        make.height.equalTo(@0);
    }];

    
    [self.view addSubview:self.contentEmail];
    [self.contentEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.bottom.equalTo(self.nextView.mas_top);
    }];
}

#pragma mark - Layz init
//- (UIScrollView *)checkMailScrollView
//{
//    if (!_checkMailScrollView) {
//        _checkMailScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
//        _checkMailScrollView.showsHorizontalScrollIndicator = NO;
//        _checkMailScrollView.showsVerticalScrollIndicator = NO;
//        _checkMailScrollView.backgroundColor = [UIColor whiteColor];
//        _checkMailScrollView.alwaysBounceHorizontal = NO;
//        _checkMailScrollView.backgroundColor =[UIColor whiteColor];
//    }
//    
//    return _checkMailScrollView;
//}

- (UILabel *)captionLabel
{
    if (!_captionLabel) {
        _captionLabel = [[UILabel alloc] init];
        _captionLabel.textColor = YDRGB(0, 0, 0);
        _captionLabel.font = YDFont(20);
        _captionLabel.numberOfLines = 2;
        _captionLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    
    return _captionLabel;
}

- (UILabel *)theSenderLabel
{
    if (!_theSenderLabel) {
        _theSenderLabel = [[UILabel alloc] init];
        _theSenderLabel.textColor = YDRGB(111, 111, 111);
        _theSenderLabel.font = YDFont(15);
    }
    
    return _theSenderLabel;
}

- (UILabel *)theRecipientLabel
{
    if (!_theRecipientLabel) {
        _theRecipientLabel = [[UILabel alloc] init];
        _theRecipientLabel.textColor = YDRGB(111, 111, 111);
        _theRecipientLabel.font = YDFont(15);
        [self.view addSubview:self.theRecipientLabel];
    }
    
    return _theRecipientLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = YDRGB(111, 111, 111);
        _timeLabel.font = YDFont(15);
        [self.view addSubview:_timeLabel];
    }
    
    return _timeLabel;
}

- (UILabel *)timeTitle
{
    if (!_timeTitle) {
        _timeTitle = [[UILabel alloc] init];
        _timeTitle.textColor = YDRGB(111, 111, 111);
        _timeTitle.font = YDFont(12);
        _timeTitle.text = @"时间:";
        _timeTitle.textAlignment = NSTextAlignmentRight;

        [self.view addSubview:_timeTitle];

    }
    
    return _timeTitle;
}

- (UILabel *)theRecipientTitle
{
    if (!_theRecipientTitle) {
        _theRecipientTitle = [[UILabel alloc] init];
        _theRecipientTitle.textColor = YDRGB(111, 111, 111);
        _theRecipientTitle.font = YDFont(12);
        _theRecipientTitle.text = @"收件人:";
        _theRecipientTitle.textAlignment = NSTextAlignmentRight;
        [self.view addSubview:_theRecipientTitle];
        
    }
    
    return _theRecipientTitle;
}

- (UITextView *)contentEmail
{
    if (!_contentEmail) {
        _contentEmail = [[UITextView alloc] init];
        _contentEmail.textColor = [UIColor blackColor];
      
        _contentEmail.backgroundColor = [UIColor whiteColor];
        _contentEmail.alwaysBounceVertical = NO;
        
        _contentEmail.scrollEnabled = YES;
        [_contentEmail setEditable:NO];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.frame = CGRectMake(0, 0, YDScreenWidth-10, 1);
        line.backgroundColor = YDRGB(244, 244, 244);
        
        [_contentEmail addSubview:line];
        
    }
    return _contentEmail;
}

- (UIButton *)annexBtn
{
    if (!_annexBtn) {
        _annexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _annexBtn.backgroundColor = YDRGB(30, 118, 156);
        [_annexBtn setImage:[UIImage imageNamed:@"clear_icon"] forState:UIControlStateNormal];
        [_annexBtn addTarget:self action:@selector(checkAnnex:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _annexBtn;
}

-(UIView *)nextView
{
    if (!_nextView) {
        _nextView = [[UIView alloc] init];
        _nextView.backgroundColor = YDRGB(111, 111, 111);
        
        UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        upButton.frame = CGRectMake(20, 0, 30, 30);
        [upButton setImage:[UIImage imageNamed:@"pull_up_select_icon"] forState:UIControlStateNormal];
        [upButton addTarget:self action:@selector(upBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_nextView addSubview:upButton];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nextButton.frame = CGRectMake(60, 0, 30, 30);
        [nextButton setImage:[UIImage imageNamed:@"keyboard_detail_icon"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_nextView addSubview:nextButton];
        
    }
    
    return _nextView;
}
     
     
 - (void)getEmailRequestWithType:(NSString *)requestType   withURL:(NSString *)urlString    withDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:requestType requestURL:urlString parameters:dictionary success:^(id responseObj) {
        if ([responseObj isKindOfClass:[NSDictionary class]]){
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self analyseData:responseObj];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.captionLabel.text = self.inboxRows.subject;
                    
                    
                    self.theSenderLabel.text = self.inboxRows.tomail;
                    
                    self.theRecipientLabel.text = self.inboxRows.formmail;
                    
                    self.timeLabel.text = self.inboxRows.sentDate;
                    
//                    self.contentEmail.text = self.inboxRows.bodyText;
                    NSAttributedString * strAtt = [[NSAttributedString alloc] initWithData:[self.inboxRows.bodyText dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                
                    self.contentEmail.attributedText = strAtt;
                    
                    if (self.refrushData) {
                        self.refrushData();
                    }
                    
                    
                    NSDictionary *dataFileDic = @{@"emailid":self.inboxRows.ID};
                    [self getEmailFileFindRequestWithType:@"GET" withURL:YDEmailFileFindoUrl withDictionary:dataFileDic];
                    
                });
            });
        }else {
            [YDTools loadFailedHUD:self.hud text:@"请求失败" ];
            
        }
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
}

- (void)getEmailFileFindRequestWithType:(NSString *)requestType   withURL:(NSString *)urlString    withDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:requestType requestURL:urlString parameters:dictionary success:^(id responseObj) {
        if ([responseObj isKindOfClass:[NSDictionary class]]){
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.emailFile = [[YDEmailFileFindModel alloc] initWithDictionary:responseObj];
                    
                    for ( int i = 0 ; i < self.emailFile.rows.count ; i++) {
                        
                        YDEmailFileFindRowsModel *emailFileRows = self.emailFile.rows[i];
                        UIButton *labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        [labelBtn setTitle:emailFileRows.filename forState:UIControlStateNormal];
                       labelBtn.titleLabel.font = YDFont(13);
                        [labelBtn setTitleColor:YDRGB(111, 111, 111) forState:UIControlStateNormal];
                    
                        labelBtn.backgroundColor = YDRGB(245, 245, 245);
                        labelBtn.tag = 100 + i;
                        [labelBtn addTarget:self action:@selector(pushToFileView:) forControlEvents:UIControlEventTouchUpInside];
                        labelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        labelBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                        [self.view addSubview:labelBtn];
                        [labelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.view.mas_left).with.offset(0);
                            make.bottom.equalTo(self.nextView.mas_top).with.offset(-i*20);
                            make.right.equalTo(self.view.mas_right);
                            make.height.equalTo(@20);
                        }];

                    }
                    
                    NSUInteger i = self.emailFile.rows.count;
                    NSLog(@"%lu",i*20);
                    [self.contentEmail mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.view.mas_left).with.offset(5);
                        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(10);
                        make.right.equalTo(self.view.mas_right).with.offset(-5);
                        make.bottom.equalTo(self.nextView.mas_top).with.offset(-40);
                    }];
                    
                
                });
            });
        }else {
            [YDTools loadFailedHUD:self.hud text:@"请求失败" ];
            
        }
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
}

 -(void)analyseData:(id)responseObj
{
    self.inboxRows = [[YDInBoxRowsModel alloc] initWithDictionary:responseObj] ;
    
}

     
- (void)checkAnnex:(UIButton *)button
{
    if (button.selected == YES) {
        button.selected = false;

        
    [self.theRecipientTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@0);
        make.height.equalTo(@0);
    }];

    [self.view addSubview:self.theRecipientLabel];
    [self.theRecipientLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.theRecipientTitle.mas_right).with.offset(5);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(0);;
        make.height.equalTo(@0);
    }];
    
    [self.timeTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.theRecipientLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@0);
        make.height.equalTo(@0);
    }];
    
    
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeTitle.mas_right).with.offset(5);
        make.top.equalTo(self.theRecipientLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(0);;
        make.height.equalTo(@0);
    }];
    

        
    }else{
    
    button.selected = YES;
  

    [self.theRecipientTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@45);
        make.height.equalTo(@20);
    }];
    
    
    [self.theRecipientLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.theRecipientTitle.mas_right).with.offset(5);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -110);;
        make.height.equalTo(@20);
    }];
    
    [self.timeTitle mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(10);
            make.top.equalTo(self.theRecipientTitle.mas_bottom).with.offset(5);
            make.width.equalTo(@45);
            make.height.equalTo(@20);
        }];

        
    [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeTitle.mas_right).with.offset(5);
        make.top.equalTo(self.theRecipientLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -110);;
        make.height.equalTo(@20);
    }];

    
    [self.contentEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.top.equalTo(self.timeLabel.mas_bottom).with.offset(8);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.bottom.equalTo(self.nextView.mas_top).with.offset(-40);
    }];

  }
    
}

- (void)pushToFileView:(UIButton*)button
{
    YDEmailFileFindRowsModel *emailFileRows = self.emailFile.rows[button.tag -100];

    YDViewAttachmentsViewController *attchVtr = [[YDViewAttachmentsViewController alloc] init];
    attchVtr.emailFileModel = emailFileRows ;
    [self.navigationController pushViewController:attchVtr animated:NO];
    
}

-(void)upBtnAction:(id)sender
{
    self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];
    NSDictionary *dataDic = @{@"id":self.emailID,@"previous":@1};
    [self getEmailRequestWithType:@"GET" withURL:YDEmailGetUrl withDictionary:dataDic];
}

-(void)nextBtnAction:(id)sender
{
    self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];
    NSDictionary *dataDic = @{@"id":self.emailID,@"next":@3};
    [self getEmailRequestWithType:@"GET" withURL:YDEmailGetUrl withDictionary:dataDic];
}
@end
