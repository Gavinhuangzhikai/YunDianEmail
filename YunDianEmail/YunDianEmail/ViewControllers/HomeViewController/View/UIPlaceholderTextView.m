
//
//  UIPlaceholderTextView.m
//  Finance
//
//  Created by hzk on 16/4/20.
//  Copyright © 2016年 hzk. All rights reserved.
//

#import "UIPlaceholderTextView.h"

@implementation UIPlaceholderTextView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addObserver];
}

#pragma MARK 注册通知
- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

#pragma MARK 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma MARK 开始编辑
- (void)textDidBeginEditing:(NSNotification *)notification
{
    if ([super.text isEqualToString:_placeholder]) {
        super.text = @"";
        [super setTextColor:YDRGB(0, 0, 0)];
    }
}

#pragma MARK 结束编辑
- (void)textDidEndEditing:(NSNotification *)notification
{
    if (super.text.length ==0) {
        super.text = _placeholder;
        [super setTextColor:YDRGB(190, 190, 190)];
    }
}

#pragma MARK 重写setplaceholder方法
- (void)setPlaceholder:(NSString *)aplaceholder
{
    _placeholder =aplaceholder;
    [self textDidEndEditing:nil];
    
}

#pragma MARK 重写gettext方法
- (NSString *)text
{
    NSString *text = [super text];
    if ([text isEqualToString:_placeholder]) {
        return @"";
    }
    return text;
}


@end
