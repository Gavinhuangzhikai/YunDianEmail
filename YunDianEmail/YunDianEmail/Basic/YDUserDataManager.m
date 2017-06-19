//
//  YDUserDataManager.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/17.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDUserDataManager.h"
#import "YDDes.h"
#define DesKey @"YUDIAN.YDEmail.DESKey"
@implementation YDUserDataManager
static NSString * const KEY_PASSWORD = @"YUDIAN.YDEmail.gesturePassword";
static NSString * const KEY_OpenState = @"YUDIAN.YDEmail.passwordOpenState";
static NSString * const KEY_UserData = @"YUDIAN.YDEmail.userData";
static NSString * const KEY_UserID = @"YUDIAN.YDEmail.userID";
static NSString * const KEY_UserHeadImageUrl = @"YUDIAN.YDEmail.userHeadImageUrl";
static NSString * const KEY_TipsID = @"YUDIAN.YDEmail.TipsID";
static NSString * const KEY_ShopsWebURL = @"YUDIAN.YDEmail.ShopsWebURL";
static NSString * const KEY_LaunchDate = @"YUDIAN.YDEmail.LaunchDate";
static NSString * const KEY_IsScore = @"YUDIAN.YDEmail.IsScore";


+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    //    [DMKeyChain save:KEY_PASSWORD data:usernamepasswordKVPairs];
    [[NSUserDefaults standardUserDefaults] setObject:usernamepasswordKVPairs forKey:KEY_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)readPassWord
{
    //    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[DMKeyChain load:KEY_PASSWORD];
    NSMutableDictionary *usernamepasswordKVPair = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_PASSWORD];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_PASSWORD];
    //    [DMKeyChain delete:KEY_PASSWORD];
}

+(void)saveUserData:(id)userData
{
    
    
    /**
     *  用户数据转json
     */
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    /**
     *  加密用户json字符串
     */
    jsonString = [YDDes encryptUseDES:jsonString key:DesKey];
    //    NSLog(@"%@", jsonString);
    NSMutableDictionary *userDataKVPairs = [NSMutableDictionary dictionary];
    [userDataKVPairs setObject:jsonString forKey:KEY_UserData];
    [[NSUserDefaults standardUserDefaults] setObject:userDataKVPairs forKey:KEY_UserData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    [DMKeyChain save:KEY_UserData data:userDataKVPairs];
}

+(id)readUserData{
    
    //    NSMutableDictionary *userDataKVPairs = (NSMutableDictionary *)[DMKeyChain load:KEY_UserData];
    NSMutableDictionary *userDataKVPairs = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_UserData];
    /**
     *  如果没有数据  直接返回空
     */
    if (userDataKVPairs==nil) return nil;
    
    NSString *jsonString = [userDataKVPairs objectForKey:KEY_UserData];
    /**
     *  解密json字符串
     */
    jsonString = [YDDes decryptUseDES:jsonString key:DesKey];
    /**
     *  返回解析后的json数据
     */
    return [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
}

+(void)deleteUserData{
    //    [DMKeyChain delete:KEY_UserData];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_UserData];
}

+(void)saveUserID:(id)userID
{
    NSMutableDictionary *userIDKVPairs = [NSMutableDictionary dictionary];
    [userIDKVPairs setObject:userID forKey:KEY_UserID];
    [[NSUserDefaults standardUserDefaults] setObject:userIDKVPairs forKey:KEY_UserID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    [DMKeyChain save:KEY_UserData data:userDataKVPairs];
}

+(id)readUserID
{
    
    //    NSMutableDictionary *userDataKVPairs = (NSMutableDictionary *)[DMKeyChain load:KEY_UserData];
    NSMutableDictionary *userIDKVPairs = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_UserID];
    return [userIDKVPairs objectForKey:KEY_UserID];
}

+(void)deleteUserID
{
    //    [DMKeyChain delete:KEY_UserData];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_UserID];
}



+(void)saveHomeData:(id)homeData
{
    // 获取Caches目录路径
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    file = [file stringByAppendingString:@"homePage.data"];
    //    NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop/bag.data"];
    // 归档
    [NSKeyedArchiver archiveRootObject:homeData toFile:file];
    
}

+(id)readHomeData
{
    // 获取Caches目录路径
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    file = [file stringByAppendingString:@"homePage.data"];
    // 解档
    id homePageData = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    return homePageData;
}


@end
