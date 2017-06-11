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

@property (nonatomic,strong)UIButton *addContactBtn;

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
    recipientLabel.textColor =YDRGB(111, 111, 111);
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
    scopyForLabel.textColor =YDRGB(111, 111, 111);
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
    hedgecopyForLabel.textColor =YDRGB(111, 111, 111);
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
    themeTetxLabel.text = @"主题:";
    themeTetxLabel.font = YDFont(12);
    themeTetxLabel.textAlignment = NSTextAlignmentRight;
    themeTetxLabel.textColor =YDRGB(111, 111, 111);
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
    
    [self.writeLetterScroller addSubview:self.addContactBtn];
    [self.addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.writeLetterScroller.mas_left).with.offset(self.view.width-10);
        make.top.equalTo(self.writeLetterScroller.mas_top).with.offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
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
  
        [_hedgecopyForTextField setValue:[UIColor darkGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
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
        [_emailText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        _emailText.autocorrectionType = UITextAutocorrectionTypeNo;
        _emailText.delegate =self;
//         NSNumber *textfont = TEXTFONT;
        
        _emailText.font = YDFont([TEXTFONT floatValue]);
        
        _emailText.textColor = YDRGB(0, 0, 0);
        _emailText.backgroundColor = [UIColor clearColor];
        _emailText.keyboardType =UIKeyboardTypeDefault;
        _emailText.keyboardType =UIKeyboardTypeDefault;
        _emailText.scrollEnabled = YES;
        _emailText.returnKeyType = UIReturnKeyDefault;
        
    }
    return _emailText;
}

- (UIButton *)addContactBtn
{
    if (!_addContactBtn) {
        _addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addContactBtn setImage:[UIImage imageNamed:@"addContact.png"] forState:UIControlStateNormal];
        [_addContactBtn addTarget:self action:@selector(addContactAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addContactBtn;
    
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([textView isEqual:  self.recipientTextField] ||   [textView isEqual: self.scopyForTetxField ]||  [textView isEqual: self.hedgecopyForTextField]  ) {
        if ([text isEqualToString:@"\n"]){
            
            if ([textView.text rangeOfString:@"、"].location != NSNotFound) {
                NSRange range = [textView.text rangeOfString:@"、" options:NSBackwardsSearch];
                if (range.length > 0) {
                    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[textView.text  stringByAppendingString:@"、"]];
                    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, textView.text.length + 1  )];
                    [attribute addAttribute:NSFontAttributeName value:YDFont(15) range:NSMakeRange(0, textView.text.length + 1  )];
                    
                    
                    textView.attributedText = attribute;
                }
                
                
                return NO;
                
            }else{
                NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[textView.text stringByAppendingString:@"、"]];
                [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, textView.text.length  + 1)];
                [attribute addAttribute:NSFontAttributeName value:YDFont(15) range:NSMakeRange(0, textView.text.length + 1  )];
                textView.attributedText = attribute;
                return NO;
                
                
            }
        }
        
        if ([text isEqualToString:@""]) {
            if([textView.text hasSuffix:@"、"]){
                NSMutableArray * separator =  [self getRangeStr:textView.text findText:@"、"];
                if (separator.count <= 1) {
                    textView.text = @"";
                }else{
                    
                    NSNumber *sepnumber =separator[separator.count - 2];
                    NSString *textString =  [textView.text substringToIndex:[sepnumber intValue] ];
                    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[textString stringByAppendingString:@"、"]];
                    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, textString.length+1)];
                    [attribute addAttribute:NSFontAttributeName value:YDFont(15) range:NSMakeRange(0, textString.length +1 )];
                    textView.attributedText = attribute;
                    return NO;
                }
    
            }
            
            
        }
        
        
    }
    
 
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
    [self.view endEditing:YES];
    


    if ([self validateInput]) {
        _addContactBtn.userInteractionEnabled = NO;

        [self enmaiSaveRequestWithDictionary:nil];

    }
    
}

- (void)addContactAction:(id)sender
{
    [self.view endEditing:YES];
    
}

-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

- (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    
    if (findText == nil && [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {
                
                //去掉这个abc字符串
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else//添加符合条件的location进数组
                
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
            
        }
        
        return arrayRanges;
        
    }
    
    return nil;
    
}


- (BOOL)validateInput
{
    if ([YDValidate isEmpty:_recipientTextField.text])
    {
        
        [YDTools HUDTextOnly:@"请输入收件人" toView:YDWindow];
        [_recipientTextField becomeFirstResponder];
        return NO;
    }else if([YDValidate isEmpty:_themeTetxField.text]){
        [YDTools HUDTextOnly:@"请输入的主题" toView:YDWindow];
        [_themeTetxField becomeFirstResponder];
        return NO;
    }else if([YDValidate isEmpty:_emailText.text]){
        [YDTools HUDTextOnly:@"请输入的内容" toView:YDWindow];
        [_emailText becomeFirstResponder];
        return NO;
    }

    return YES;

}

- (void)enmaiSaveRequestWithDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:@"POST" requestURL:YDEmailSavetUrl parameters:dictionary success:^(id responseObj) {
        NSString * status = responseObj[@"result"];
        
        if ([status isEqualToString:@"success"]) {
            
            [self.hud hideAnimated:YES];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                    [self analyseData:responseObj];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
         
                });
            });
            
        }else {
            [YDTools loadFailedHUD:self.hud text:status ];
            
        }
        
        
        
    } failure:^(NSError *error) {
        [YDTools loadFailedHUD:self.hud text:YDRequestFailureNote ];
    }];
    _addContactBtn.userInteractionEnabled = YES;
    
    
}

@end
