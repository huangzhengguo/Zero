//
//  TabBarViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "TabBarViewController.h"

#import "LoginAndRegisterViewController.h"

#import "MainViewController.h"

#import "UserInfoManager.h"

@interface TabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /* 获取tabbar */
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    tabBar.delegate = self;
    self.delegate = self;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    /* 返回是否应该选择item */
    if ([tabBarController.tabBar.selectedItem.title isEqualToString:@"我的"]) {
        
        /* 如果用户没有登录 */
        if ([[UserInfoManager shareUserInfoManager] getUserInfo] == nil) {
            
            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            LoginAndRegisterViewController *loginAndRegisterVC = [mainStory instantiateViewControllerWithIdentifier:@"LoginAndRegisterViewController"];
            
            /* 模态出登录界面 */
            [self presentViewController:loginAndRegisterVC animated:YES completion:^{
                
                
            }];
            
            return NO;
        }
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


































