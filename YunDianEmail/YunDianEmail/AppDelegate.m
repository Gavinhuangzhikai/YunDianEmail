//
//  AppDelegate.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "AppDelegate.h"
#import "YDHomeViewController.h"
#import "YDLoginViewController.h"
#import "YDBasicNavgationViewController.h"
#import "FMDB.h"
#import "YDUserDataManager.h"
#import "YDUserDataModel.h"
#import "EmailDataBase.h"
@interface AppDelegate ()
{
     FMDatabase  *_db;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    // 文件路径
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"contacts.sqlite"];
//    
//    // 实例化FMDataBase对象
//    
//    _db = [FMDatabase databaseWithPath:filePath];
//    
//    if ([_db open]) {
//        //4.创表
//        BOOL result=[_db executeUpdate:@"CREATETABLE IF NOT EXISTS emailInfo (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL,person_id' VARCHAR(255));"];
//        if (result) {
//            NSLog(@"创表成功");
//        }else
//        {
//            NSLog(@"创表失败");
//        }
//    }
//    
//    
//    [_db close];

    
    if (TEXTFONT == nil) {
        SetTEXTFONT(@18);
    }

    YDUserDataModel *userModel = [YDUserDataModel mj_objectWithKeyValues:[YDUserDataManager readUserData]];
    if (  userModel.loginStatus == YES  && userModel.session != nil  ) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        YDHomeViewController *controller = [[YDHomeViewController alloc] init];
        self.window.rootViewController = [[YDBasicNavgationViewController alloc] initWithRootViewController:controller];
        [self.window makeKeyAndVisible];
        return YES;

        }else{

           self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
           YDLoginViewController *controller = [[YDLoginViewController alloc] init];
           self.window.rootViewController = controller;
           [self.window makeKeyAndVisible];
           return YES;

             
    }
    

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
