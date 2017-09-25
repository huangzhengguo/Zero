//
//  AppDelegate.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "AppDelegate.h"

#import "UserInfoManager.h"

/* 引入友盟社会化头文件 */
#import <UMSocialWechatHandler.h>
/* 引入qq处理头文件 */
#import <UMSocialQQHandler.h>

#import <UMSocialSinaSSOHandler.h>

#import <UMSocial.h>

/* 科大讯飞 */
#import <iflyMSC/iflyMSC.h>

/* 引入环信SDK */
#import <EMSDK.h>

/* 支付宝功能 */
#import <AlipaySDK/AlipaySDK.h>

#define IFLYAPPID @"57c68d81"
#define EMAPPKEY @"huangguoguo#guoguo"

@interface AppDelegate ()

/* 用来显示启动视图 */
@property (nonatomic, strong) UIView *ADView;

@property (nonatomic, strong) NSString *pictureURL;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /* 抓取到的微信登录信息
     * 用户id:5472597448
     * Appkey:12fa85998895c98eb4ad4b79
     */
    
    /* 设置app_key：获取到appkey */
    [UMSocialData setAppKey:@"57c39ede67e58ead07001040"];
    
    /* 添加微信分享代码：零购官网的AppId：wxcf76715f7ae681c2 */
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    /* 添加QQ分享设置 */
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    /* 设置新浪微博 */
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    /* 隐藏未安装软件的分享 */
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    /* 语音识别部分 */
    /* 创建语音配置 */
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",IFLYAPPID];
    
    [IFlySpeechUtility createUtility:initString];
    
    
    /* 配置环信 
     * Appkey环信后台注册的Appkey
     */
    EMOptions *options = [EMOptions optionsWithAppkey:EMAPPKEY];
    
    //options.apnsCertName = @"istore_dev"; 推送证书，此处不需要
    
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    /* 使当前窗口称为主窗口并显示 */
    [self.window makeKeyAndVisible];
    
    /* 加载启动视图:也可以使用nib文件 */
    //self.ADView = [[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil] firstObject];
    self.ADView = [[UIView alloc] initWithFrame:self.window.frame];
    /* 设置view的大小和当前窗口大小相同 */
    //self.ADView.frame = self.window.frame;
    
    /* 创建imgview用来展示图片 */
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.window.frame];
    
    /*  */
   [imgView sd_setImageWithURL:[NSURL URLWithString:self.pictureURL] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    
    /* 网络请求启动图片 */
    [NetworkManager getRequestWithUrl:ZEROURL param:@{@"action":@"getAppad"} success:^(id responseObject) {
        
        self.pictureURL = responseObject[@"list"][0][@"url"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           /* 主线程设置图片 */
            /* 给img添加网络图片 */
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.pictureURL] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
            
        });
        
    } fail:^(NSError *error) {
        
        
    }];
    
    /* 添加视图 */
    [self.ADView addSubview:imgView];
    [self.window addSubview:self.ADView];
    
    [self.window bringSubviewToFront:self.ADView];
    
    /* 添加定时器，设置启动画面的时长 */
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeADView) userInfo:nil repeats:NO];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == NO) {
        
        if ([url.host isEqualToString:@"safepay"]) {
            
            /* 处理支付结果 */
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                
                
                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                    
                    NSLog(@"支付成功");
                }else {
                    
                    /* 处理订单的其他状态 */
                }
                
            }];
        }
    }
    
    return YES;
}

#pragma mark - 移除广告View
-(void)removeADView
{
    [self.ADView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    /* App进入后台 */
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    /* App返回前台 */
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    /* 在程序将要结束的时候清除用户信息 */
    [[UserInfoManager shareUserInfoManager] clearUserInfo];
    
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "huangzhengguo.Zero" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Zero" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Zero.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
