//
//  RecommandModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface RecommandModel : BaseModel

/*
 
 "goodsNowStock": "444",
 "goods_id": 68495,
 "goods_name": "成人电子称体重秤家用",
 "goods_title": "电子称体重秤家用精准电子秤人体秤体重称计智能成人健康秤",
 "goods_des": "电子称体重秤家用精准电子秤人体秤体重称计智能成人健康秤",
 "type": "zuhe",
 "default_image": "http://p3.0gow.com/pic0gow_57035cf046ac4?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "scPrice": "118.00",
 "Price": 22,
 "wlPrice": "22.00",
 "add_time": 1466845510,
 "bindGoodsID": "68496",
 "is_act": 0,
 "coverCss": ""
 */

@property (nonatomic, copy) NSString *goodsNowStock;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *goods_des;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *scPrice;
@property (nonatomic, copy) NSString *Price;
@property (nonatomic, copy) NSString *wlPrice;
@property (nonatomic, copy) NSString *add_time;
@property (nonatomic, copy) NSString *bindGoodsID;
@property (nonatomic, copy) NSString *is_act;
@property (nonatomic, copy) NSString *coverCss;

@end























