//
//  MyselfModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface MyselfModel : BaseModel

/*
 "id": "40570758",
 "img_b": "http://p5.0gow.com/icon0gow_57b7d29bb028f?imageMogr2/thumbnail/160x/strip/quality/80/format/jpg",
 "nickname": "黄正果",
 "name": "wx40570758",
 "subscribe": "0",
 "sex": "1",
 "addtime": "2016-08-20 11:46:18",
 "membership": "0",
 "user_money": "0.95",
 "user_jifen": "0",
 "birthday": null,
 "level_name": "少尉",
 "level_name_2": "军侯",
 "tel": "15515953732",
 "order_num": "0",
 "noship_num": "0",
 "norecv_num": "0",
 "nocomment_num": "0"
 */

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *img_b;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subscribe;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *membership;
@property (nonatomic, strong) NSString *user_money;
@property (nonatomic, strong) NSString *user_jifen;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *level_name;
@property (nonatomic, strong) NSString *level_name_2;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *order_num;
@property (nonatomic, strong) NSString *noship_num;
@property (nonatomic, strong) NSString *norecv_num;
@property (nonatomic, strong) NSString *nocomment_num;

@end



































