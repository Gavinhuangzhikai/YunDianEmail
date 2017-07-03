//
//  YDLoginViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDLoginViewController.h"
#import "YDHomeViewController.h"
#import "YDBasicNavgationViewController.h"
#import "YDUserDataManager.h"
#import "YDUserDataModel.h"

@interface YDLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *accountTextField;//帐号
@property (nonatomic,strong) UITextField *passwordTextField;//密码
@property (nonatomic,strong) UIButton *rememberPasswordBtn;//是否记住密码
@property (nonatomic,strong) UIButton *loginButton;//登录按钮

@property (nonatomic,strong) UIImageView *enterpriseImageView;//登录按钮
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    [self.view addSubview: self.enterpriseImageView];
    [self.enterpriseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(200);
//        make.height.mas_equalTo(self.view.mas_width).multipliedBy(120/894);
    }];
    
    [self.view addSubview: self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.enterpriseImageView.mas_bottom).with.offset(20);
        make.width.equalTo(@250);
        make.height.equalTo(@44);
    }];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(40,38, 180, 1)];
    line.backgroundColor=YDRGB(90, 139, 210);
    [_accountTextField addSubview:line];
    
    [self.view addSubview: self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.accountTextField.mas_bottom).with.offset(20);
        make.width.equalTo(@250);
        make.height.equalTo(@44);
    }];
    UIView *linetwo=[[UIView alloc]initWithFrame:CGRectMake(40,38, 180, 1)];
    linetwo.backgroundColor=YDRGB(90, 139, 210);
    [_passwordTextField addSubview:linetwo];
    
    [self.view addSubview: self.rememberPasswordBtn];
    [self.rememberPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTextField.mas_left);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(20);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    UILabel *rememberPasswordLabel = [[ UILabel alloc]init];
    rememberPasswordLabel.textColor = YDRGB(230, 230, 230);
    rememberPasswordLabel.font = YDFont(13);
    rememberPasswordLabel.text = @"记住密码";
    [self.view addSubview:rememberPasswordLabel];
    [rememberPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rememberPasswordBtn.mas_right).with.offset(3);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    
    [self.view addSubview: self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.rememberPasswordBtn.mas_bottom).with.offset(20);
        make.width.equalTo(@250);
        make.height.equalTo(@35);
    }];
    
    YDUserDataModel *userModel = [YDUserDataModel mj_objectWithKeyValues:[YDUserDataManager readUserData]];
    
    self.accountTextField.text = userModel.userAccount;
    
    self.passwordTextField.text = userModel.userPassword;
    
}

#pragma mark - Layz init
//用户名输入框
- (UITextField *)accountTextField
{
    if (!_accountTextField) {
        
        _accountTextField = [[UITextField alloc]init];
        UIView *accountLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
        accountLeftView.backgroundColor = [UIColor clearColor];
        UIImageView *accountImage = [[UIImageView alloc]init];
        accountImage.contentMode = UIViewContentModeScaleAspectFit;
        accountImage.frame = CGRectMake(10, 6, 25, 27);
        accountImage.image = [UIImage imageNamed:@"login_username.png"];
        [accountLeftView addSubview:accountImage];
        
        _accountTextField.leftView = accountLeftView;
        _accountTextField.leftViewMode = UITextFieldViewModeAlways;
        [_accountTextField setBorderStyle:UITextBorderStyleNone];
        _accountTextField.placeholder = @"  请输入账号";
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
        UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
        passwordLeftView.backgroundColor = [UIColor clearColor];
        UIImageView *passwordImage = [[UIImageView alloc]init];
        passwordImage.contentMode = UIViewContentModeScaleAspectFit;
        passwordImage.frame = CGRectMake(10, 6, 25, 27);
        passwordImage.image = [UIImage imageNamed:@"login_password.png"];
        [passwordLeftView addSubview:passwordImage];
        
        _passwordTextField.leftView = passwordLeftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_passwordTextField setBorderStyle:UITextBorderStyleNone];
        _passwordTextField.placeholder = @"  输入密码";
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
        [_rememberPasswordBtn setImage:[UIImage imageNamed:@"同意_none"] forState:UIControlStateNormal];
        [_rememberPasswordBtn setImage:[UIImage imageNamed:@"同意_selected"] forState:UIControlStateSelected];
        [_rememberPasswordBtn addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
          _rememberPasswordBtn.selected = YES;
    }
    return _rememberPasswordBtn;
}

