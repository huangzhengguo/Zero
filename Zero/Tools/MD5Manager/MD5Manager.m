//
//  MD5Manager.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "MD5Manager.h"

/* 引入加密库文件 */
#import <CommonCrypto/CommonCrypto.h>

@implementation MD5Manager

/* 使用MD5加密字符串:声明为类方法 */
+ (NSString *)encryptStringWithMD5:(NSString *)str {
    
    /* 1.把要加密的字符串转换为c串 */
    const char *cStr = [str UTF8String];
    
    /* 2.声明存储加密后的字符数组 */
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    /* 3.使用MD5加密 */
    /*
     * 参数1:要加密的字符串
     * 参数2：要加密字符串的长度
     * 参数3：存放加密结果的字符数组
     */
    CC_MD5(cStr,(CC_LONG)strlen(cStr),result);
    
    /* 4.把MD5加密结果转换成16进制表示 */
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
        
        [resultStr appendFormat:@"%02X",result[i]];
    }
    
    return resultStr;
}

@end























