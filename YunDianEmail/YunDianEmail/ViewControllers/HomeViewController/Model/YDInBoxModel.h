//
//  YDInBoxModel.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/12.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicDataModel.h"
@class YDInBoxRowsModel,YDInBoxModel;




@interface YDInBoxModel : YDBasicDataModel

@property (nonatomic,copy)NSString *isnew;
@property (nonatomic,copy)NSString *total;
@property (nonatomic,strong)NSArray<YDInBoxRowsModel *> *rows;

@end



@interface YDInBoxRowsModel : YDBasicDataModel

@property (nonatomic,copy)NSString *bodyText;

@property (nonatomic,copy)NSString *classification;

@property (nonatomic,copy)NSString *containAttach;

@property (nonatomic,copy)NSString *dataDatetime;

@property (nonatomic,copy)NSString *emailType;

@property (nonatomic,copy)NSString *formmail;

@property (nonatomic,copy)NSString *formname;


@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *isNew;
@property (nonatomic,copy)NSString *sentDate;
@property (nonatomic,copy)NSString *size;
@property (nonatomic,copy)NSString *subject;

@property (nonatomic,copy)NSString *tomail;
@property (nonatomic,copy)NSString *toname;
@property (nonatomic,copy)NSString *userFileId;
@end
