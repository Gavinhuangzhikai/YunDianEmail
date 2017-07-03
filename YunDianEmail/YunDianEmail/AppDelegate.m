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
    
  


    
    if (TEXTFONT == nil) {
        SetTEXTFONT(@15);
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

    

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    YDUserDataModel *userModel = [YDUserDataModel mj_objectWithKeyValues:[YDUserDataManager readUserData]];
    userModel.loginStatus = NO;
    userModel.session = nil;
    [YDUserDataManager saveUserData:userModel.mj_keyValues];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    YDUserDataModel *userModel = [YDUserDataModel mj_objectWithKeyValues:[YDUserDataManager readUserData]];
    if (  userModel.loginStatus == YES  && userModel.session != nil  ) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        YDHomeViewController *controller = [[YDHomeViewController alloc] init];
        self.window.rootViewController = [[YDBasicNavgationViewController alloc] initWithRootViewController:controller];
        [self.window makeKeyAndVisible];
    }else{
        
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        YDLoginViewController *controller = [[YDLoginViewController alloc] init];
        self.window.rootViewController = controller;
        [self.window makeKeyAndVisible];
        
        
        
    }

}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
