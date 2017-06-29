//
//  YDWriteLetterViewController.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDWriteLetterViewController.h"
#import "YDContactsViewController.h"
#import "LMWordView.h"
#import "LMSegmentedControl.h"
#import "LMStyleSettingsController.h"
#import "LMImageSettingsController.h"
#import "LMParagraphConfig.h"
#import "LMTextStyle.h"
#import "UIFont+LMText.h"
#import "NSTextAttachment+LMText.h"
#import "LMTextHTMLParser.h"

@interface YDWriteLetterViewController ()<UITextFieldDelegate,UITextViewDelegate, LMSegmentedControlDelegate, LMStyleSettingsControllerDelegate, LMImageSettingsControllerDelegate,UIScrollViewDelegate>
{
    NSRange _lastSelectedRange;
    BOOL _keepCurrentTextStyle;
}

@property (nonatomic,strong)UIScrollView *writeLetterScroller;

@property (nonatomic,strong)UITextView *recipientTextField;

@property (nonatomic,strong)UITextView *scopyForTetxField;

@property (nonatomic,strong)UITextView *hedgecopyForTextField;

@property (nonatomic,strong)UITextView *themeTetxField;

@property (nonatomic,strong)UITextView *emailText;

@property (nonatomic,strong)UIButton *addContactBtn;

@property (nonatomic,strong)UIButton *addScopyContactBtn;


@property (nonatomic,strong)UIButton *addHedgecopyContactBtn;


@property (nonatomic, strong) LMWordView *textView;

@property (nonatomic, strong) LMSegmentedControl *contentInputAccessoryView;

@property (nonatomic, strong) LMTextStyle *currentTextStyle;
@property (nonatomic, strong) LMParagraphConfig *currentParagraphConfig;

@property (nonatomic, strong) LMStyleSettingsController *styleSettingsViewController;
@property (nonatomic, strong) LMImageSettingsController *imageSettingsViewController;

@property (nonatomic, readonly) UIStoryboard *lm_storyboard;

@property (nonatomic, assign) CGFloat keyboardSpacingHeight;

@end

