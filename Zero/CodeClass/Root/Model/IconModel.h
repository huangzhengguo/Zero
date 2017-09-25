//
//  IconModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface IconModel : BaseModel

/*
 "url": "xxxx",
 "title": "特卖推荐",
 "img": "http://7xt1hu.com1.z0.glb.clouddn.com/14703929281234.png"
 */

/* url链接 */
@property (nonatomic, copy) NSString *url;

/* 标题 */
@property (nonatomic, copy) NSString *title;

/* 图标 */
@property (nonatomic, copy) NSString *img;

@end
