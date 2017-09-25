//
//  ZuInfoModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface ZuInfoModel : BaseModel

/*
 "bindGoodsID": "191377",
 "spec_1Attr": "S",
 "spec_id": "159095",
 "spec_2Attr": "6623",
 "Price": "59.00",
 "scPrice": "118.00",
 "wlPrice": "0.00",
 "jsPrice": "48.00",
 "fxPrice": "1.00",
 "goodsNowStock": "500",
 "type": "base",
 "thumbnail_m": "http://p3.0gow.com/pic0gow_57ab68e03e2e8?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "thumbnail_s": "http://p3.0gow.com/pic0gow_57ab68e03e2e8?imageMogr2/thumbnail/240x/strip/quality/75/format/jpg",
 "image_id": "300762",
 "goods_id": "191377"
 */

@property (nonatomic, copy) NSString *bindGoodsID;
@property (nonatomic, copy) NSString *spec_1Attr;
@property (nonatomic, copy) NSString *spec_id;
@property (nonatomic, copy) NSString *spec_2Attr;
@property (nonatomic, copy) NSString *Price;
@property (nonatomic, copy) NSString *scPrice;
@property (nonatomic, copy) NSString *wlPrice;
@property (nonatomic, copy) NSString *jsPrice;
@property (nonatomic, copy) NSString *fxPrice;
@property (nonatomic, copy) NSString *goodsNowStock;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *thumbnail_m;
@property (nonatomic, copy) NSString *thumbnail_s;
@property (nonatomic, copy) NSString *image_id;
@property (nonatomic, copy) NSString *goods_id;

@end






