//登录按钮
- (UIButton *)loginButton
{
    if(!_loginButton){
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = YDRGB(230, 230, 230);
        _loginButton.titleLabel.font = YDFont(15);
        [_loginButton setTitleColor:YDRGB(0, 93, 201) forState:UIControlStateNormal];
        [_loginButton.layer setMasksToBounds:YES];
        [_loginButton.layer setCornerRadius:5.0];
        [_loginButton addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    return _loginButton;
}

- (UIImageView *)enterpriseImageView
{
    if (!_enterpriseImageView) {
        _enterpriseImageView = [[UIImageView alloc] init];
        _enterpriseImageView.contentMode =  UIViewContentModeCenter;
        _enterpriseImageView.backgroundColor = YDRGB(0, 108, 198);
        _enterpriseImageView.image = [UIImage imageNamed:@"enterprise.png"];
    }
    return _enterpriseImageView;
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
    [self.view  endEditing:YES];
    if ([self validateInput]) {
        _loginButton.userInteractionEnabled = NO;
        self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];
        NSDictionary *dataDic = @{@"username":_accountTextField.text,@"password":[YDTools md5: _passwordTextField.text]};
        
        [self loginRequestWithDictionary:dataDic];
    }
    
}

#pragma mark - 登录请求
- (void)loginRequestWithDictionary:(NSDictionary *)dictionary
{
        [YDHttpRequest currentRequestType:@"LOGIN" requestURL:YDCheckLoginUrl parameters:dictionary success:^(id responseObj) {
           NSString * status = responseObj[@"result"];
            
            if ([status isEqualToString:@"success"]) {
             
//                [self.hud hideAnimated:YES];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self analyseData: responseObj];
                    dispatch_async(dispatch_get_main_queue(), ^{
       
                        [self getEmailUserInfo];
                        
                                            
                    });
                });

            }else {
                 [YDTools loadFailedHUD:self.hud text:status ];
                
            }
            
            
    
        } failure:^(NSError *error) {
            [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
        }];
    _loginButton.userInteractionEnabled = YES;
    
}

#pragma mark - 登录前验证
- (BOOL)validateInput
{
    if ([YDValidate isEmpty:_accountTextField.text])
    {
        [YDTools HUDTextOnly:@"请输入账号" toView:YDWindow];
        [_accountTextField becomeFirstResponder];
        return NO;
    }else if([YDValidate isEmpty:_passwordTextField.text]){
        [YDTools HUDTextOnly:@"请输入的密码" toView:YDWindow];
        [_passwordTextField becomeFirstResponder];
        return NO;
    }
//    else if (![YDValidate isValidateNumberAndLetter:_passwordTextField.text])
//    {
//        [YDTools HUDTextOnly:@"请输入正确的密码" toView:YDWindow];
//        [_passwordTextField becomeFirstResponder];
//        return NO;
//    }
    return YES;
}


- (void)getEmailUserInfo
{
    [YDHttpRequest currentRequestType:@"GET" requestURL:YDHomeInfoUrl parameters:@{} success:^(id responseObj) {
        
        [self.hud hideAnimated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self analyseUserNameData:responseObj];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                YDHomeViewController *controller = [[YDHomeViewController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = [[YDBasicNavgationViewController alloc] initWithRootViewController:controller];
    
            });
        });
        
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
    
    
}



- (void)analyseData:(id)respon
{
    if (self.rememberPasswordBtn.selected == YES) {
        YDUserDataModel *userData =[[YDUserDataModel alloc] init];
        userData.userAccount = self.accountTextField.text;
        userData.userPassword = self.passwordTextField.text;
        userData.session = respon[@"session"];
        [YDUserDataManager saveUserData:userData.mj_keyValues];
    }else{
        YDUserDataModel *userData =[[YDUserDataModel alloc] init];
        userData.session = respon[@"session"];
        [YDUserDataManager saveUserData:userData.mj_keyValues];
        
        
    }
    
}

- (void)analyseUserNameData:(id)responser
{
    
    YDUserDataModel *userModel = [YDUserDataModel mj_objectWithKeyValues:[YDUserDataManager readUserData]];
    userModel.userName = responser[@"email"];
    userModel.loginStatus = YES;
    [YDUserDataManager saveUserData:userModel.mj_keyValues];

    
}
@end
