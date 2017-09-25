//
//  OrderConfirmModel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "OrderConfirmModel.h"

@implementation OrderConfirmModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.s_id = value;
    }
}

@end