@implementation YDWriteLetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];


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
    
    self.title = @"写信";
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        make.top.equalTo(self.writeLetterScroller.mas_top).with.offset(8);
        make.height.equalTo(@30);
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
        make.top.equalTo(lineImage.mas_bottom).with.offset(8);
        make.height.equalTo(@30);
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
        make.top.equalTo(lineTWOImage.mas_bottom).with.offset(8);
        make.height.equalTo(@30);
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
        make.top.equalTo(lineTHREEImage.mas_bottom).with.offset(8);
        make.height.equalTo(@30);
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
    
    
    [self.writeLetterScroller addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.writeLetterScroller.mas_right).with.offset(10);
        make.top.equalTo(lineFOURImage.mas_bottom).with.offset(5);
        make.width.mas_equalTo(self.view.width -20);;
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
//    [self.writeLetterScroller addSubview:self.emailText];
//    [self.emailText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.writeLetterScroller.mas_right).with.offset(10);
//        make.top.equalTo(lineFOURImage.mas_bottom).with.offset(5);
//        make.width.mas_equalTo(self.view.width -20);;
//        make.height.greaterThanOrEqualTo(@200);
//    }];
    
    [self.writeLetterScroller addSubview:self.addContactBtn];
    [self.addContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.writeLetterScroller.mas_left).with.offset(self.view.width-10);
        make.centerY.equalTo(recipientLabel.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.writeLetterScroller addSubview:self.addScopyContactBtn];
    [self.addScopyContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.writeLetterScroller.mas_left).with.offset(self.view.width-10);
        make.centerY.equalTo(scopyForLabel.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.writeLetterScroller addSubview:self.addHedgecopyContactBtn];
    [self.addHedgecopyContactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.writeLetterScroller.mas_left).with.offset(self.view.width-10);
        make.centerY.equalTo(hedgecopyForLabel.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    
    NSArray *items = @[
                       [UIImage imageNamed:@"ABC_icon"],
                       [UIImage imageNamed:@"style_icon"],
                       [UIImage imageNamed:@"img_icon"],
                       [UIImage imageNamed:@"clear_icon"]
                       ];
    _contentInputAccessoryView = [[LMSegmentedControl alloc] initWithItems:items];
    _contentInputAccessoryView.delegate = self;
    _contentInputAccessoryView.changeSegmentManually = YES;

    
    [self setCurrentParagraphConfig:[[LMParagraphConfig alloc] init]];
    [self setCurrentTextStyle:[LMTextStyle textStyleWithType:LMTextStyleFormatNormal]];
    [self updateParagraphTypingAttributes];
    [self updateTextStyleTypingAttributes];

    [_contentInputAccessoryView addTarget:self action:@selector(changeTextInputView:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    [self layoutTextView];
//    
    CGRect rect = self.view.bounds;
    rect.size.height = 40.f;
    self.contentInputAccessoryView.frame = rect;
}

- (void)layoutTextView {
//    CGRect rect = self.view.bounds;
//    rect.origin.y = [self.topLayoutGuide length];
//    rect.size.height -= rect.origin.y;
//    self.textView.frame = rect;
    
    
    UIEdgeInsets insets = self.textView.contentInset;
    insets.bottom = self.keyboardSpacingHeight;
    self.textView.contentInset = insets;
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
//        _recipientTextField.contentInset = UIEdgeInsetsMake(5.0f, 0.0f, 0.0f, 0.0f);
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
//
//- (UITextView *)emailText
//{
//    if (!_emailText) {
//        _emailText = [[UITextView alloc] init];
//        [_emailText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//        _emailText.autocorrectionType = UITextAutocorrectionTypeNo;
//        _emailText.delegate =self;
////         NSNumber *textfont = TEXTFONT;
//        
//        _emailText.font = YDFont([TEXTFONT floatValue]);
//        
//        _emailText.textColor = YDRGB(0, 0, 0);
//        _emailText.backgroundColor = [UIColor clearColor];
//        _emailText.keyboardType =UIKeyboardTypeDefault;
//        _emailText.keyboardType =UIKeyboardTypeDefault;
//        _emailText.scrollEnabled = YES;
//        _emailText.returnKeyType = UIReturnKeyDefault;
//        
//    }
//    return _emailText;
//}

- (LMWordView *)textView
{
    if (!_textView) {
        _textView = [[LMWordView alloc] init];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor whiteColor];
    }
    return _textView;
}

- (UIButton *)addContactBtn
{
    if (!_addContactBtn) {
        _addContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addContactBtn setImage:[UIImage imageNamed:@"addContact.png"] forState:UIControlStateNormal];
        _addContactBtn.tag = 100;
        [_addContactBtn addTarget:self action:@selector(addContactAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addContactBtn;
}

- (UIButton *)addScopyContactBtn
{
    if (!_addScopyContactBtn) {
        _addScopyContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addScopyContactBtn setImage:[UIImage imageNamed:@"addContact.png"] forState:UIControlStateNormal];
        _addScopyContactBtn.tag = 101;
        [_addScopyContactBtn addTarget:self action:@selector(addContactAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addScopyContactBtn;
    
    
}


- (UIButton *)addHedgecopyContactBtn
{
    if (!_addHedgecopyContactBtn) {
        _addHedgecopyContactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addHedgecopyContactBtn setImage:[UIImage imageNamed:@"addContact.png"] forState:UIControlStateNormal];
        _addHedgecopyContactBtn.tag =102;
        [_addHedgecopyContactBtn addTarget:self action:@selector(addContactAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addHedgecopyContactBtn;
    
    
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if ([self.textView isFirstResponder]) {
        [self.writeLetterScroller setContentOffset:CGPointMake(0, 100) animated:YES];

        
        NSDictionary *info = [notification userInfo];
        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        if (self.keyboardSpacingHeight == keyboardSize.height) {
            return;
        }
        self.keyboardSpacingHeight = keyboardSize.height;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self layoutTextView];
        } completion:nil];
        return;
    }
    [self.writeLetterScroller setContentOffset:CGPointMake(0, 0) animated:YES];

  
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self.writeLetterScroller setContentOffset:CGPointMake(0, 0) animated:YES];
    if ([self.textView isFirstResponder]) {
   
    if (self.keyboardSpacingHeight == 0) {
        return;
    }
    self.keyboardSpacingHeight = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self layoutTextView];
    } completion:nil];
        return;
    }
    
}

#pragma mark - <UITextViewDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark - <UITextViewDelegate>

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if ([textView isEqual:self.textView]) {
        [self.contentInputAccessoryView setSelectedSegmentIndex:0 animated:NO];
        _textView.inputAccessoryView = self.contentInputAccessoryView;
        [self.imageSettingsViewController reload];
        return YES;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
      if ([textView isEqual:self.textView]) {
    _textView.inputAccessoryView = nil;
      }
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([textView isEqual:self.textView]) {
        if (_lastSelectedRange.location != textView.selectedRange.location) {
            
            if (_keepCurrentTextStyle) {
                // 如果当前行的内容为空，TextView 会自动使用上一行的 typingAttributes，所以在删除内容时，保持 typingAttributes 不变
                [self updateTextStyleTypingAttributes];
                [self updateParagraphTypingAttributes];
                _keepCurrentTextStyle = NO;
            }
            else {
                self.currentTextStyle = [self textStyleForSelection];
                self.currentParagraphConfig = [self paragraphForSelection];
                [self updateTextStyleTypingAttributes];
                [self updateParagraphTypingAttributes];
                [self reloadSettingsView];
            }
        }
        _lastSelectedRange = textView.selectedRange;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([textView isEqual:  self.recipientTextField] ||   [textView isEqual: self.scopyForTetxField ]||  [textView isEqual: self.hedgecopyForTextField]  ) {
   
        float height = [self heightForTextView:textView WithText:[NSString stringWithFormat:@"%@%@",textView.text,text]];

        [UIView animateWithDuration:0.5 animations:^{
            [textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
        } completion:nil];

        if ([text isEqualToString:@"\n"]){
            if ([textView.text rangeOfString:@"、"].location != NSNotFound) {
                NSRange range = [textView.text rangeOfString:@"、" options:NSBackwardsSearch];
                if (range.length > 0) {
                    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[textView.text  stringByAppendingString:@"、"]];
                    [attribute addAttribute:NSForegroundColorAttributeName value:YDRGB(0, 0, 0) range:NSMakeRange(0, textView.text.length + 1  )];
                    [attribute addAttribute:NSFontAttributeName value:YDFont(15) range:NSMakeRange(0, textView.text.length + 1  )];
                    textView.attributedText = attribute;
                }}else{
                NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[textView.text stringByAppendingString:@"、"]];
                [attribute addAttribute:NSForegroundColorAttributeName value:YDRGB(0, 0, 0) range:NSMakeRange(0, textView.text.length  + 1)];
                [attribute addAttribute:NSFontAttributeName value:YDFont(15) range:NSMakeRange(0, textView.text.length + 1  )];
                textView.attributedText = attribute;
            }
         return NO;
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
                
                }
                [self textViewDidChange:textView];
                return NO;
            }
        }
    }
    
    if ([textView isEqual:self.textView]) {
        if (range.location == 0 && range.length == 0 && text.length == 0) {
            // 光标在第一个位置时，按下退格键，则删除段落设置
            self.currentParagraphConfig.indentLevel = 0;
            [self updateParagraphTypingAttributes];
        }
        _lastSelectedRange = NSMakeRange(range.location + text.length - range.length, 0);
        if (text.length == 0 && range.length > 0) {
            _keepCurrentTextStyle = YES;
        }

    }
    
 
    return YES;
}




