//
//  DBManager.m
//  Zero
//
//  Created by 黄郑果 on 16/8/31.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "DBManager.h"

#define DATABASENAME @"zero.sqlite"

@interface DBManager()

/* 声明数据库指针 */
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation DBManager

/* 单例实现 */
+ (DBManager *)shareDBManager {
    
    static DBManager *dbManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dbManager = [[DBManager alloc] init];
    });
    
    return dbManager;
}

#pragma mark --- 初始化方法
- (instancetype)init {
    
    if (self = [super init]) {
        
        /* 创建数据库文件 */
        [self createDataBase];
    }
    
    return self;
}

#pragma mark --- 创建sqlite数据库文件
- (void)createDataBase {
    
    /* 数据库需要放在document文件夹的下面,首先要获取文件夹路径 */
    /* 1.获取Document文件夹路径 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    /* 2.构造数据库文件 */
    NSString *databasePath = [docPath stringByAppendingPathComponent:DATABASENAME];
    
    /* 3.初始化数据库文件指针 */
    self.db = [[FMDatabase alloc] initWithPath:databasePath];
}

- (void)openDB {
    
    [self.db open];
}

- (void)closeDB {
    
    [self.db open];
}

- (BOOL)executeUpdateSqlStr:(NSString *)sqlStr {
    
    return [self.db executeUpdate:sqlStr];
}

- (FMResultSet *)executeQuerySqlStr:(NSString *)sqlStr {
    
    return [self.db executeQuery:sqlStr];
}

- (void)dealloc {
    
    [self.db close];
}

@end



































