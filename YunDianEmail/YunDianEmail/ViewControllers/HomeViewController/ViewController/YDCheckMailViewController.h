//
//  YDCheckMailViewController.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/4.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicViewController.h"
#import "YDInBoxModel.h"
typedef void(^RefrushInboxData)();

@interface YDCheckMailViewController : YDBasicViewController

@property (nonatomic,strong)YDInBoxRowsModel *inboxRows;
@property (nonatomic, copy) RefrushInboxData refrushData;
@property (nonatomic,strong)NSString *  emailID;
@end
