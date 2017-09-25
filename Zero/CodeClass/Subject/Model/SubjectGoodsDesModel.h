//
//  SubjectGoodsDesModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface SubjectGoodsDesModel : BaseModel

/*
 "goods_id": "172585",
 "goods_title": "天津麻花特产零食小吃正宗传统糕点小吃礼盒装休闲美食",
 "goods_name": "天津特产麻花500g",
 "type": "base",
 "default_image": "http://p3.0gow.com/pic0gow_57959d85d054d?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "Price": 16,
 "wlPrice": "16.00",
 "scPrice": "42.00",
 "sale": "141",
 "goods_des": "厂家直销 正宗特产 酥脆香甜 "
 goodsNowStock
 */

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *Price;
@property (nonatomic, copy) NSString *wlPrice;
@property (nonatomic, copy) NSString *scPrice;
@property (nonatomic, copy) NSString *sale;
@property (nonatomic, copy) NSString *goods_des;
@property (nonatomic, copy) NSString *goodsNowStock;

@end
