//
//  CategoryListDataModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryListDataModel : BaseModel

/*
 
 "id": "2912",
 "name": "服装鞋包",
 "cat_id": "430",
 "p_id": "0",
 "img": "http://7xp28h.com1.z0.glb.clouddn.com/comment0gow_57171c6d981eb",
 
 */

@property (nonatomic, copy) NSString *pro_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cat_id;
@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *img;


@end
