//
//  DBManager.h
//  Zero
//
//  Created by 黄郑果 on 16/8/31.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDatabase.h>

@interface DBManager : NSObject

/* 设置为单例类 */
+ (DBManager *)shareDBManager;

/* 需要的方法 */
/* 打开数据库 */
- (void)openDB;

/* 关闭数据库 */
- (void)closeDB;

/* 数据库语句执行封装 */
- (BOOL)executeUpdateSqlStr:(NSString *)sqlStr;

- (FMResultSet *)executeQuerySqlStr:(NSString *)sqlStr;

@end


































