//
//  MD5Manager.h
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Manager : NSObject

/* 使用MD5加密字符串:声明为类方法 */
+ (NSString *)encryptStringWithMD5:(NSString *)str;

@end
