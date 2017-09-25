//
//  ArticleViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSMutableDictionary *paramDic;

@property (nonatomic, strong) NSString *articleContent;

/* 标记网页是否已经加载完毕 */
@property (nonatomic, assign) BOOL isLoadFinished;

@end

@implementation ArticleViewController

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* webview相关 */
    self.isLoadFinished = NO;
    self.webView.delegate = self;
    [self.webView setHidden:YES];
    self.webView.scalesPageToFit = NO;
    
    if ([[NSString stringWithFormat:@"%@",self.class_id] isEqualToString:@"103"]) {
        
        self.title = @"快乐分享";
    }else if ([[NSString stringWithFormat:@"%@",self.class_id] isEqualToString:@"102"]) {
        
        self.title = @"生活百科";
    }else {
        
        self.title = @"美文悦读";
    }
    
    self.paramDic = [@{@"action":@"getArticle",@"id":self.article_id} mutableCopy];
    [self requestData];
}

- (void)requestData {
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        self.articleContent = responseObject[@"article"][@"content"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 加载html数据 */
            [self.webView loadHTMLString:self.articleContent baseURL:nil];
            
            /* 第一次加载网页需要隐藏掉 */
            [self.webView setHidden:YES];
        });
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- webview代理方法，
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (self.isLoadFinished == YES) {
        
        /* 设置webview可见，并返回 */
        [self.webView setHidden:NO];
        return;
    }
    
    /* 完善html代码之后再次加载 */
    /* 获取网页宽度 */
    NSString *bodyWidthStr = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
    NSInteger bodyWidthInt = [bodyWidthStr integerValue];
    
    /* 获取要显示的html */
    NSString *html = [self htmlAdjustWithPageWidth:bodyWidthInt html:self.articleContent webview:self.webView];
    
    self.isLoadFinished = YES;
    
    /* 重新加载html */
    [self.webView loadHTMLString:html baseURL:nil];
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































