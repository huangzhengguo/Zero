//
//  LikeGoodsModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface LikeGoodsModel : BaseModel

/*
 "goods_id": 34603,
 "goods_name": "遇水开花晴雨伞太阳伞",
 "default_image": "http://p3.0gow.com/pic0gow_56c1711eb89ad?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "Price": 16,
 "scPrice": 78,
 "wlPrice": 16
 */

@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *default_image;
@property (nonatomic, strong) NSString *Price;
@property (nonatomic, strong) NSString *scPrice;
@property (nonatomic, strong) NSString *wlPrice;
@property (nonatomic, strong) NSString *goods_des;

@end
