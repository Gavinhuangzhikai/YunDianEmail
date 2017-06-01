//
//  YDLoginViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDLoginViewController.h"

@interface YDLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *accountTextField;//帐号
@property (nonatomic,strong) UITextField *passwordTextField;//密码
@property (nonatomic,strong) UIButton *rememberPasswordBtn;//是否记住密码
@property (nonatomic,strong) UIButton *loginButton;//登录按钮
@end

@implementation YDLoginViewController

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
    [self.view addSubview: self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.equalTo(@300);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview: self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.accountTextField.mas_bottom).with.offset(20);
        make.width.equalTo(@300);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview: self.rememberPasswordBtn];
    [self.rememberPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTextField.mas_left);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(20);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    UILabel *rememberPasswordLabel = [[ UILabel alloc]init];
    rememberPasswordLabel.textColor = YDRGB(233, 255, 255);
    rememberPasswordLabel.font = YDFont(15);
    rememberPasswordLabel.text = @"记住密码";
    [self.view addSubview:rememberPasswordLabel];
    [rememberPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rememberPasswordBtn.mas_right).with.offset(10);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(20);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    
    [self.view addSubview: self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.rememberPasswordBtn.mas_bottom).with.offset(20);
        make.width.equalTo(@300);
        make.height.equalTo(@30);
    }];
}

#pragma mark - Layz init
//用户名输入框
- (UITextField *)accountTextField
{
    if (!_accountTextField) {
        
        _accountTextField = [[UITextField alloc]init];
        UIView *accountLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        accountLeftView.backgroundColor = [UIColor clearColor];
        UIImageView *accountImage = [[UIImageView alloc]init];
        accountImage.contentMode = UIViewContentModeScaleAspectFit;
        accountImage.frame = CGRectMake(0, 0, 40, 40);
        [accountLeftView addSubview:accountImage];
        
        _accountTextField.leftView = accountLeftView;
        _accountTextField.leftViewMode = UITextFieldViewModeAlways;
        [_accountTextField setBorderStyle:UITextBorderStyleRoundedRect];
        _accountTextField.placeholder = @"输入账号";
        [_accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _accountTextField.delegate =self;
        _accountTextField.font = YDFont(15);
        _accountTextField.textColor = YDRGB(0, 0, 0);
        _accountTextField.backgroundColor = [UIColor clearColor];
        _accountTextField.keyboardType =UIKeyboardTypeNumberPad;
        
    }
    return _accountTextField;
}

//密码输入框
- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        
        
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.backgroundColor = [UIColor clearColor];
        UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        passwordLeftView.backgroundColor = [UIColor clearColor];
        UIImageView *passwordImage = [[UIImageView alloc]init];
        passwordImage.contentMode = UIViewContentModeScaleAspectFit;
        passwordImage.frame = CGRectMake(0, 0, 40, 40);
        [passwordLeftView addSubview:passwordImage];
        
        _passwordTextField.leftView = passwordLeftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
        _passwordTextField.placeholder = @"输入密码";
        _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _passwordTextField.delegate =self;
        _passwordTextField.font = YDFont(15);
        _passwordTextField.textColor = YDRGB(0, 0, 0);
        _passwordTextField.secureTextEntry = YES;
        
    }
    return _passwordTextField;
}

//是否记住密码
- (UIButton *)rememberPasswordBtn
{
    if (!_rememberPasswordBtn) {
        _rememberPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rememberPasswordBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_rememberPasswordBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_rememberPasswordBtn addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rememberPasswordBtn;
}

//登录按钮
- (UIButton *)loginButton
{
    if(!_loginButton){
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = YDRGB(30, 118, 156);
        [_loginButton setTitleColor:YDRGB(255, 255, 255) forState:UIControlStateNormal];
        [_loginButton setTitleColor:YDRGB(160, 160, 160) forState:UIControlStateHighlighted];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:30.0];
        [_loginButton addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (void)rememberPassword:(UIButton *)rembutton
{
    if (rembutton.selected == YES) {
        rembutton.selected = false;
    }else{
        
         rembutton.selected = YES;
    }
    
}

- (void)LoginAction:(id)sender
{
    
    
}
@end