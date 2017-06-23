//
//  YDWriteLetterViewController.h
//  YunDianEmail
//
//  Created by hzk on 2017/6/3.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "YDBasicViewController.h"


typedef void(^RefrushWriteLetterData)();

@interface YDWriteLetterViewController : YDBasicViewController
@property (nonatomic, copy) RefrushWriteLetterData refrushData;
@end
