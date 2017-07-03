//
//  YDSearchViewController.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicViewController.h"
typedef NS_ENUM(NSInteger, YUDIANMailSearchTYPE) {
    YUDIANMailSearchTYPESender , //发件人
    YUDIANMailSearchTYPERecipient,   //收件人
    YUDIANMailSearchTYPESubject,//主题
    YUDIANMailSearchTYPEAll, //全部
 
    
};
@interface YDSearchViewController : YDBasicViewController

@property(nonatomic,assign)YUDIANMailSearchTYPE searchType;
@end
