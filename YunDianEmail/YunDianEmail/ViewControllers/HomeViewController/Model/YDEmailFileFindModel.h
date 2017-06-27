//
//  YDEmailFileFindModel.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/27.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicDataModel.h"
@class YDEmailFileFindRowsModel;
@interface YDEmailFileFindModel : YDBasicDataModel
@property (nonatomic,copy)NSString *isnew;
@property (nonatomic,copy)NSString *total;
@property (nonatomic,strong)NSArray<YDEmailFileFindRowsModel *> *rows;
@end


@interface YDEmailFileFindRowsModel : YDBasicDataModel

@property (nonatomic,copy)NSString *extension;

@property (nonatomic,copy)NSString *fileSize;

@property (nonatomic,copy)NSString *filename;

@property (nonatomic,copy)NSString *ID;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *type;

@end
