//
//  YDContactsModel.m
//  YunDianEmail
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDContactsModel.h"

@implementation YDContactsModel
+ (NSDictionary *)objectClassInArray{
    return @{@"rows" : [YDContactsInfoModel class]};
}

@end



@implementation YDContactsInfoModel


@end