//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([textView isEqual:  self.recipientTextField] ||   [textView isEqual: self.scopyForTetxField ]||  [textView isEqual: self.hedgecopyForTextField]  ) {
//        if ([text isEqualToString:@"\n"]){
//            
//            if ([textView.text rangeOfString:@"</strong>"].location != NSNotFound) {
//                NSRange range = [textView.text rangeOfString:@"</strong>" options:NSBackwardsSearch];
//                if (range.length > 0) {
//                    NSString *strHTML =[NSString stringWithFormat:@"%@<strong>%@</strong>  ",[textView.text substringToIndex:range.location],[textView.text substringFromIndex:(range.location+ range.length)] ];
//                    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[strHTML dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//                    textView.attributedText = attributedString;
//                }
//                return NO;
//                
//            }else{
//                NSString *strHTML =[NSString stringWithFormat:@"<strong>%@</strong>  ",textView.text];
//                NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[strHTML dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//                textView.attributedText = attributedString;
//
//                
////                NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[textView.text stringByAppendingString:@"、"]];
////                [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, textView.text.length  + 1)];
////                [attribute addAttribute:NSFontAttributeName value:YDFont(15) range:NSMakeRange(0, textView.text.length + 1  )];
////                textView.attributedText = attribute;
//                return NO;
//                
//                
//            }
//        }
//        
//        if ([text isEqualToString:@""]) {
//            if([textView.text hasSuffix:@"</strong>"]){
//                
//                  NSRange range = [textView.text rangeOfString:@"<strong>" options:NSBackwardsSearch];
//              
//                NSString *strHTML =[NSString stringWithFormat:@"%@  ",[textView.text substringToIndex:range.location]];
//                NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[strHTML dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//                textView.attributedText = attributedString;
//                
//                
//                
////                NSMutableArray * separator =  [self getRangeStr:textView.text findText:@"、"];
////                if (separator.count <= 1) {
////                    textView.text = @"";
////                }else{
////                    
////                    NSNumber *sepnumber =separator[separator.count - 2];
////                    NSString *textString =  [textView.text substringToIndex:[sepnumber intValue] ];
////                    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[textString stringByAppendingString:@"、"]];
////                    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, textString.length+1)];
////                    [attribute addAttribute:NSFontAttributeName value:YDFont(15) range:NSMakeRange(0, textString.length +1 )];
////                    textView.attributedText = attribute;
////                    return NO;
////                }
//                
//            }
//            
//            
//        }
//        
//        
//    }
//    
//    
//    return YES;
//}





