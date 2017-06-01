//
//  YDValidate.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDValidate : NSObject
#pragma mark 判断是否为合法手机号
+(BOOL)isValidateMobileNumber:(NSString *)number;
#pragma mark 判断是否为数字加字母的组合
+(BOOL)isValidateNumberAndLetter:(NSString *)string;
#pragma mark - 判断是否是合法身份证号
+ (BOOL)is18PaperId:(NSString *)sPaperId;
#pragma mark - 判断输入是否为空
+ (BOOL)isEmpty:(NSString *)value;
#pragma mark - 判断密码长度是否合法
+ (BOOL)isLegalPassword:(NSString *)pwd;
#pragma mark - 判断是否全是汉字
+ (BOOL)isAllChinese:(NSString *)content;
#pragma mark - 判断是否是银行卡
+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;
@end
