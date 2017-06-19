//
//  YDUserDataModel.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/17.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicDataModel.h"

@interface YDUserDataModel : YDBasicDataModel

@property (nonatomic,strong)NSString *userAccount;

@property (nonatomic,strong)NSString *userPassword;

@property (nonatomic,strong)NSString *userName;

@property (nonatomic, assign) BOOL loginStatus;

@property (nonatomic,strong)NSString *session;

@end
