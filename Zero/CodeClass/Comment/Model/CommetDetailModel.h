//
//  CommetDetailModel.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseModel.h"

@interface CommetDetailModel : BaseModel

/*
 "currentPage": 1,
 "pageCount": 1,
 "commentCount": 14,
 */

@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *pageCount;
@property (nonatomic, copy) NSString *commentCount;

@end