-(void)textViewDidChange:(UITextView *)textView{
    
//    if ([textView isEqual:self.emailText]) {
//        
//    }else {
//      
//        
//        CGRect frame = textView.frame;
//        CGSize constraintSize = CGSizeMake(frame.size.width -1, MAXFLOAT);
//        CGSize size = [textView sizeThatFits:constraintSize];
//        NSLog(@"%f",size.height);
//        if (size.height<= 30.0) {
//            size.height=30.0;
//        }else{
//            
//            [textView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(size.height);
//            }];
//        }
//    }
}

- (void)sendEmailAction:(id)sender
{
    [self.view endEditing:YES];
    
   

    if ([self validateInput]) {
         self.hud = [YDTools HUDLoadingOnView:self.view delegate:self];
        _addContactBtn.userInteractionEnabled = NO;
        
        NSArray *formmail = [ self.recipientTextField.text componentsSeparatedByString:@"、"];
        NSArray *ccmail = [ self.scopyForTetxField.text componentsSeparatedByString:@"、"];
        NSArray *bccmail = [ self.hedgecopyForTextField.text componentsSeparatedByString:@"、"];
        
        NSDictionary *dataDic = @{@"formmail":formmail,@"ccmail":ccmail,@"bccmail":bccmail,@"subject":self.themeTetxField.text,@"bodyText":[self exportHTML]};
       [self enmaiSaveRequestWithDictionary:dataDic];

    }
    
}

