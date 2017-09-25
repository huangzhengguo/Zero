//
//  GoodsPublicModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsPublicModel : BaseModel

/* 此数据模型用来展示商品数据 */

/*
 "goods_id": "169376",
 "goods_name": "新款休闲豆豆鞋男鞋",
 "goods_title": "韩版男士休闲鞋青少年鞋子潮鞋个性男鞋百搭豆豆鞋",
 "default_image": "http://p3.0gow.com/pic0gow_5791efebee93c?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "scPrice": "188.00",
 "Price": "48.00",
 "view": "1863",
 "goodsNowStock": "999",
 "add_time": "1471075661",
 "wlPrice": "0.00",
 "type": "zuhe"
 */

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *scPrice;
@property (nonatomic, copy) NSString *Price;
@property (nonatomic, copy) NSString *view;
@property (nonatomic, copy) NSString *goodsNowStock;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *wlPrice;
@property (nonatomic, copy) NSString *type;

@end
