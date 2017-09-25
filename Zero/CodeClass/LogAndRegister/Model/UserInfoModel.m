//
//  UserInfoModel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "UserInfoModel.h"

@interface UserInfoModel()<NSCoding>

@end

@implementation UserInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

/* 归档 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeObject:_pwd forKey:@"pwd"];
    [aCoder encodeObject:_pwd_bak forKey:@"pwd_bak"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_subscribe forKey:@"subscribe"];
    [aCoder encodeObject:_membership forKey:@"membership"];
    [aCoder encodeObject:_openid forKey:@"openid"];
    [aCoder encodeObject:_unionid forKey:@"unionid"];
    [aCoder encodeObject:_user_money forKey:@"user_money"];
    [aCoder encodeObject:_user_duobao forKey:@"user_duobao"];
    [aCoder encodeObject:_all_money forKey:@"all_money"];
    [aCoder encodeObject:_user_jifen forKey:@"user_jifen"];
    [aCoder encodeObject:_user_quan forKey:@"user_quan"];
    [aCoder encodeObject:_qcode forKey:@"qcode"];
    [aCoder encodeObject:_qcode_url forKey:@"qcode_url"];
    [aCoder encodeObject:_qcode_ticket forKey:@"qcode_ticket"];
    [aCoder encodeObject:_limit forKey:@"limit"];
    [aCoder encodeObject:_expiretime forKey:@"expiretime"];
    [aCoder encodeObject:_ip forKey:@"ip"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_country forKey:@"country"];
    [aCoder encodeObject:_province forKey:@"province"];
    [aCoder encodeObject:_language forKey:@"language"];
    [aCoder encodeObject:_headimgurl forKey:@"headimgurl"];
    [aCoder encodeObject:_newheadimgurl forKey:@"newheadimgurl"];
    [aCoder encodeObject:_img forKey:@"img"];
    [aCoder encodeObject:_img_s forKey:@"img_s"];
    [aCoder encodeObject:_img_m forKey:@"img_m"];
    [aCoder encodeObject:_img_b forKey:@"img_b"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_birthday forKey:@"birthday"];
    [aCoder encodeObject:_affiliate forKey:@"affiliate"];
    [aCoder encodeObject:_addtime forKey:@"addtime"];
    [aCoder encodeObject:_info forKey:@"info"];
    [aCoder encodeObject:_updatetime forKey:@"updatetime"];
    [aCoder encodeObject:_is_on forKey:@"is_on"];
    [aCoder encodeObject:_send forKey:@"send"];
    [aCoder encodeObject:_level forKey:@"level"];
    [aCoder encodeObject:_tel forKey:@"tel"];
    [aCoder encodeObject:_is_mb forKey:@"is_mb"];
    [aCoder encodeObject:_is_pwd forKey:@"is_pwd"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_ticket forKey:@"ticket"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}

/* 反归档 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        _name = [aDecoder decodeObjectForKey:@"name"];
        _nickname = [aDecoder decodeObjectForKey:@"nickname"];
        _pwd = [aDecoder decodeObjectForKey:@"pwd"];
        _pwd_bak = [aDecoder decodeObjectForKey:@"pwd_bak"];
        _type = [aDecoder decodeObjectForKey:@"type"];
        _subscribe = [aDecoder decodeObjectForKey:@"subscribe"];
        _membership = [aDecoder decodeObjectForKey:@"membership"];
        _openid = [aDecoder decodeObjectForKey:@"openid"];
        _unionid = [aDecoder decodeObjectForKey:@"unionid"];
        _user_money = [aDecoder decodeObjectForKey:@"user_money"];
        _user_duobao = [aDecoder decodeObjectForKey:@"user_duobao"];
        _all_money = [aDecoder decodeObjectForKey:@"all_money"];
        _user_jifen = [aDecoder decodeObjectForKey:@"user_jifen"];
        _user_quan = [aDecoder decodeObjectForKey:@"user_quan"];
        _qcode = [aDecoder decodeObjectForKey:@"qcode"];
        _qcode_url = [aDecoder decodeObjectForKey:@"qcode_url"];
        _qcode_ticket = [aDecoder decodeObjectForKey:@"qcode_ticket"];
        _limit = [aDecoder decodeObjectForKey:@"limit"];
        _expiretime = [aDecoder decodeObjectForKey:@"expiretime"];
        _ip = [aDecoder decodeObjectForKey:@"ip"];
        _sex = [aDecoder decodeObjectForKey:@"sex"];
        _city = [aDecoder decodeObjectForKey:@"city"];
        _country = [aDecoder decodeObjectForKey:@"country"];
        _province = [aDecoder decodeObjectForKey:@"province"];
        _language = [aDecoder decodeObjectForKey:@"language"];
        _headimgurl = [aDecoder decodeObjectForKey:@"headimgurl"];
        _newheadimgurl = [aDecoder decodeObjectForKey:@"newheadimgurl"];
        _img = [aDecoder decodeObjectForKey:@"img"];
        _img_s = [aDecoder decodeObjectForKey:@"img_s"];
        _img_m = [aDecoder decodeObjectForKey:@"img_m"];
        _img_b = [aDecoder decodeObjectForKey:@"img_b"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _birthday = [aDecoder decodeObjectForKey:@"birthday"];
        _affiliate = [aDecoder decodeObjectForKey:@"affiliate"];
        _addtime = [aDecoder decodeObjectForKey:@"addtime"];
        _info = [aDecoder decodeObjectForKey:@"info"];
        _updatetime = [aDecoder decodeObjectForKey:@"updatetime"];
        _is_on = [aDecoder decodeObjectForKey:@"is_on"];
        _send = [aDecoder decodeObjectForKey:@"send"];
        _level = [aDecoder decodeObjectForKey:@"level"];
        _tel = [aDecoder decodeObjectForKey:@"tel"];
        _is_mb = [aDecoder decodeObjectForKey:@"is_mb"];
        _is_pwd = [aDecoder decodeObjectForKey:@"is_pwd"];
        _token = [aDecoder decodeObjectForKey:@"token"];
        _ticket = [aDecoder decodeObjectForKey:@"ticket"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}

@end




























































