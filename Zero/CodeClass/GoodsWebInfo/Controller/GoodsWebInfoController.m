//
//  GoodsWebInfoController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "GoodsWebInfoController.h"

@interface GoodsWebInfoController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSMutableString *htmlStr;

@property (nonatomic, assign) BOOL isLoadFinished;

@end

@implementation GoodsWebInfoController

- (NSMutableString *)htmlStr {
    
    if (_htmlStr == nil) {
        
        self.htmlStr = [NSMutableString string];
    }
    
    return _htmlStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isLoadFinished = NO;
    
    self.webView.delegate = self;
    
    [self.webView loadHTMLString:self.product_description baseURL:nil];
    
    /* 第一次加载先隐藏 */
    [self.webView setHidden:YES];
    
    /* 设置web自适应 */
    [self.webView setScalesPageToFit:NO];
}

#pragma mark --- webview代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (self.isLoadFinished == YES) {
        
        /* 如果已经加载完毕，直接返回 */
        [self.webView setHidden:NO];
        
        return;
    }
    
    /* 获取body宽度 */
    NSString *bodyWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
    
    NSInteger intWidth = [bodyWidth integerValue];
    
    /* 获取实际要显示的html */
    NSString *html = [self htmlAdjustWithPageWidth:intWidth html:self.product_description webview:self.webView];
    
    self.isLoadFinished = YES;
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end













































