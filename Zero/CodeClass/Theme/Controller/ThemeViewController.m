//
//  ThemeViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSMutableDictionary *paramDic;

@property (strong, nonatomic) NSString *htmlStr;

@end

@implementation ThemeViewController

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //UserInfoModel *userInfoModel = [[UserInfoManager shareUserInfoManager] getUserInfo];
    
    self.paramDic = [@{@"token":@"eyJ0Z19pZCI6NDA1NzA3NTh9"} mutableCopy];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.0gow.com/appsubject/112?token=eyJ0Z19pZCI6NDA1NzA3NTh9"]]];
    
    [self requestData];
    
}

/* 数据请求 */
- (void)requestData {
    
    [NetworkManager getRequestWithUrl:@"http://www.0gow.com/appsubject/112?token=eyJ0Z19pZCI6NDA1NzA3NTh9" param:@{} success:^(id responseObject) {
        
        self.htmlStr = responseObject;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.webView loadHTMLString:self.htmlStr baseURL:nil];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
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
