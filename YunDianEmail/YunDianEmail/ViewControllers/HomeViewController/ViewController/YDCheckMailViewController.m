//
//  YDCheckMailViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDCheckMailViewController.h"

@interface YDCheckMailViewController ()

@property (nonatomic,strong)UIScrollView *checkMailScrollView;

@property (nonatomic,strong)UILabel *captionLabel;


@property (nonatomic,strong)UILabel *theSenderLabel;

@property (nonatomic,strong)UILabel *theRecipientLabel;

@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)UITextView *contentEmail;

@property (nonatomic,strong)UIButton *annexBtn;

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
{
}

#pragma mark -创建控件
- (void)createInterface
{
    [self.view addSubview:self.checkMailScrollView];
    
    [self.checkMailScrollView addSubview:self.captionLabel];
    [self.captionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkMailScrollView.mas_right).with.offset(10);
        make.top.equalTo(self.checkMailScrollView.mas_top).with.offset(10);
        make.width.mas_equalTo(self.view.width -20);;
        make.height.greaterThanOrEqualTo(@40);
    }];
    
    UILabel *senderLabel = [[UILabel alloc] init];
    senderLabel.text = @"发件人:";
    senderLabel.font = YDFont(12);
    senderLabel.textAlignment = NSTextAlignmentRight;
    senderLabel.textColor =YDRGB(111, 111, 111);
    [self.checkMailScrollView addSubview:senderLabel];
    [senderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkMailScrollView.mas_left).with.offset(10);
        make.top.equalTo(self.captionLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];

    [self.checkMailScrollView addSubview:self.theSenderLabel];
    [self.theSenderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(senderLabel.mas_right).with.offset(5);
        make.top.equalTo(self.captionLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -110);;
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    
    UILabel *recipientLabel = [[UILabel alloc] init];
    recipientLabel.text = @"收件人:";
    recipientLabel.font = YDFont(12);
    recipientLabel.textAlignment = NSTextAlignmentRight;
    recipientLabel.textColor =YDRGB(111, 111, 111);
    [self.checkMailScrollView addSubview:recipientLabel];
    [recipientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkMailScrollView.mas_left).with.offset(10);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.checkMailScrollView addSubview:self.theRecipientLabel];
    [self.theRecipientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recipientLabel.mas_right).with.offset(5);
        make.top.equalTo(self.theSenderLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -110);;
        make.height.greaterThanOrEqualTo(@20);
    }];

    UILabel *timLabel = [[UILabel alloc] init];
    timLabel.text = @"时间:";
    timLabel.font = YDFont(12);
    timLabel.textAlignment = NSTextAlignmentRight;
    timLabel.textColor =YDRGB(111, 111, 111);
    [self.checkMailScrollView addSubview:timLabel];
    [timLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkMailScrollView.mas_left).with.offset(10);
        make.top.equalTo(self.theRecipientLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.checkMailScrollView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timLabel.mas_right).with.offset(5);
        make.top.equalTo(self.theRecipientLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -110);;
        make.height.greaterThanOrEqualTo(@20);
    }];

    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = YDRGB(244, 244, 244);
    [self.checkMailScrollView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timLabel.mas_right).with.offset(5);
        make.top.equalTo(self.timeLabel.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -10);;
        make.height.greaterThanOrEqualTo(@1);
    }];
    
    
    [self.checkMailScrollView addSubview:self.contentEmail];
    [self.contentEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(5);
        make.top.equalTo(line.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -10);;
        make.height.greaterThanOrEqualTo(@80);
    }];
    
}

#pragma mark - Layz init
- (UIScrollView *)checkMailScrollView
{
    if (!_checkMailScrollView) {
        _checkMailScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _checkMailScrollView.showsHorizontalScrollIndicator = NO;
        _checkMailScrollView.showsVerticalScrollIndicator = NO;
        _checkMailScrollView.backgroundColor = [UIColor whiteColor];
        _checkMailScrollView.alwaysBounceHorizontal = NO;
        _checkMailScrollView.backgroundColor =[UIColor whiteColor];
    }
    
    return _checkMailScrollView;
}

- (UILabel *)captionLabel
{
    if (!_captionLabel) {
        _captionLabel = [[UILabel alloc] init];
        _captionLabel.textColor = YDRGB(0, 0, 0);
        _captionLabel.font = YDFont(15);
    }
    
    return _captionLabel;
}

- (UILabel *)theSenderLabel
{
    if (!_theSenderLabel) {
        _theSenderLabel = [[UILabel alloc] init];
        _theSenderLabel.textColor = YDRGB(0, 0, 0);
        _theSenderLabel.font = YDFont(15);
    }
    
    return _theSenderLabel;
}

- (UILabel *)theRecipientLabel
{
    if (!_theRecipientLabel) {
        _theRecipientLabel = [[UILabel alloc] init];
        _theRecipientLabel.textColor = YDRGB(0, 0, 0);
        _theRecipientLabel.font = YDFont(15);
    }
    
    return _theRecipientLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = YDRGB(0, 0, 0);
        _timeLabel.font = YDFont(15);
    }
    
    return _timeLabel;
}

- (UITextView *)contentEmail
{
    if (!_contentEmail) {
        _contentEmail = [[UITextView alloc] init];
        _contentEmail.textColor = [UIColor blackColor];
      
        _contentEmail.backgroundColor = [UIColor whiteColor];
    
        _contentEmail.scrollEnabled = YES;
        
        
    }
    return _contentEmail;
}

- (UIButton *)annexBtn
{
    if (!_annexBtn) {
        _annexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _annexBtn.backgroundColor = YDRGB(30, 118, 156);
        [_annexBtn setTitleColor:YDRGB(255, 255, 255) forState:UIControlStateNormal];
        [_annexBtn setTitleColor:YDRGB(160, 160, 160) forState:UIControlStateHighlighted];
        [_annexBtn addTarget:self action:@selector(checkAnnex:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _annexBtn;
}

- (void)checkAnnex:(UIButton *)button
{
    
    
}

@end
