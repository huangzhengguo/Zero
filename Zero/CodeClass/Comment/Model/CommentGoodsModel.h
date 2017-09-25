//
//  CommentGoodsModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface CommentGoodsModel : BaseModel

/*
 "goods_id": "156212",
 "goods_title": "2016新款尖头性感粗跟高跟鞋",
 "goods_name": "纯色气质尖头高跟鞋女",
 "goods_des": "亲：下单前选择清楚颜色和尺码"
 */

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_des;

@end
