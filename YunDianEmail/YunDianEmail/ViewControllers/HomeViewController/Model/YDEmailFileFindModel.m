//
//  YDEmailFileFindModel.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/27.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDEmailFileFindModel.h"

@implementation YDEmailFileFindModel
+ (NSDictionary *)objectClassInArray{
    return @{@"rows" : [YDEmailFileFindRowsModel class]};
}
@end

@implementation YDEmailFileFindRowsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

@end