- (void)addContactAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
    YDContactsViewController *contactsVtr = [[YDContactsViewController alloc] init];
    contactsVtr.contactsType =  YUDIANContactsFromTYPEIsWritter;
    __weak __typeof__(self) weakSelf = self;
    contactsVtr.addContacts = ^(NSString *contactsName) {
        
        if (button.tag == 100) {
       [weakSelf.recipientTextField insertText:[NSString stringWithFormat:@"%@、",contactsName]];
                                                
//                                                stringByAppendingString:[NSString stringWithFormat:@"%@、",contactsName]];
        }else if (button.tag == 101){
         [weakSelf.recipientTextField insertText:[NSString stringWithFormat:@"%@、",contactsName]];
        }else if (button.tag == 102){
        [weakSelf.recipientTextField insertText:[NSString stringWithFormat:@"%@、",contactsName]];
            
        }

    };
    [self.navigationController  pushViewController:contactsVtr animated:YES];
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
        [YDTools HUDTextOnly:@"请输入主题" toView:YDWindow];
        [_themeTetxField becomeFirstResponder];
        return NO;
    }else if([YDValidate isEmpty:_textView.text]){
        [YDTools HUDTextOnly:@"请输入的内容" toView:YDWindow];
        [_textView becomeFirstResponder];
        return NO;
    }

    return YES;

}

