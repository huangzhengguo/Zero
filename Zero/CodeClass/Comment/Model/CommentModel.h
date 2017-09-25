//
//  CommentModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface CommentModel : BaseModel

/*
 "comment_id": 1979301,
 "uid": 29064638,
 "sid": 156212,
 "body": "鞋子做工差，不满意",
 "addtime": "2016-08-24",
 "rate": "差评",
 "order_sn": "20160714f4f94320a6da",
 "is_hidden": 0,
 "spec_des": "灰色 39",
 "nickname": "嫣然一笑",
 "img_s": "http://p5.0gow.com/icon0gow_571708c90366d?imageMogr2/thumbnail/64x/strip/quality/80/format/jpg",
 "imgs": [],
 "replys": []
 */

@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *is_hidden;
@property (nonatomic, copy) NSString *spec_des;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *img_s;
@property (nonatomic, copy) NSArray *imgs;
@property (nonatomic, copy) NSArray *replys;

@end
