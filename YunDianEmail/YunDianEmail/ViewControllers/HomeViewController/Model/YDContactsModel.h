//
//  YDContactsModel.h
//  YunDianEmail
//
//  Created by admin on 2017/6/16.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicDataModel.h"
@class YDContactsInfoModel,YDContactsModel;

@interface YDContactsModel : YDBasicDataModel

@property (nonatomic,copy)NSString *total;
@property (nonatomic,strong)NSArray<YDContactsInfoModel *> *rows;

@end


@interface YDContactsInfoModel : YDBasicDataModel

@property (nonatomic,copy)NSString *key;

@property (nonatomic,copy)NSString *val;

@end
