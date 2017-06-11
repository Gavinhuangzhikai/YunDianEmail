//
//  YDChangePasswordViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDChangePasswordViewController.h"

@interface YDChangePasswordViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *oldPasswordTextField;

@property (nonatomic,strong) UITextField *newPasswordTextField;

@property (nonatomic,strong) UITextField *confirmPasswordTextField;

@property (nonatomic,strong) UIButton  *changePasswordBtn;
@end

@implementation YDChangePasswordViewController

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
    [self.view addSubview:self.oldPasswordTextField];
    [self.oldPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(self.view.width -50);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.newPasswordTextField];
    [self.newPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(self.oldPasswordTextField.mas_bottom).with.offset(20);
        make.width.mas_equalTo(self.view.width -50);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.confirmPasswordTextField];
    [self.confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(self.newPasswordTextField.mas_bottom).with.offset(20);
        make.width.mas_equalTo(self.view.width -50);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.changePasswordBtn];
    [self.changePasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.confirmPasswordTextField.mas_bottom).with.offset(20);
        make.width.mas_equalTo(200);
        make.height.equalTo(@30);
    }];
}

#pragma mark - Layz init
- (UITextField *)oldPasswordTextField
{
    if (!_oldPasswordTextField) {
        _oldPasswordTextField = [[UITextField alloc]init];
        _oldPasswordTextField.backgroundColor = [UIColor clearColor];
        UIView *oldPasswordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        oldPasswordLeftView.backgroundColor = [UIColor clearColor];
        UILabel *oldPassword = [[UILabel alloc]init];
        oldPassword.textColor = YDRGB(0, 0, 0);
        oldPassword.frame = CGRectMake(0, 0, 55, 40);
        oldPassword.font = YDFont(12);
        oldPassword.text = @"旧密码";
        oldPassword.textAlignment = NSTextAlignmentRight;
        [oldPasswordLeftView addSubview:oldPassword];
        
        _oldPasswordTextField.leftView = oldPasswordLeftView;
        _oldPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_oldPasswordTextField setBorderStyle:UITextBorderStyleRoundedRect];
        _oldPasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _oldPasswordTextField.delegate =self;
        _oldPasswordTextField.font = YDFont(15);
        _oldPasswordTextField.textColor = YDRGB(0, 0, 0);
        _oldPasswordTextField.secureTextEntry = YES;
        
    }
    return _oldPasswordTextField;
}

- (UITextField *)newPasswordTextField
{
    if (!_newPasswordTextField) {
        _newPasswordTextField = [[UITextField alloc]init];
        _newPasswordTextField.backgroundColor = [UIColor clearColor];
        UIView *newPasswordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        newPasswordLeftView.backgroundColor = [UIColor clearColor];
        UILabel *newPassword = [[UILabel alloc]init];
        newPassword.textColor = YDRGB(0, 0, 0);
        newPassword.frame = CGRectMake(0, 0, 55, 40);
        newPassword.font = YDFont(12);
        newPassword.text = @"新密码";
        newPassword.textAlignment = NSTextAlignmentRight;
        [newPasswordLeftView addSubview:newPassword];
        
        _newPasswordTextField.leftView = newPasswordLeftView;
        _newPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_newPasswordTextField setBorderStyle:UITextBorderStyleRoundedRect];
        _newPasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _newPasswordTextField.delegate =self;
        _newPasswordTextField.font = YDFont(15);
        _newPasswordTextField.textColor = YDRGB(0, 0, 0);
        _newPasswordTextField.secureTextEntry = YES;
        
    }
    return _newPasswordTextField;
}

- (UITextField *)confirmPasswordTextField
{
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[UITextField alloc]init];
        _confirmPasswordTextField.backgroundColor = [UIColor clearColor];
        UIView *confirmPasswordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        confirmPasswordLeftView.backgroundColor = [UIColor clearColor];
        UILabel *confirmPassword = [[UILabel alloc]init];
        confirmPassword.textColor = YDRGB(0, 0, 0);
        confirmPassword.frame = CGRectMake(0, 0, 55, 40);
        confirmPassword.font = YDFont(12);
        confirmPassword.text = @"确认密码";
        confirmPassword.textAlignment = NSTextAlignmentRight;
        [confirmPasswordLeftView addSubview:confirmPassword];
        
        _confirmPasswordTextField.leftView = confirmPasswordLeftView;
        _confirmPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_confirmPasswordTextField setBorderStyle:UITextBorderStyleRoundedRect];
        _confirmPasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _confirmPasswordTextField.delegate =self;
        _confirmPasswordTextField.font = YDFont(15);
        _confirmPasswordTextField.textColor = YDRGB(0, 0, 0);
        _confirmPasswordTextField.secureTextEntry = YES;
        
    }
    return _confirmPasswordTextField;
}

- (UIButton *)changePasswordBtn
{
    if(!_changePasswordBtn){
        
        _changePasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changePasswordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        _changePasswordBtn.backgroundColor = YDRGB(30, 118, 156);
        [_changePasswordBtn setTitleColor:YDRGB(255, 255, 255) forState:UIControlStateNormal];
        [_changePasswordBtn setTitleColor:YDRGB(160, 160, 160) forState:UIControlStateHighlighted];
        [_changePasswordBtn.layer setMasksToBounds:YES];
        [_changePasswordBtn.layer setCornerRadius:8.0];
        [_changePasswordBtn addTarget:self action:@selector(changePasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changePasswordBtn;
}

- (void)changePasswordAction:(id)sender
{
    [self.view endEditing:YES];
    if ([self validateInput]) {
        
        _changePasswordBtn.userInteractionEnabled = NO;
        self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];
        NSDictionary *dataDic = @{@"oldpassword":[YDTools md5 :_oldPasswordTextField.text],@"newpassword":[YDTools md5: _newPasswordTextField.text]};
        
        [self changePasswordRequestWithDictionary:dataDic];
        
    }
    
}

- (BOOL)validateInput
{
    if ([YDValidate isEmpty :self.oldPasswordTextField.text ]) {
        [YDTools HUDTextOnly:@"请输入旧密码" toView:YDWindow];
        [self.oldPasswordTextField becomeFirstResponder];
         return NO;
    }
    
    if ([YDValidate isEmpty :self.newPasswordTextField.text ]) {
        [YDTools HUDTextOnly:@"请输入新密码" toView:YDWindow];
        [self.newPasswordTextField becomeFirstResponder];
         return NO;
    }
    
    if ([YDValidate isEmpty :self.confirmPasswordTextField.text ]) {
        [YDTools HUDTextOnly:@"请输入确认密码" toView:YDWindow];
        [self.confirmPasswordTextField becomeFirstResponder];
         return NO;
    }
    
    if (![self.newPasswordTextField.text isEqualToString:self.confirmPasswordTextField.text ]) {
        [YDTools HUDTextOnly:@"新密码不相同" toView:YDWindow];
        [self.confirmPasswordTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - 登录请求
- (void)changePasswordRequestWithDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:@"POST" requestURL:YDChangePasswordUrl parameters:dictionary success:^(id responseObj) {
        NSString * status = responseObj[@"result"];
        
        if ([status isEqualToString:@"ok"]) {
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                    [self analyseData:responseObj];
                dispatch_async(dispatch_get_main_queue(), ^{
                  [YDTools HUDTextOnly:@"密码修改成功" toView:YDWindow];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:NO];
                    });

                });
            });
            
        }else {
            [YDTools loadFailedHUD:self.hud text:status ];
            
        }
        
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
    _changePasswordBtn.userInteractionEnabled = YES;
    
}




@end
