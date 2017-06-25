//
//  LMWordView.m
//  SimpleWord
//
//  Created by Chenly on 16/5/12.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "LMWordView.h"
#import <objc/runtime.h>

@implementation LMWordView {

    CGRect _frameCache;
}

static CGFloat const kLMWCommonSpacing = 5.f;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.spellCheckingType = UITextSpellCheckingTypeNo;    
    self.alwaysBounceVertical = YES;
    self.textContainerInset = UIEdgeInsetsMake(kLMWCommonSpacing,
                                               kLMWCommonSpacing,
                                               kLMWCommonSpacing,
                                               kLMWCommonSpacing);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGRectEqualToRect(_frameCache, self.frame)) {
        
        _frameCache = self.frame;
    }
}

@end
