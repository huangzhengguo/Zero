//
//  UserInfoManager.h
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserInfoModel.h"

@interface UserInfoManager : NSObject

/* 声明单例方法 */
+ (UserInfoManager *)shareUserInfoManager;

/* 保存用户信息 */
- (void)saveUserInfo:(UserInfoModel *)model;

/* 清除用户信息 */
- (void)clearUserInfo;

/* 获取用户信息 */
- (UserInfoModel *)getUserInfo;

/* 判断用户是否已经登录 */
- (BOOL)isUserLogin;

@end
