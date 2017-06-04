//
//  ThemeManager.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "ThemeManager.h"
static ThemeManager *sigleton = nil;
@implementation ThemeManager

+ (ThemeManager *)shareInstance {
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[ThemeManager alloc] init];
        }
    }
    return sigleton;
}

- (id)init {
    self = [super init];
    if (self) {
        //读取主题配置文件
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.fontTextPlist = [NSDictionary dictionaryWithContentsOfFile:themePath];
        
        //默认为12
        self.textFont = 12;
    }
    return self;
}

- (CGFloat)getTextWithFont:(CGFloat)textfont{

        return textfont;
    
}

//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}






@end
