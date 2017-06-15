//
//  YDContactsViewController.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/15.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicViewController.h"
typedef NS_ENUM(NSInteger, YUDIANContactsFromTYPE) {
    YUDIANContactsFromTYPEIsHome = 1,       //首页
    YUDIANContactsFromTYPEIsWritter,          //写信
    
};
@interface YDContactsViewController : YDBasicViewController
@property(nonatomic,assign)YUDIANContactsFromTYPE  contactsType;
@end
