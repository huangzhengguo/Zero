//
//  ClotheModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface ClotheModel : BaseModel

/*
 "url": "http://www.0gow.com/category/index?id=332&pid=324",
 "title": "箱包",
 "stitle": "新潮看我",
 "img": "http://7xt1hu.com1.z0.glb.clouddn.com/1470734070箱包.png"
 
 */

/* url链接 */

@property (nonatomic, copy) NSString *url;

/* 标题 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *stitle;

/* 图标 */
@property (nonatomic, copy) NSString *img;

@end
