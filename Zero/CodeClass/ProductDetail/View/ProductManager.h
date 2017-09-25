//
//  ProductManager.h
//  Zero
//
//  Created by 黄郑果 on 16/8/31.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 产品model */
#import "ProductDetailModel.h"

@interface ProductManager : NSObject

/* 产品产品收藏表 */
- (void)createProductCollectionTable;

/* 插入操作 */
- (BOOL)insertIntoProductCollectionTable:(ProductDetailModel *)model uid:(NSString *)uid;

/* 删除操作 */
- (BOOL)deleteFromProductCollectionTableWithGoodId:(NSString *)goodId uid:(NSString *)uid;

/* 查询操作 */
- (NSArray *)queryAllProductsWithUid:(NSString *)uid;

/* 查询某个用户收藏的产品 */
-(NSArray *)queryAllProductsWithUid:(NSString *)uid goods_id:(NSString *)goods_id;

@end
