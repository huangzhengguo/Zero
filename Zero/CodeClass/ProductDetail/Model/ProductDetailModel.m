//
//  ProductDetailModel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"description"]) {
        
        self.product_description = value;
    }
}

@end
