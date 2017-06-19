//
//  YDDes.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/17.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDDes : NSObject
/**
 *  des 解密方法
 *
 *  @param cipherText 加密数据
 *  @param key        加密秘钥
 *
 *  @return 解密字符串
 */
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
/**
 *  des加密方法
 *
 *  @param clearText 待加密数据
 *  @param key        加密秘钥
 *
 *  @return 加密后的字符串
 */
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
@end
