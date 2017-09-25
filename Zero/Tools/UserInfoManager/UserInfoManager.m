//
//  UserInfoManager.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "UserInfoManager.h"

#define key @"USERINFO"

@implementation UserInfoManager

/* 实现单例 */
+ (UserInfoManager *)shareUserInfoManager {
    
    static UserInfoManager *userInfoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userInfoManager = [[UserInfoManager alloc] init];
    });
    
    return userInfoManager;
}

/* 保存用户信息 */
- (void)saveUserInfo:(UserInfoModel *)model {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSData *userInfoData = [NSKeyedArchiver archivedDataWithRootObject:model];
    
    [userDefault setObject:userInfoData forKey:key];
    
    /* 同步保存 */
    [userDefault synchronize];
}

- (UserInfoModel *)getUserInfo {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSData *userInfoData = [userDefault objectForKey:key];
    if (userInfoData == nil) {
        
        return nil;
    }
    
    UserInfoModel *userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];
    
    return userInfoModel;
}

- (void)clearUserInfo {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault removeObjectForKey:key];
    
    [userDefault synchronize];
}

- (BOOL)isUserLogin {
    
    if ([[UserInfoManager shareUserInfoManager] getUserInfo]) {
        
        return YES;
    }
    
    return NO;
}

@end































