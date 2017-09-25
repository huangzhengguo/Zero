//
//  IconModel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "IconModel.h"

@implementation IconModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"image"]) {
        
        self.img = value;
    }
}

@end
