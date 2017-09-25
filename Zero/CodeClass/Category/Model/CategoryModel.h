//
//  CategoryModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryModel : BaseModel

/*
 "id": "2913",
 "name": "女装",
 "cat_id": "325",
 "p_id": "430",
 "img": "http://7xp28h.com1.z0.glb.clouddn.com/comment0gow_5755381b05efd"
 
 */

@property (nonatomic, copy) NSString *pr_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *cat_id;

@property (nonatomic, copy) NSString *p_id;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *img_b;

@end
