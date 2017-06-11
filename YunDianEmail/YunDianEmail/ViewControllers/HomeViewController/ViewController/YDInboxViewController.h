//
//  YDInboxViewController.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicViewController.h"
typedef NS_ENUM(NSInteger, YUDIANMailTYPE) {
    YUDIANINBOXTYPE = 1,       //收件箱
    YUDIANDraftBoxTYPE,          //草稿箱
    YUDIANBeenSentTYPE,     //已发送
    YUDIANBeenDeletedtTYPE,        //已删除
    YUDIANBeenTrashCansTYPE,   //垃圾箱

};
@interface YDInboxViewController : YDBasicViewController

@property (nonatomic, assign) YUDIANMailTYPE mailType;

@end
