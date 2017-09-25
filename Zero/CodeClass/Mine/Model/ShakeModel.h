//
//  ShakeModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/29.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface ShakeModel : BaseModel

/*
 "iswin": true,
 "iswin_type": 2,
 "iswin_total": 0.02,
 "iswin_img": "",
 "iswin_txt": "获得0.02元零购券一张！",
 "total_num": 4,
 "left_num": 0,
 "left_txt": "客官！您今天还可以再摇 0次！",
 "is_shared": true,
 "share_url": "http://cdn.nameinet.cn/0ggw.html?v=0829&uid=40570758&isShake=1",
 "share_txt": "我在零购官网体验摇一摇功能，你还在等什么！一起来吧！"
 */

@property (nonatomic, copy) NSString *iswin;
@property (nonatomic, copy) NSString *iswin_type;
@property (nonatomic, copy) NSString *iswin_total;
@property (nonatomic, copy) NSString *iswin_img;
@property (nonatomic, copy) NSString *iswin_txt;
@property (nonatomic, copy) NSString *total_num;
@property (nonatomic, copy) NSString *left_num;
@property (nonatomic, copy) NSString *left_txt;
@property (nonatomic, copy) NSString *is_shared;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *share_txt;

@end










































