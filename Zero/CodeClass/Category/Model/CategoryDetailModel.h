//
//  CategoryDetailModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryDetailModel : BaseModel

/* 
 Price = "69.00";
 "add_time" = 1471053681;
 coverCss = "";
 "default_image" = "http://p3.0gow.com/pic0gow_578e4efacf792?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg";
 goodsNowStock = 557;
 "goods_id" = 165272;
 "goods_name" = "\U5a5a\U5178\U4f34\U5a18\U62b9\U80f8\U5c0f\U793c\U670d";
 "goods_title" = "2016\U65b0\U6b3e\U4f34\U5a18\U670d\U77ed\U6b3e\U4fee\U8eab\U62b9\U80f8\U665a\U793c\U670d\U6f14\U51fa\U670d\U59d0\U59b9\U56e2\U84ec\U84ec\U88d9";
 "is_act" = 0;
 scPrice = "199.00";
 type = zuhe;
 wlPrice = "0.00";
 */

@property (nonatomic, strong) NSString *Price;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *coverCss;
@property (nonatomic, strong) NSString *default_image;
@property (nonatomic, strong) NSString *goodsNowStock;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_title;
@property (nonatomic, strong) NSString *is_act;
@property (nonatomic, strong) NSString *scPrice;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *wlPrice;

@end





















