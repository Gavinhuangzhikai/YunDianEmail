//
//  YDUserDataManager.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/17.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDUserDataManager : NSObject
/**
 *  @brief  存储手势密码
 *
 *  @param  password    密码内容
 */
+(void)savePassWord:(NSString *)password;

/**
 *  @brief  读取密码
 *
 *  @return 密码内容
 */
+(id)readPassWord;

/**
 *  @brief  删除密码数据
 */
+(void)deletePassWord;
/**
 *  @brief  存储用户数据信息
 *
 *  @param  userData    用户信息内容
 */
+(void)saveUserData:(id)userData;
/**
 *  @brief  读取用户数据信息
 *
 *  @return 用户信息内容
 */
+(id)readUserData;

/**
 *  @brief  删除用户信息内容
 */
+(void)deleteUserData;

/**
 *  @brief  存储用户账号信息
 *
 *  @param  userID    用户账号信息
 */
+(void)saveUserID:(id)userID;
/**
 *  @brief  读取用户账号信息
 *
 *  @return 用户账号信息
 */
+(id)readUserID;

/**
 *  @brief  删除用户信息内容
 */
+(void)deleteUserID;


/**
 *  @brief  存储首页缓存信息
 *
 *  @param  homeData  首页缓存数据
 */
+(void)saveHomeData:(id)homeData;
/**
 *  @brief  读取首页缓存信息
 *
 *  @return 首页缓存数据
 */
+(id)readHomeData;




@end
