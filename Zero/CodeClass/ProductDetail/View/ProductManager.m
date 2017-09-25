//
//  ProductManager.m
//  Zero
//
//  Created by 黄郑果 on 16/8/31.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ProductManager.h"

#import "DBManager.h"

#import "FMResultSet.h"

#define COLLECTIONTABLENAME @"productcollect"

@interface ProductManager()

@property (nonatomic, strong) DBManager *manager;

@end

@implementation ProductManager

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.manager = [DBManager shareDBManager];
        
        [self createProductCollectionTable];
    }
    
    return self;
}

#pragma mark --- 创建数据库
- (void)createProductCollectionTable {
    
    /* 1.打开数据库 */
    [self.manager openDB];
    
    /* 2.构造数据库语句 */
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (goods_id text,goods_title text,goods_name text,Price text,thumbnail_m text,uid text)",COLLECTIONTABLENAME];
    
    /* 3.执行语句 */
    [self.manager executeUpdateSqlStr:sqlStr];
    
    /* 4.打印执行结果 */
    //NSLog(@"%@",success==YES?@"执行成功":@"执行失败");
    
    /* 5.关闭数据库 */
    [self.manager closeDB];
}

#pragma mark --- 插入操作
- (BOOL)insertIntoProductCollectionTable:(ProductDetailModel *)model uid:(NSString *)uid{
    
    /* 1.打开数据库 */
    [self.manager openDB];
    
    /* 2.构造数据库语句 */
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@ (goods_id,goods_title,goods_name,Price,thumbnail_m,uid) values('%@','%@','%@','%@','%@','%@')",COLLECTIONTABLENAME,[NSString stringWithFormat:@"%@",model.goods_id],model.goods_title,model.goods_name,model.Price,model.thumbnail_m,uid];
    
    /* 3.执行语句 */
    BOOL success = [self.manager executeUpdateSqlStr:sqlStr];
    
    /* 5.关闭数据库 */
    [self.manager closeDB];
    
    return success;
}

#pragma mark --- 删除收藏记录
- (BOOL)deleteFromProductCollectionTableWithGoodId:(NSString *)goodId uid:(NSString *)uid{
    
    /* 1.打开数据库 */
    [self.manager openDB];
    
    /* 2.构造数据库语句 */
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@ where goods_id = '%@' and uid = '%@'",COLLECTIONTABLENAME,goodId,uid];
    
    /* 3.执行语句 */
    BOOL success = [self.manager executeUpdateSqlStr:sqlStr];
    
    /* 5.关闭数据库 */
    [self.manager closeDB];
    
    return success;
}

-(NSArray *)queryAllProductsWithUid:(NSString *)uid {
 
    [self.manager openDB];
    
    /* 1.构造数据库语句 */
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ where uid = '%@'",COLLECTIONTABLENAME,[NSString stringWithFormat:@"%@",uid]];
    
    FMResultSet *resultSet = [self.manager executeQuerySqlStr:sqlStr];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    while ([resultSet next]) {
        
        ProductDetailModel *model = [[ProductDetailModel alloc] init];
        
        model.goods_id = [resultSet stringForColumn:@"goods_id"];
        model.goods_name = [resultSet stringForColumn:@"goods_name"];
        model.goods_title = [resultSet stringForColumn:@"goods_title"];
        model.Price = [resultSet stringForColumn:@"Price"];
        model.thumbnail_m = [resultSet stringForColumn:@"thumbnail_m"];
        
        [dataArray addObject:model];
    }
    
    [resultSet close];
    
    [self.manager closeDB];
    
    return dataArray;
}

-(NSArray *)queryAllProductsWithUid:(NSString *)uid goods_id:(NSString *)goods_id{
    
    [self.manager openDB];
    
    /* 1.构造数据库语句 */
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@ where uid = '%@' and goods_id = '%@'",COLLECTIONTABLENAME,[NSString stringWithFormat:@"%@",uid],[NSString stringWithFormat:@"%@",goods_id]];
    
    FMResultSet *resultSet = [self.manager executeQuerySqlStr:sqlStr];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    while ([resultSet next]) {
        
        ProductDetailModel *model = [[ProductDetailModel alloc] init];
        
        model.goods_id = [resultSet stringForColumn:@"goods_id"];
        model.goods_name = [resultSet stringForColumn:@"goods_name"];
        model.goods_title = [resultSet stringForColumn:@"goods_title"];
        model.Price = [resultSet stringForColumn:@"Price"];
        model.thumbnail_m = [resultSet stringForColumn:@"thumbnail_m"];
        
        [dataArray addObject:model];
    }
    
    [resultSet close];
    
    [self.manager closeDB];
    
    return dataArray;
}

@end







































