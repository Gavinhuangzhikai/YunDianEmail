//
//  ThemeManager.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject
@property(nonatomic,retain)NSDictionary *fontTextPlist;


@property(nonatomic,assign)CGFloat textFont;

+ (ThemeManager *)shareInstance;

- (CGFloat)getTextWithFont:(CGFloat)textfont;
@end
