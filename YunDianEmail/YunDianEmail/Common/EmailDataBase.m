//
//  EmailDataBase.m
//  YunDianEmail
//
//  Created by hzk on 2017/6/18.
//  Copyright © 2017年 yundian. All rights reserved.
//

#import "EmailDataBase.h"
#import "FMDB.h"


static EmailDataBase *_EmailDBCtl = nil;
@interface EmailDataBase()
{
  FMDatabase  *_db;
}

@end
@implementation EmailDataBase

+(instancetype)sharedDataBase{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _EmailDBCtl = [[EmailDataBase alloc]init];
        
        [_EmailDBCtl initDataBase];
    });
    return _EmailDBCtl;
    

    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_EmailDBCtl == nil) {
        
        _EmailDBCtl = [super allocWithZone:zone];
        
    }
    
    return _EmailDBCtl;
    
}
-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    
    if ([_db open]) {
        //4.创表
        BOOL result=[_db executeUpdate:@"CREATE TABLE IF NOT EXISTS emailInfo (id integer PRIMARY KEY AUTOINCREMENT, bodyText text NOT NULL,classification text NOT NULL,containAttach integer NOT NULL,dataDatetime text NOT NULL,emailType text NOT NULL,formmail text NOT NULL,formname text NOT NULL,isNew integer NOT NULL,sentDate text NOT NULL,size integer NOT NULL,subject text NOT NULL,tomail text NOT NULL,toname text NOT NULL,userFileId text NOT NULL);"];
        
        BOOL resultsearch=[_db executeUpdate:@"CREATE TABLE IF NOT EXISTS searchInfo (searchString text NOT NULL);"];
        if (result && resultsearch) {
            NSLog(@"创表成功");
        }else
        {
            NSLog(@"创表失败");
        }
    }
    [_db close];
    
}


- (void)addEmailInfo:(YDInBoxRowsModel *)inboxEmail{
    [_db open];
    [_db executeUpdate:@"INSERT INTO emailInfo(bodyText,classification,containAttach,dataDatetime,emailType,formmail,formname,id,isNew,sentDate,size,subject,tomail,toname,userFileId);",inboxEmail.bodyText,inboxEmail.classification,inboxEmail.containAttach,inboxEmail.dataDatetime,inboxEmail.emailType,inboxEmail.formmail,inboxEmail.formname,inboxEmail.ID,inboxEmail.isNew,inboxEmail.sentDate,inboxEmail.size,inboxEmail.subject,inboxEmail.tomail,inboxEmail.toname,inboxEmail.userFileId
     ];

    [_db close];
    
}

- (void)addSearchInfo:(NSString *)search{
    [_db open];
    
//    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM searchInfo"];
//    while ([resultSet next]) {
//
//    
//        NSString *name = [resultSet stringForColumn:@"searchString"];
//        
//        if ([name isEqualToString:search]) {
//            
//            [_db executeUpdate:@"INSERT INTO searchInfo(bodyText);",search];
// 
//        }
//        
// 
//    }
    

      [_db executeUpdate:@"INSERT INTO searchInfo(searchString)VALUES(?)",search];
    [_db close];
    
}

- (void)deleteEmailInfo{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM emailInfo "];
    
    [_db close];
}

- (void)deleteSearchInfo:(NSString *)search {
    [_db open];
      [_db executeUpdate:@"DELETE FROM searchInfo WHERE searchString = ?",search];
    
    [_db close];
    
}

- (void)deleteOneEmailInfo:(YDInBoxRowsModel *)inboxEmail{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM emailInfo WHERE id = ?",inboxEmail.ID];
    
    [_db close];
}

- (NSArray *)querySearchInfo
{
    [_db open];
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM searchInfo"];
    NSMutableArray *dataArray = [NSMutableArray array];
         // 2.遍历结果
     while ([resultSet next]) {
         
         NSString *name = [resultSet stringForColumn:@"searchString"];
      
         [dataArray addObject:name];
    }
    return [dataArray copy];
}

@end
