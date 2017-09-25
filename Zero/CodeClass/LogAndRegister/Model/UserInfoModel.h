//
//  UserInfoModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel

/*
 {
 "code": 1,
 "msg": "操作成功",
 "user": {
 "name": "wx40570758",
 "nickname": "黄正果",
 "pwd": "25f9e794323b453885f5181f1b624d0b",
 "pwd_bak": "25f9e794323b453885f5181f1b624d0b",
 "type": "wx",
 "subscribe": "0",
 "membership": "0",
 "openid": "o8F95xEpo4GBc1UsgB5nIP5DYRH4",
 "unionid": "onDDXvsIASHrIvDZseXquJEzPugU",
 "user_money": "0.95",
 "user_duobao": "0",
 "all_money": "0.00",
 "user_jifen": "0",
 "user_quan": "0",
 "qcode": "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEv8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3JrZ1hOaEhsZW9VRFhLZ0t3bWIxAAIEi9K3VwMEAI0nAA==",
 "qcode_url": "http://weixin.qq.com/q/rkgXNhHleoUDXKgKwmb1",
 "qcode_ticket": "gQEv8ToAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL3JrZ1hOaEhsZW9VRFhLZ0t3bWIxAAIEi9K3VwMEAI0nAA==",
 "limit": "0",
 "expiretime": "2016-09-09 00:00:00",
 "ip": "171.15.159.50",
 "sex": "1",
 "city": null,
 "country": "CN",
 "province": null,
 "language": "zh_CN",
 "headimgurl": "http://wx.qlogo.cn/mmopen/uur2IKloticN2FHXTlHWLoL5Wl8ia8BiaBmuq3TI30Y5ddmNRnCOFyEr6LnZoAsGbvmPZAQTFwkeu91ZPuqibl0wU2Z8wwAVqFER/0",
 "newheadimgurl": null,
 "img": "icon0gow_57b7d29bb028f",
 "img_s": "http://p5.0gow.com/icon0gow_57b7d29bb028f?imageMogr2/thumbnail/64x/strip/quality/80/format/jpg",
 "img_m": "http://p5.0gow.com/icon0gow_57b7d29bb028f?imageMogr2/thumbnail/100x/strip/quality/80/format/jpg",
 "img_b": "http://p5.0gow.com/icon0gow_57b7d29bb028f?imageMogr2/thumbnail/160x/strip/quality/80/format/jpg",
 "email": null,
 "birthday": null,
 "affiliate": "0",
 "addtime": "1471664778",
 "info": null,
 "updatetime": "1471664778",
 "is_on": "0",
 "send": "0",
 "level": "0",
 "tel": "15515953732",
 "is_mb": 0,
 "is_pwd": 0,
 "token": "lNx7h3+r79w4I6FHRx9IfKYfokhkBARLelzS4D/4rawEtlBrb499DoarJov7lJ9ySLXqXFJeXCLvY0BFFQ+HlKL8FId33ME8",
 "ticket": "7a00df124ca4b11104eca62fb262f659",
 "uid": "40570758"
 }
 }
 */

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *pwd_bak;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *subscribe;
@property (nonatomic, copy) NSString *membership;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *user_money;
@property (nonatomic, copy) NSString *user_duobao;
@property (nonatomic, copy) NSString *all_money;
@property (nonatomic, copy) NSString *user_jifen;
@property (nonatomic, copy) NSString *user_quan;
@property (nonatomic, copy) NSString *qcode;
@property (nonatomic, copy) NSString *qcode_url;
@property (nonatomic, copy) NSString *qcode_ticket;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, copy) NSString *expiretime;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *newheadimgurl;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *img_s;
@property (nonatomic, copy) NSString *img_m;
@property (nonatomic, copy) NSString *img_b;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *affiliate;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *is_on;
@property (nonatomic, copy) NSString *send;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *is_mb;
@property (nonatomic, copy) NSString *is_pwd;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *ticket;
@property (nonatomic, copy) NSString *uid;

@end

























































