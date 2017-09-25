//
//  HotProductModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface HotProductModel : BaseModel

/*
 "goods_id": 140049,
 "goods_name": "泊泉雅婴儿蚕丝面膜20片",
 "default_image": "http://p3.0gow.com/pic0gow_576be6098810b?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "Price": 22,
 "scPrice": 168,
 "wlPrice": 22
 */

@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *default_image;
@property (nonatomic, strong) NSString *Price;
@property (nonatomic, strong) NSString *scPrice;
@property (nonatomic, strong) NSString *wlPrice;
@property (nonatomic, strong) NSString *goods_des;

@end
