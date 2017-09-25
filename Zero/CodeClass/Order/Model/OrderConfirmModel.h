//
//  OrderConfirmModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface OrderConfirmModel : BaseModel

/*
 "id": "6224487",
 "uid": "40570758",
 "name": "黄郑果",
 "tel": "15515953732",
 "email": "",
 "zip": "",
 "province": "河南",
 "city": "郑州市",
 "area": "中原区",
 "town": "",
 "address": "牡丹路西雅图一期",
 "addtime": "1472349528",
 "updatetime": "",
 "is_on": "1",
 "is_far": 0
 */

@property (nonatomic, copy) NSString *s_id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *town;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *is_on;
@property (nonatomic, copy) NSString *is_far;

@end








































