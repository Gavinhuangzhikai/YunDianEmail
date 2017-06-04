//
//  ThemeTextView.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "ThemeTextView.h"
#import "ThemeManager.h"

@implementation ThemeTextView

- (void)dealloc {
  
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (id)init {
    self = [super init];
    if (self != nil) {
 
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNofication object:nil];
    }
    return self;
}

- (id)initWithTextFont:(CGFloat)textFont {
    self = [self init];
    if (self != nil) {
        self.textFont = textFont;
    }
    return self;
}

- (void)setTextFont:(CGFloat)textFont
{
    if (_textFont != textFont) {

        _textFont = textFont ;
    }
    
    [self setTextFont];
    
}

- (void)setTextFont {
    CGFloat textfONT = [[ThemeManager shareInstance]getTextWithFont:self.textFont];
    
       self.font = [UIFont systemFontOfSize:textfONT];
}

#pragma mark - NSNotification actions
- (void)themeNotification:(NSNotification *)notification {
    [self setTextFont];
}

@end
