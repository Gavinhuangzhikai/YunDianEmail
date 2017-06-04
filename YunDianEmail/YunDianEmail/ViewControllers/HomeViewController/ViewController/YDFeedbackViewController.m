//
//  YDFeedbackViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDFeedbackViewController.h"
#import "UIPlaceholderTextView.h"

@interface YDFeedbackViewController ()
@property (nonatomic,strong)UIPlaceholderTextView *feedbackTextView;

@property (nonatomic,strong)UIButton *submitButton;
@property (nonatomic,strong)NSString *placeholder;
@end

@implementation YDFeedbackViewController

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
    self.title = @"意见反馈";
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{
}

#pragma mark -创建控件
- (void)createInterface
{
    
    self.view.backgroundColor = YDRGB(243, 243, 243);
 
    /**
     *  UITextView约束
     */
    [self.view addSubview:self.feedbackTextView];
    [self.feedbackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@201);
        make.left.equalTo(self.view.mas_left).with.offset(17);
        make.right.equalTo(self.view.mas_right).with.offset(-17);
        make.top.equalTo(self.view.mas_top).with.offset(19);
    }];
    
    
    /**
     *  UIbutton约束
     */
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@38);
        make.left.equalTo(self.view.mas_left).with.offset(17);
        make.right.equalTo(self.view.mas_right).with.offset(-17);
        make.top.equalTo(self.feedbackTextView.mas_bottom).with.offset(5);
    }];
    
}

#pragma mark - Layz init
-(UIPlaceholderTextView *)feedbackTextView
{
    if (!_feedbackTextView) {
        _feedbackTextView = [[UIPlaceholderTextView alloc]init];
        _feedbackTextView.placeholder = @"请输入您的反馈意见";
        _feedbackTextView.backgroundColor=YDRGB(255, 255, 255);
        _feedbackTextView.scrollEnabled = NO;
        _feedbackTextView.delegate = self;
        _feedbackTextView.font=YDFont(15);
        _feedbackTextView.returnKeyType = UIReturnKeyDefault;
        _feedbackTextView.keyboardType = UIKeyboardTypeDefault;
        _feedbackTextView.textAlignment = NSTextAlignmentLeft;
        _feedbackTextView.dataDetectorTypes = UIDataDetectorTypeAll;
        [_feedbackTextView.layer setMasksToBounds:YES];
        [_feedbackTextView.layer setCornerRadius:5.0];
        [_feedbackTextView.layer setBorderWidth:1.0];
        _feedbackTextView.layer.borderColor=YDRGB(234, 234, 234).CGColor;
        [self.view addSubview:_feedbackTextView];
    }
    return _feedbackTextView;
}


- (UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        
        [_submitButton setTitle:@"提 交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:YDRGB(255, 255, 255) forState:UIControlStateNormal];
        [_submitButton setTitleColor:YDRGB(160, 160, 160) forState:UIControlStateHighlighted];
        [_submitButton.layer setMasksToBounds:YES];
        [_submitButton.layer setCornerRadius:5.0];
        [_submitButton addTarget:self action:@selector(submitFeedbackAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


#pragma mark - UIButton selector
- (void)submitFeedbackAction:(UIButton *)button
{
    [self.view endEditing:YES];
    if ( [self validateInput]) {
        _submitButton.userInteractionEnabled = NO;
        self.hud = [YDTools HUDLoadingOnView:self.navigationController.view delegate:self];
//        NSDictionary *dataDic = @{@"txtMsgInfo":_feedbackTextView.text,@"txtPwd":_phoneNumberTextField.text};
//        [self  feedbackRequestWithDictionary:dataDic];
    }
    
}
#pragma mark - 登录前验证
- (BOOL) validateInput
{
    if ([YDValidate isEmpty:_feedbackTextView.text])
    {
        [YDTools HUDTextOnly:@"请输入您的反馈建议" toView:YDWindow];
        [_feedbackTextView becomeFirstResponder];
        return NO;
    }
    return YES;
}

- (void)feedbackRequestWithDictionary:(NSDictionary *)dictionary
{
    

    _submitButton.userInteractionEnabled = YES;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    if (textView.text.length + text.length > 150){
        if (location != NSNotFound){
            [textView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
