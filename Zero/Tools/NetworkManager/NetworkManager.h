//
//  NetworkManager.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 网络请求封装 */
@interface NetworkManager : NSObject

/* 声明为类方法，直接使用类名调用接口 */

/* 封装GET请求 */
/* 参数:
 * 参数1：url字符串
 * 参数2：请求参数
 * 参数3：请求成功的回调
 * 参数4：请求失败的回调
*/
+ (void)getRequestWithUrl:(NSString *)url
                    param:(NSDictionary *)param
                    success:(void(^)(id responseObject))success
                    fail:(void(^)(NSError *error))fail;

/* 封装POST请求 */
/* 参数:
 * 参数1：url字符串
 * 参数2：请求参数
 * 参数3：请求成功的回调
 * 参数4：请求失败的回调
 */
+ (void)postRequestWithUrl:(NSString *)url
                     param:(NSDictionary *)param
                     success:(void(^)(id responseObject))success
                     fail:(void(^)(NSError *error))fail;

@end
