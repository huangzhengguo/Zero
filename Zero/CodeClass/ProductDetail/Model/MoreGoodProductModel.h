//
//  MoreGoodProductModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface MoreGoodProductModel : BaseModel

/*

 "default_image": "http://p3.0gow.com/pic0gow_56c72ad28f730?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "goods_id": "6283",
 "goods_name": "厨房水龙头净水器",
 "goods_title": "家用自来水过滤器非直饮陶瓷芯滤水器环保水卫士",
 "Price": 20,
 "scPrice": "98.00",
 "wlPrice": "20.00",
 "thumbnail_s": "http://p3.0gow.com/pic0gow_56c72ad28f730?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg"
 */

@property (nonatomic, copy) NSString *default_image;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *Price;
@property (nonatomic, copy) NSString *scPrice;
@property (nonatomic, copy) NSString *wlPrice;
@property (nonatomic, copy) NSString *thumbnail_s;

@end
