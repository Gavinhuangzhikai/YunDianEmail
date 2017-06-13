//
//  YDInBoxModel.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/12.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDInBoxModel.h"

@implementation YDInBoxModel
+ (NSDictionary *)objectClassInArray{
    return @{@"rows" : [YDInBoxRowsModel class]};
}

@end

@implementation YDInBoxRowsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

@end
