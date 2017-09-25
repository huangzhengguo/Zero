//
//  NewSubjectGoodsModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface NewSubjectGoodsModel : BaseModel

/*
"goods_id": "172585",
"goods_title": "天津麻花特产零食小吃正宗传统糕点小吃礼盒装休闲美食",
"goods_name": "天津特产麻花500g",
"default_image": "http://p3.0gow.com/pic0gow_57959d85d054d?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
"Price": 16,
"wlPrice": 0
 */

@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_title;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *default_image;
@property (nonatomic, strong) NSString *Price;
@property (nonatomic, strong) NSString *wlPrice;
@property (nonatomic, strong) NSString *scPrice;
@property (nonatomic, strong) NSString *goodsNowStock;

@end
