//
//  ProductDetailModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface ProductDetailModel : BaseModel

/*
 "goods_attr": "1",
 "defalut_image_id": "246808",
 "goods_id": "156212",
 "goods_title": "2016新款尖头性感粗跟高跟鞋",
 "goods_name": "纯色气质尖头高跟鞋女",
 "goods_des": "亲：下单前选择清楚颜色和尺码",
 "Price": "48.00",
 "scPrice": "199.00",
 "wlPrice": "0.00",
 "jsPrice": "42.00",
 "fxPrice": "3.00",
 "goodsNowStock": 8950,
 "description": "<p>\r\n\t<strong><span style=\"font-size:32px;\">默认快递：百世汇通</span></strong> \r\n</p>\r\n<p>\r\n\t<strong><span style=\"font-size:32px;\">客服QQ：403482230</span></strong> \r\n</p>\r\n<p>\r\n\t<br />\r\n</p>\r\n<p>\r\n\t<strong><span style=\"font-size:32px;\"><img src=\"http://p4.0gow.com/content0gow_578450c0181b9?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450c06782e?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450c0d12ee?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450c13ed8f?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450c199c8b?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450c2079ef?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450c277ad5?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450c2e2d0f?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><img src=\"http://p4.0gow.com/content0gow_578450ca218fd?imageMogr2/thumbnail/620x/strip/quality/75/format/jpg\" alt=\"\" /><br />\r\n</span></strong> \r\n</p>",
 "type": "zuhe",
 "view": "5627",
 "sale": "49",
 "seller_id": "12927",
 "thumbnail_m": "http://p3.0gow.com/pic0gow_578450ed46578?imageMogr2/thumbnail/320x/strip/quality/75/format/jpg",
 "thumbnail_s": "http://p3.0gow.com/pic0gow_578450ed46578?imageMogr2/thumbnail/240x/strip/quality/75/format/jpg",
 "image_id": "246808",
 "area_id": "2"
 "uid": 0
 "zk_price": "0.50",
 "commentCount": "14",
 "orderCount": "49",
 "hpl": "95.92",
 "tsl": "0.00"
 "store_name": "奇安达鞋类专营店",
 "seller_qq": 403482230,
 */
@property (nonatomic, copy) NSString *goods_attr;
@property (nonatomic, copy) NSString *defalut_image_id;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_des;
@property (nonatomic, copy) NSString *Price;
@property (nonatomic, copy) NSString *scPrice;
@property (nonatomic, copy) NSString *wlPrice;
@property (nonatomic, copy) NSString *jsPrice;
@property (nonatomic, copy) NSString *fxPrice;
@property (nonatomic, copy) NSString *goodsNowStock;
@property (nonatomic, copy) NSString *product_description;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *view;
@property (nonatomic, copy) NSString *sale;
@property (nonatomic, copy) NSString *seller_id;
@property (nonatomic, copy) NSString *thumbnail_m;
@property (nonatomic, copy) NSString *thumbnail_s;
@property (nonatomic, copy) NSString *image_id;
@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *zk_price;
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *orderCount;
@property (nonatomic, copy) NSString *hpl;
@property (nonatomic, copy) NSString *tsl;
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *seller_qq;

@end












































