//
//  ArticleModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleModel : BaseModel

/*
 "article_id": "523",
 "class_id": "102",
 "title": "夏天多吃这些菜，全家整年不生病！一定要多吃！",
 "imgs_1": "http://7xp28h.com1.z0.glb.clouddn.com/comment0gow_57917ce7bcd2d?imageMogr2/thumbnail/208x/strip/quality/75/format/jpg"
 */

/* id */
@property (nonatomic, strong) NSString *article_id;

/* class */
@property (nonatomic, strong) NSString *class_id;

/* 标题 */
@property (nonatomic, strong) NSString *title;

/* 图片 */
@property (nonatomic, strong) NSString *imgs_1;

@end
