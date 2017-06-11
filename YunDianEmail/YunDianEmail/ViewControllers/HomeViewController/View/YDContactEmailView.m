
//
//  YDContactEmailView.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/11.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDContactEmailView.h"
@interface YDContactEmailView()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UITextView *addAddressText;



@property (nonatomic,strong)UILabel *emailLabel;
@end
@implementation YDContactEmailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatInterface];
    }
    return self;
}

- (void)creatInterface
{
    
    [self addSubview:self.addAddressText];
    
    
}

- (UITextView *)addAddressText
{
    if (!_addAddressText) {
        _addAddressText = [[UITextView alloc] init];
        _addAddressText.textColor = [UIColor blackColor];
        _addAddressText.delegate = self;
        _addAddressText.backgroundColor = [UIColor whiteColor];
        _addAddressText.autocorrectionType = UITextAutocorrectionTypeNo;
        _addAddressText.delegate =self;
        _addAddressText.font = YDFont([TEXTFONT floatValue]);
        _addAddressText.textColor = YDRGB(0, 0, 0);
        _addAddressText.backgroundColor = [UIColor clearColor];
        _addAddressText.keyboardType =UIKeyboardTypeDefault;
        _addAddressText.scrollEnabled = YES;
    }
    return _addAddressText;
}


- (UILabel *)emailLabel
{
    if (!_emailLabel) {
       _emailLabel = [[ UILabel alloc]init];
        _emailLabel.textColor = YDRGB(230, 230, 230);
        _emailLabel.font = YDFont(13);

    }
    return _emailLabel;
}

- (NSMutableArray *)emailAddressArray
{
    if (!_emailAddressArray) {
        _emailAddressArray = [NSMutableArray array];
    }
    return _emailAddressArray;
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    if ([self isValidateEmail:textView.text]) {
        [self.emailAddressArray addObject:textView.text];
    }
}


-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

@end
