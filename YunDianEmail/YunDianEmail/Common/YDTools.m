

//
//  YDTools.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDTools.h"
#import <CommonCrypto/CommonDigest.h>
@implementation YDTools
#pragma mark - 字符相关方法

// 拼接接口地址
+ (NSString *)getUrlPathWithHttp:(NSString *)http andURL:(NSString *)URL
{
    NSString *httpUrl = [NSString stringWithFormat:@"%@%@",http,URL];
    return httpUrl;
}

// 字符串去空格
+ (NSString *)stringTrimWhitespace:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 长度宽度相关方法
+ (CGSize)getLabelSize:(NSString *)str withFontSize:(CGFloat)fontsize andHeight: (CGFloat)height
{
    NSDictionary *attribute = @{NSFontAttributeName :[UIFont systemFontOfSize:fontsize]};
    
    return [str boundingRectWithSize:CGSizeMake(YDScreenWidth, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
}

+ (CGSize)getLabelSize:(NSString *)str withFontSize:(CGFloat)fontsize andWigth: (CGFloat)wigth
{
    NSDictionary *attribute = @{NSFontAttributeName :[UIFont fontWithName:@"Arial" size:fontsize]};
    CGSize size = CGSizeMake(wigth, 20000.0f);
    return  [str  boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
             NSStringDrawingUsesLineFragmentOrigin |
             NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
}

#pragma mark -- 指示器相关方法
+ (MBProgressHUD *)HUDTextOnly:(NSString *)text toView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.font = [UIFont systemFontOfSize:15.0f];
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0f];
    return hud;
}

+ (MBProgressHUD *)HUDLoadingOnView:(UIView *)view delegate:(id)delegate
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    [hud showAnimated:YES];
    [hud setDelegate:delegate];
    return hud;
}

+ (void)loadFailedHUD:(MBProgressHUD *)hud text:(NSString *)text
{
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_hud_error"]];
    hud.label.text = text;
    hud.label.font = [UIFont systemFontOfSize:13.0f];
    [hud hideAnimated:YES afterDelay:2.0f];
}

#pragma mark - 两种不同颜色的字符串
+(NSMutableAttributedString*)getString:(NSString*)str  WithFontSize:(CGFloat)fontSize WithTextColer:(UIColor *)color  otherTextColer:(UIColor *)othercolor WithRange:(NSRange)strRange
{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str];
    
    if (!othercolor) {
        return attriString;
    }
    [attriString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,strRange.location)];
    [attriString addAttribute:NSForegroundColorAttributeName value:othercolor range:strRange];
    [attriString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(strRange.location+strRange.length,str.length-strRange.length-strRange.location)];
    [attriString addAttribute:NSFontAttributeName value:YDFont(fontSize) range:NSMakeRange(0, str.length)];
    return attriString;
}

#pragma mark - 加密相关方法
// 方法功能：md5 加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


#pragma mark -  获取时间相关方法
+ (NSString *)getTimeStamp
{
    NSDate *datenow = [NSDate date];
    NSString *timeSP = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    return timeSP;
}

+ (UIImage *)imageWithColor:(UIColor *)color sizeWithWidth:(CGFloat)width  sizeWithWidthHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
