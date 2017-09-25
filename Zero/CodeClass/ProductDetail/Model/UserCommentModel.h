//
//  UserCommentModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface UserCommentModel : BaseModel

/*
 "comment_id": "1979301",
 "name": "网友29064638",
 "uid": "29064638",
 "sid": "156212",
 "body": "鞋子做工差，不满意",
 "addtime": "2016-08-24",
 "rate": "-1",
 "order_sn": "20160714f4f94320a6da",
 "is_hidden": "0",
 "img_s": "http://p5.0gow.com/icon0gow_571708c90366d?imageMogr2/thumbnail/64x/strip/quality/80/format/jpg",
 "spec_des": "灰色 39",
 "imgs": [],
 "replys": []
 */

@property (nonatomic, strong) NSString *comment_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *order_sn;
@property (nonatomic, strong) NSString *is_hidden;
@property (nonatomic, strong) NSString *img_s;
@property (nonatomic, strong) NSString *spec_des;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSArray *replys;

@end





























