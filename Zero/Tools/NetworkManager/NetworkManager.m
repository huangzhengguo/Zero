//
//  NetworkManager.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NetworkManager.h"

/* 导入第三方网络请求 */
#import <AFNetworking.h>

@implementation NetworkManager

+ (void)getRequestWithUrl:(NSString *)url param:(NSDictionary *)param success:(void (^)(id))success fail:(void (^)(NSError *error))fail {
    
    /* 获取网络会话管理对象 */
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    /* 设置请求可接受的类型 */
    
    /* 设置可接收的返回的数据的类型
     * 1.设置可接收html数据
     * 2.设置可接受json类型的数据
     */
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"applicaton/json",@"text/json", nil];
    
    [sessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /* 请求数据成功 */
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /* 处理错误 */
        fail(error);
    }];
}

+(void)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param success:(void (^)(id))success fail:(void (^)(NSError *error))fail {
    
    /* 获取网络会话管理对象 */
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json",@"text/json",nil];

    /* 发起POST请求 */
    [sessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /* POST请求成功 */
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        /* 处理错误 */
        fail(error);
    }];
}

@end













































