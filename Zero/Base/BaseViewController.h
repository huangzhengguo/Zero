//
//  BaseViewController.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/* 声明公用方法 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

/* 获取label高度 */
- (CGFloat)getHeigtWithTitle:(NSString *)title font:(UIFont *)font width:(float)width;

/* 网页自适应:
 * pageWidth:页面宽度
 * html:代码：这个App的html代码不包含<head>标签，如果包含的话需要重新写这个方法
 * weiview：需要适配的webview控件
 */
- (NSString *)htmlAdjustWithPageWidth:(CGFloat)pageWidth
                                 html:(NSString *)html
                              webview:(UIWebView *)webview;

@end