- (void)enmaiSaveRequestWithDictionary:(NSDictionary *)dictionary
{
    [YDHttpRequest currentRequestType:@"POST" requestURL:YDEmailSavetUrl parameters:dictionary success:^(id responseObj) {
        NSString * status = responseObj[@"result"];

        if ([status isEqualToString:@"ok"]) {
            
             [YDTools loadFailedHUD:self.hud text:@"发送成功" ];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                    [self analyseData:responseObj];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.refrushData) {
                        self.refrushData();
                    }
                 
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
               
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

#pragma mark - Change InputView

- (void)lm_segmentedControl:(LMSegmentedControl *)control didTapAtIndex:(NSInteger)index {
    
    if (index == control.numberOfSegments - 1) {
        [self.textView resignFirstResponder];
        return;
    }
    if (index != control.selectedSegmentIndex) {
        [control setSelectedSegmentIndex:index animated:YES];
    }
}

- (UIStoryboard *)lm_storyboard {
    static dispatch_once_t onceToken;
    static UIStoryboard *storyboard;
    dispatch_once(&onceToken, ^{
        storyboard = [UIStoryboard storyboardWithName:@"LMWord" bundle:nil];
    });
    return storyboard;
}

- (LMStyleSettingsController *)styleSettingsViewController {
    if (!_styleSettingsViewController) {
        _styleSettingsViewController = [self.lm_storyboard instantiateViewControllerWithIdentifier:@"style"];
        _styleSettingsViewController.textStyle = self.currentTextStyle;
        _styleSettingsViewController.delegate = self;
    }
    return _styleSettingsViewController;
}

- (LMImageSettingsController *)imageSettingsViewController {
    if (!_imageSettingsViewController) {
        _imageSettingsViewController = [self.lm_storyboard instantiateViewControllerWithIdentifier:@"image"];
        _imageSettingsViewController.delegate = self;
    }
    return _imageSettingsViewController;
}

- (void)changeTextInputView:(LMSegmentedControl *)control {
    
    CGRect rect = self.view.bounds;
    rect.size.height = self.keyboardSpacingHeight - CGRectGetHeight(self.contentInputAccessoryView.frame);
    switch (control.selectedSegmentIndex) {
        case 1:
        {
            UIView *inputView = [[UIView alloc] initWithFrame:rect];
            self.styleSettingsViewController.view.frame = rect;
            [inputView addSubview:self.styleSettingsViewController.view];
            self.textView.inputView = inputView;
            break;
        }
        case 2:
        {
            UIView *inputView = [[UIView alloc] initWithFrame:rect];
            self.imageSettingsViewController.view.frame = rect;
            [inputView addSubview:self.imageSettingsViewController.view];
            self.textView.inputView = inputView;
            break;
        }
        default:
            self.textView.inputView = nil;
            break;
    }
    [self.textView reloadInputViews];
}

#pragma mark - settings

// 刷新设置界面
- (void)reloadSettingsView {
    
    self.styleSettingsViewController.textStyle = self.currentTextStyle;
    [self.styleSettingsViewController setParagraphConfig:self.currentParagraphConfig];
    [self.styleSettingsViewController reload];
}

- (LMTextStyle *)textStyleForSelection {
    
    LMTextStyle *textStyle = [[LMTextStyle alloc] init];
    UIFont *font = self.textView.typingAttributes[NSFontAttributeName];
    textStyle.bold = font.bold;
    textStyle.italic = font.italic;
    textStyle.fontSize = font.fontSize;
    textStyle.textColor = self.textView.typingAttributes[NSForegroundColorAttributeName] ?: textStyle.textColor;
    if (self.textView.typingAttributes[NSUnderlineStyleAttributeName]) {
        textStyle.underline = [self.textView.typingAttributes[NSUnderlineStyleAttributeName] integerValue] == NSUnderlineStyleSingle;
    }
    return textStyle;
}

- (LMParagraphConfig *)paragraphForSelection {
    
    NSParagraphStyle *paragraphStyle = self.textView.typingAttributes[NSParagraphStyleAttributeName];
    LMParagraphType type = [self.textView.typingAttributes[LMParagraphTypeName] integerValue];
    LMParagraphConfig *paragraphConfig = [[LMParagraphConfig alloc] initWithParagraphStyle:paragraphStyle type:type];
    return paragraphConfig;
}

// 获取所有选中的段落，通过"\n"来判断段落。
- (NSArray *)rangesOfParagraphForCurrentSelection {
    
    NSRange selection = self.textView.selectedRange;
    NSInteger location;
    NSInteger length;
    
    NSInteger start = 0;
    NSInteger end = selection.location;
    NSRange range = [self.textView.text rangeOfString:@"\n"
                                              options:NSBackwardsSearch
                                                range:NSMakeRange(start, end - start)];
    location = (range.location != NSNotFound) ? range.location + 1 : 0;
    
    start = selection.location + selection.length;
    end = self.textView.text.length;
    range = [self.textView.text rangeOfString:@"\n"
                                      options:0
                                        range:NSMakeRange(start, end - start)];
    length = (range.location != NSNotFound) ? (range.location + 1 - location) : (self.textView.text.length - location);
    
    range = NSMakeRange(location, length);
    NSString *textInRange = [self.textView.text substringWithRange:range];
    NSArray *components = [textInRange componentsSeparatedByString:@"\n"];
    
    NSMutableArray *ranges = [NSMutableArray array];
    for (NSInteger i = 0; i < components.count; i++) {
        NSString *component = components[i];
        if (i == components.count - 1) {
            if (component.length == 0) {
                break;
            }
            else {
                [ranges addObject:[NSValue valueWithRange:NSMakeRange(location, component.length)]];
            }
        }
        else {
            [ranges addObject:[NSValue valueWithRange:NSMakeRange(location, component.length + 1)]];
            location += component.length + 1;
        }
    }
    if (ranges.count == 0) {
        return nil;
    }
    return ranges;
}

- (void)updateTextStyleTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
    typingAttributes[NSFontAttributeName] = self.currentTextStyle.font;
    typingAttributes[NSForegroundColorAttributeName] = self.currentTextStyle.textColor;
    typingAttributes[NSUnderlineStyleAttributeName] = @(self.currentTextStyle.underline ? NSUnderlineStyleSingle : NSUnderlineStyleNone);
    self.textView.typingAttributes = typingAttributes;
}

- (void)updateParagraphTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
    typingAttributes[LMParagraphTypeName] = @(self.currentParagraphConfig.type);
    typingAttributes[NSParagraphStyleAttributeName] = self.currentParagraphConfig.paragraphStyle;
    self.textView.typingAttributes = typingAttributes;
}

- (void)updateTextStyleForSelection {
    if (self.textView.selectedRange.length > 0) {
        [self.textView.textStorage addAttributes:self.textView.typingAttributes range:self.textView.selectedRange];
    }
}

- (void)updateParagraphForSelectionWithKey:(NSString *)key {
    NSRange selectedRange = self.textView.selectedRange;
    NSArray *ranges = [self rangesOfParagraphForCurrentSelection];
    if (!ranges) {
        if (self.currentParagraphConfig.type == 0) {
            NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
            typingAttributes[NSParagraphStyleAttributeName] = self.currentParagraphConfig.paragraphStyle;
            self.textView.typingAttributes = typingAttributes;
            return;
        }
        ranges = @[[NSValue valueWithRange:NSMakeRange(0, 0)]];
    }
    NSInteger offset = 0;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    for (NSValue *rangeValue in ranges) {
        
        NSRange range = NSMakeRange(rangeValue.rangeValue.location + offset, rangeValue.rangeValue.length);
        LMParagraphType type;
        if ([key isEqualToString:LMParagraphTypeName]) {
            
            type = self.currentParagraphConfig.type;
            if (self.currentParagraphConfig.type == LMParagraphTypeNone) {
                [attributedText deleteCharactersInRange:NSMakeRange(range.location, 1)];
                offset -= 1;
            }
            else {
                NSTextAttachment *textAttachment = [NSTextAttachment checkBoxAttachment];
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
                [attributedString addAttributes:self.textView.typingAttributes range:NSMakeRange(0, 1)];
                [attributedText insertAttributedString:attributedString atIndex:range.location];
                offset += 1;
            }
            //            switch (self.currentParagraphConfig.type) {
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //            }
        }
        else {
            [attributedText addAttribute:NSParagraphStyleAttributeName value:self.currentParagraphConfig.paragraphStyle range:range];
        }
    }
    if (offset > 0) {
        _keepCurrentTextStyle = YES;
        selectedRange = NSMakeRange(selectedRange.location + 1, selectedRange.length + offset - 1);
    }
    self.textView.allowsEditingTextAttributes = YES;
    self.textView.attributedText = attributedText;
    self.textView.allowsEditingTextAttributes = NO;
    self.textView.selectedRange = selectedRange;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}

- (NSTextAttachment *)insertImage:(UIImage *)image {
    // textView 默认会有一些左右边距
    CGFloat width = CGRectGetWidth(self.textView.frame) - (self.textView.textContainerInset.left + self.textView.textContainerInset.right + 12.f);
    NSTextAttachment *textAttachment = [NSTextAttachment attachmentWithImage:image width:width];
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [attributedString insertAttributedString:attachmentString atIndex:0];
    if (_lastSelectedRange.location != 0 &&
        ![[self.textView.text substringWithRange:NSMakeRange(_lastSelectedRange.location - 1, 1)] isEqualToString:@"\n"]) {
        // 上一个字符不为"\n"则图片前添加一个换行 且 不是第一个位置
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    }
    [attributedString addAttributes:self.textView.typingAttributes range:NSMakeRange(0, attributedString.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    paragraphStyle.paragraphSpacingBefore = 8.f;
    paragraphStyle.paragraphSpacing = 8.f;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    [attributedText replaceCharactersInRange:_lastSelectedRange withAttributedString:attributedString];
    self.textView.allowsEditingTextAttributes = YES;
    self.textView.attributedText = attributedText;
    self.textView.allowsEditingTextAttributes = NO;
    
    return textAttachment;
}

#pragma mark - <LMStyleSettingsControllerDelegate>

- (void)lm_didChangedTextStyle:(LMTextStyle *)textStyle {
    
    self.currentTextStyle = textStyle;
    [self updateTextStyleTypingAttributes];
    [self updateTextStyleForSelection];
}

- (void)lm_didChangedParagraphIndentLevel:(NSInteger)level {
    
    self.currentParagraphConfig.indentLevel += level;
    
    NSRange selectedRange = self.textView.selectedRange;
    NSArray *ranges = [self rangesOfParagraphForCurrentSelection];
    if (ranges.count <= 1) {
        [self updateParagraphForSelectionWithKey:LMParagraphIndentName];
    }
    else {
        self.textView.allowsEditingTextAttributes = YES;
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        for (NSValue *rangeValue in ranges) {
            NSRange range = rangeValue.rangeValue;
            self.textView.selectedRange = range;
            LMParagraphConfig *paragraphConfig = [self paragraphForSelection];
            paragraphConfig.indentLevel += level;
            [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphConfig.paragraphStyle range:range];
        }
        self.textView.attributedText = attributedText;
        self.textView.allowsEditingTextAttributes = NO;
        self.textView.selectedRange = selectedRange;
    }
    [self updateParagraphTypingAttributes];
}

- (void)lm_didChangedParagraphType:(NSInteger)type {
    //    self.currentParagraphConfig.type = type;
    //
    //    [self updateParagraphTypingAttributes];
    //    [self updateParagraphForSelectionWithKey:LMParagraphTypeName];
}

#pragma mark - <LMImageSettingsControllerDelegate>

- (void)lm_imageSettingsController:(LMImageSettingsController *)viewController presentPreview:(UIViewController *)previewController {
    [self presentViewController:previewController animated:YES completion:nil];
}

- (void)lm_imageSettingsController:(LMImageSettingsController *)viewController insertImage:(UIImage *)image {
    
    // 降低图片质量用于流畅显示，将原始图片存入到 Document 目录下，将图片文件 URL 与 Attachment 绑定。
    float actualWidth = image.size.width * image.scale;
    float boundsWidth = CGRectGetWidth(self.view.bounds) - 8.f * 2;
    float compressionQuality = boundsWidth / actualWidth;
    if (compressionQuality > 1) {
        compressionQuality = 1;
    }
    NSData *degradedImageData = UIImageJPEGRepresentation(image, compressionQuality);
    UIImage *degradedImage = [UIImage imageWithData:degradedImageData];
    
    NSTextAttachment *attachment = [self insertImage:degradedImage];
    [self.textView resignFirstResponder];
    [self.textView scrollRangeToVisible:_lastSelectedRange];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 实际应用时候可以将存本地的操作改为上传到服务器，URL 也由本地路径改为服务器图片地址。
        NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                    inDomain:NSUserDomainMask
                                                           appropriateForURL:nil
                                                                      create:NO
                                                                       error:nil];
        NSURL *filePath = [documentDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [NSDate date].description]];
        NSData *originImageData = UIImagePNGRepresentation(image);
        
        if ([originImageData writeToFile:filePath.path atomically:YES]) {
            attachment.attachmentType = LMTextAttachmentTypeImage;
            attachment.userInfo = filePath.absoluteString;
        }
    });
}

- (void)lm_imageSettingsController:(LMImageSettingsController *)viewController presentImagePickerView:(UIViewController *)picker {
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - export

- (NSString *)exportHTML {
    

    NSString *content = [LMTextHTMLParser HTMLFromAttributedString:self.textView.attributedText];
    return content;
}

- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    CGSize constraint = CGSizeMake(textView.contentSize.width -2, CGFLOAT_MAX);
     NSNumber *textfont = TEXTFONT;
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:[textfont floatValue]]}
                                        context:nil];
    float textHeight = size.size.height + 10.0;
    return textHeight;
}

@end
