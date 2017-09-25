//
//  DanmakuModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface DanmakuModel : BaseModel

/*
 "uid": 27153106,
 "nickname": "果姐姐",
 "count": 1,
 "addtime": 1472554017,
 "acttime": "1 分钟前",
 "img_s": "http://p5.0gow.com/icon0gow_5743028c0e3c7?imageMogr2/thumbnail/64x/strip/quality/80/format/jpg",
 "url": "http://www.0gow.com#",
 "content": "果姐姐下了1笔订单 1 分钟前",
 "group": 1
 */

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *acttime;
@property (nonatomic, copy) NSString *img_s;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *group;

@end





















