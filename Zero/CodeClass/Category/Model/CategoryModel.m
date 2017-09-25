//
//  CategoryModel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.pr_id = value;
    }
}

@end
