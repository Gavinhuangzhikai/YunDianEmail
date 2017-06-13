//
//  YDBasicDataModel.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/12.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicDataModel.h"

@implementation YDBasicDataModel
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self = [[self class]mj_objectWithKeyValues:dictionary];
    }
    return self;
}

//重写,防止kvc无法找到key时崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
