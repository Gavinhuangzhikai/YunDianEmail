//
//  YDWriteLetterViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDWriteLetterViewController.h"

@interface YDWriteLetterViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong)UIScrollView *writeLetterScroller;

@property (nonatomic,strong)UITextView *recipientTextField;

@property (nonatomic,strong)UITextView *scopyForTetxField;

@property (nonatomic,strong)UITextView *hedgecopyForTextField;

@property (nonatomic,strong)UITextView *themeTetxField;

@property (nonatomic,strong)UITextView *emailText;

@end

@implementation YDWriteLetterViewController

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
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sendEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self createInterface];
    
}

#pragma mark - 网络请求
- (void)getDataFromNet
{
}

#pragma mark -创建控件
- (void)createInterface
{
    [self.view addSubview:self.writeLetterScroller];
    
    UILabel *recipientLabel = [[UILabel alloc] init];
    recipientLabel.text = @"收件人:";
    recipientLabel.font = YDFont(12);
    recipientLabel.textColor =YDRGB(233, 233, 233);
    recipientLabel.textAlignment = NSTextAlignmentRight;
    [self.writeLetterScroller addSubview:recipientLabel];
    [recipientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(10);
        make.top.equalTo(self.writeLetterScroller.mas_top).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
    [self.writeLetterScroller addSubview:self.recipientTextField];
    [self.recipientTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(recipientLabel.mas_right).with.offset(5);
        make.top.equalTo(self.writeLetterScroller.mas_top).with.offset(5);
        make.height.greaterThanOrEqualTo(@30);
        make.width.mas_equalTo(self.view.width -110);
    }];
    
    UIImageView *lineImage =[[UIImageView alloc] init];
    lineImage.backgroundColor = YDRGB(244, 244, 244);
    [self.writeLetterScroller addSubview:lineImage];
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(3);
        make.top.equalTo(self.recipientTextField.mas_bottom).with.offset(3);
        make.height.equalTo(@1);
        make.width.mas_equalTo(self.view.width -6);
    }];
    

    UILabel *scopyForLabel = [[UILabel alloc] init];
    scopyForLabel.text = @"抄送:";
    scopyForLabel.font = YDFont(12);
    scopyForLabel.textAlignment = NSTextAlignmentRight;
    scopyForLabel.textColor =YDRGB(233, 233, 233);
    [self.writeLetterScroller addSubview:scopyForLabel];
    [scopyForLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(10);
        make.top.equalTo(lineImage.mas_bottom).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.writeLetterScroller addSubview:self.scopyForTetxField];
    [self.scopyForTetxField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scopyForLabel.mas_right).with.offset(5);
        make.top.equalTo(lineImage.mas_bottom).with.offset(5);
        make.height.greaterThanOrEqualTo(@30);
        make.width.mas_equalTo(self.view.width -110);
    }];
    
    UIImageView *lineTWOImage =[[UIImageView alloc] init];
    lineTWOImage.backgroundColor = YDRGB(244, 244, 244);
    [self.writeLetterScroller addSubview:lineTWOImage];
    [lineTWOImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(3);
        make.top.equalTo(self.scopyForTetxField.mas_bottom).with.offset(3);
        make.height.equalTo(@1);
        make.width.mas_equalTo(self.view.width -6);;
    }];
    
    
    UILabel *hedgecopyForLabel = [[UILabel alloc] init];
    hedgecopyForLabel.text = @"密送:";
    hedgecopyForLabel.font = YDFont(12);
    hedgecopyForLabel.textAlignment = NSTextAlignmentRight;
    hedgecopyForLabel.textColor =YDRGB(233, 233, 233);
    [self.writeLetterScroller addSubview:hedgecopyForLabel];
    [hedgecopyForLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(10);
        make.top.equalTo(lineTWOImage.mas_bottom).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.writeLetterScroller addSubview:self.hedgecopyForTextField];
    [self.hedgecopyForTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hedgecopyForLabel.mas_right).with.offset(5);
        make.top.equalTo(lineTWOImage.mas_bottom).with.offset(5);
        make.height.greaterThanOrEqualTo(@30);
        make.width.mas_equalTo(self.view.width -110);
    }];
    
    UIImageView *lineTHREEImage =[[UIImageView alloc] init];
    lineTHREEImage.backgroundColor = YDRGB(244, 244, 244);
    [self.writeLetterScroller addSubview:lineTHREEImage];
    [lineTHREEImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(3);
        make.top.equalTo(self.hedgecopyForTextField.mas_bottom).with.offset(3);
        make.height.equalTo(@1);
        make.width.mas_equalTo(self.view.width -6);
    }];
    
    UILabel *themeTetxLabel = [[UILabel alloc] init];
    themeTetxLabel.text = @"密送:";
    themeTetxLabel.font = YDFont(12);
    themeTetxLabel.textAlignment = NSTextAlignmentRight;
    themeTetxLabel.textColor =YDRGB(233, 233, 233);
    [self.writeLetterScroller addSubview:themeTetxLabel];
    [themeTetxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(10);
        make.top.equalTo(lineTHREEImage.mas_bottom).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.writeLetterScroller addSubview:self.themeTetxField];
    [self.themeTetxField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(themeTetxLabel.mas_right).with.offset(5);
        make.top.equalTo(lineTHREEImage.mas_bottom).with.offset(5);
        make.height.greaterThanOrEqualTo(@30);
        make.width.mas_equalTo(self.view.width -110);;
    }];

    UIImageView *lineFOURImage =[[UIImageView alloc] init];
    lineFOURImage.backgroundColor = YDRGB(244, 244, 244);
     [self.writeLetterScroller addSubview:lineFOURImage];
    [lineFOURImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_left).with.offset(3);
        make.top.equalTo(self.themeTetxField.mas_bottom).with.offset(3);
        make.height.equalTo(@1);
        make.width.mas_equalTo(self.view.width -6);;
    }];
    
    
    [self.writeLetterScroller addSubview:self.emailText];
    [self.emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_right).with.offset(10);
        make.top.equalTo(lineFOURImage.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -20);;
        make.height.greaterThanOrEqualTo(@200);
    }];
    
  
}

