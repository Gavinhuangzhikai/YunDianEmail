//
//  YDTools.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface YDTools : NSObject

#pragma mark - 字符相关方法
+ (NSString *)getUrlPathWithHttp:(NSString *)http andURL:(NSString *)URL; // 拼接接口地址
+ (NSString *)stringTrimWhitespace:(NSString *)str; // 字符串去空格

#pragma mark - 长度宽度相关方法
+ (CGSize)getLabelSize:(NSString *)str withFontSize:(CGFloat)fontsize andHeight: (CGFloat)height; //uilabel根据高度和字体大小计算长度

+ (CGSize)getLabelSize:(NSString *)str withFontSize:(CGFloat)fontsize andWigth: (CGFloat)wigth;  //uilabel根据长度和字体大小计算高度

#pragma mark -- 指示器相关方法
+ (MBProgressHUD *)HUDTextOnly:(NSString *)text toView:(UIView *)view;// 纯文字提示
+ (MBProgressHUD *)HUDLoadingOnView:(UIView *)view delegate:(id)delegate; // 纯加载提示
+ (void)loadFailedHUD:(MBProgressHUD *)hud text:(NSString *)text ;

#pragma mark - 两种不同颜色的字符串
+(NSMutableAttributedString*)getString:(NSString*)str  WithFontSize:(CGFloat)fontSize WithTextColer:(UIColor *)color  otherTextColer:(UIColor *)othercolor WithRange:(NSRange)strRange;

#pragma mark - 加密相关方法
// 方法功能：md5 加密
+ (NSString *)md5:(NSString *)str;

#pragma mark -  获取时间相关方法
+ (NSString *)getTimeStamp;

#pragma mark -  颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color sizeWithWidth:(CGFloat)width  sizeWithWidthHeight:(CGFloat)height;


@end
