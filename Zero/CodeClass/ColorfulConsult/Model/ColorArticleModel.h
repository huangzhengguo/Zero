//
//  ColorArticleModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface ColorArticleModel : BaseModel

/*
 "article_id": "672",
 "class_id": "102",
 "title": "那些被重男轻女的惨烈女子，她们都过得怎么样？",
 "des": "",
 "views": "8737",
 "cover_b": null,
 "cover_m": null,
 "cover_s": null,
 "addtime": "2016-08-24",
 "is_show": "1",
 "is_top": "1",
 "author": "",
 "pattern": "3",
 "imgs_1": "http://7xp28h.com1.z0.glb.clouddn.com/comment0gow_57bd196d52367?imageMogr2/thumbnail/208x/strip/quality/75/format/jpg",
 "imgs_2": null,
 "imgs_3": null,
 "url": "",
 "introduction": ""
 */
@property (nonatomic, copy) NSString *article_id;
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *cover_b;
@property (nonatomic, copy) NSString *cover_m;
@property (nonatomic, copy) NSString *cover_s;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *is_show;
@property (nonatomic, copy) NSString *is_top;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *pattern;
@property (nonatomic, copy) NSString *imgs_1;
@property (nonatomic, copy) NSString *imgs_2;
@property (nonatomic, copy) NSString *imgs_3;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *introduction;

@end



