#pragma mark - Layz init
- (UIScrollView *)writeLetterScroller
{
    if (!_writeLetterScroller) {
        _writeLetterScroller = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _writeLetterScroller.showsHorizontalScrollIndicator = NO;
        _writeLetterScroller.showsVerticalScrollIndicator = NO;
        _writeLetterScroller.backgroundColor = [UIColor whiteColor];
        _writeLetterScroller.alwaysBounceHorizontal = NO;
        _writeLetterScroller.backgroundColor =[UIColor whiteColor];
        _writeLetterScroller.contentSize = CGSizeMake(self.view.width, self.view.height);
    }
    
    return _writeLetterScroller;
}

- (UITextView *)recipientTextField
{
    if (!_recipientTextField) {
        _recipientTextField = [[UITextView alloc] init];

        [_recipientTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _recipientTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _recipientTextField.delegate =self;
        _recipientTextField.font = YDFont(15);
        _recipientTextField.textColor = YDRGB(0, 0, 0);
        _recipientTextField.backgroundColor = [UIColor clearColor];
        _recipientTextField.keyboardType =UIKeyboardTypeDefault;

    }
    return _recipientTextField;
}

- (UITextView *)scopyForTetxField
{
    if (!_scopyForTetxField) {
        _scopyForTetxField = [[UITextView alloc] init];

        [_scopyForTetxField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _scopyForTetxField.autocorrectionType = UITextAutocorrectionTypeNo;
        _scopyForTetxField.delegate =self;
        _scopyForTetxField.font = YDFont(15);
        _scopyForTetxField.textColor = YDRGB(0, 0, 0);
        _scopyForTetxField.backgroundColor = [UIColor clearColor];
        _scopyForTetxField.keyboardType =UIKeyboardTypeDefault;
        
    }
    return _scopyForTetxField;
}

- (UITextView *)hedgecopyForTextField
{
    if (!_hedgecopyForTextField) {
        _hedgecopyForTextField = [[UITextView alloc] init];
  
        [_hedgecopyForTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _hedgecopyForTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _hedgecopyForTextField.delegate =self;
        _hedgecopyForTextField.font = YDFont(15);
        _hedgecopyForTextField.textColor = YDRGB(0, 0, 0);
        _hedgecopyForTextField.backgroundColor = [UIColor clearColor];
        _hedgecopyForTextField.keyboardType =UIKeyboardTypeDefault;
        
    }
    return _hedgecopyForTextField;
}
- (UITextView *)themeTetxField
{
    if (!_themeTetxField) {
        _themeTetxField = [[UITextView alloc] init];

        [_themeTetxField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _themeTetxField.autocorrectionType = UITextAutocorrectionTypeNo;
        _themeTetxField.delegate =self;
        _themeTetxField.font = YDFont(15);
        _themeTetxField.textColor = YDRGB(0, 0, 0);
        _themeTetxField.backgroundColor = [UIColor clearColor];
        _themeTetxField.keyboardType =UIKeyboardTypeDefault;
        
    }
    return _themeTetxField;
}

- (UITextView *)emailText
{
    if (!_emailText) {
        _emailText = [[UITextView alloc] init];
        _emailText.textColor = [UIColor blackColor];
        _emailText.delegate = self;
        _emailText.backgroundColor = [UIColor whiteColor];
        _emailText.autocorrectionType = UITextAutocorrectionTypeNo;
        _emailText.delegate =self;
        _emailText.font = YDFont(15);
        _emailText.textColor = YDRGB(0, 0, 0);
        _emailText.backgroundColor = [UIColor clearColor];
        _emailText.keyboardType =UIKeyboardTypeDefault;
        _emailText.scrollEnabled = YES;
        
        
    }
    return _emailText;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    if ([textView isEqual:self.emailText]) {
        
    }else {
        
        CGRect frame = textView.frame;
        CGSize constraintSize = CGSizeMake(frame.size.width -1, MAXFLOAT);
        CGSize size = [textView sizeThatFits:constraintSize];
        if (size.height<=frame.size.height) {
            size.height=frame.size.height;
        }else{
            
            [textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height);
            }];
        }
    }


}

- (void)sendEmailAction:(id)sender
{
    
    
}

@end
