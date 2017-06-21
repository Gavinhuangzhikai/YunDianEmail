//
//  EmailDataBase.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/18.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDInBoxModel.h"

@interface EmailDataBase : NSObject
+(instancetype)sharedDataBase;
- (void)addEmailInfo:(YDInBoxRowsModel *)inboxEmail;
- (void)addSearchInfo:(NSString *)search;
- (void)deleteEmailInfo;

- (void)deleteSearchInfo:(NSString *)search;
- (void)deleteOneEmailInfo:(YDInBoxRowsModel *)inboxEmail;
- (NSArray *)querySearchInfo;

@end
