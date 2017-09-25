//
//  MyselfModel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "MyselfModel.h"

@implementation MyselfModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.uid = value;
    }
}

@end
