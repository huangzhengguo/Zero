//
//  CategoryListDataModel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryListDataModel.h"

@implementation CategoryListDataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.pro_id = value;
    }
}

@end
