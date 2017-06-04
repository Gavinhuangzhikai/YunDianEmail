//
//  YDConfig.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/1.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const YDHttpIP;
UIKIT_EXTERN NSString *const YDRequestFailureNote;
UIKIT_EXTERN NSString *const YDRequestNullNote;
UIKIT_EXTERN NSString *const YDRequestLogOutNote;
UIKIT_EXTERN NSString *const YDRequestWIFINote ;


#define YDWindow ((UIWindow *)[[[UIApplication sharedApplication] windows] lastObject])
#define YDDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define YDScreenWidth [UIScreen mainScreen].bounds.size.width
#define YDScreenHeight [UIScreen mainScreen].bounds.size.height
#define YDScreenScale [UIScreen mainScreen].scale
#define YDNavigationWidth(controller) controller.navigationController.navigationBar.frame.size.width
#define YDNavigationHeight(controller) controller.navigationController.navigationBar.frame.size.height

#define YDOffset(viewController) [DMTools getOffset:viewController]
#define YDViewRect(viewcontroller)  CGRectMake(viewcontroller.view.frame.origin.x, viewcontroller.view.frame.origin.y, viewcontroller.view.frame.size.width, viewcontroller.view.frame.size.height-DMOffset(viewcontroller))
#define YDFast(x,y,w,h)  CGRectMake(x,y, TLScreenWidth/320*w, TLScreenWidth/320*h)  //等比拉伸
#define YDFastOnlyWidth(x,y,w,h)  CGRectMake(x,y, w, h)  //宽度拉伸
#define iPhone6 (DMScreenWidth)>320
#define YDFontAdaptive(fontSize)  DMScreenWidth/320*fontSize

#define YDFont(fontSize)  [UIFont systemFontOfSize:fontSize]


// ---------- 颜色 ----------
#define YDRGB(r, g, b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

// ---------- URL ----------
// 登录
#define YDCheckLoginUrl [YDTools getUrlPathWithHttp:YDHttpIP andURL:@"login/in"]
