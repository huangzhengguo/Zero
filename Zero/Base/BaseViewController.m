//
//  BaseViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark --- 公共的方法可以在基类中实现，子类就可以直接使用

#pragma mark --- 弹出文本提示
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    /* 根据文本内容弹出提示框 */
    /*
     * 参数1：标题，显示的信息，字在上面，比较大
     * 参数2：信息，字体比较小，在下面
     */
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    /* 添加按钮 */
    /*
     * 参数1：按钮文本
     * 参数2：按钮点击处理
     */
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       /* 由于只是文字提示，所以不用做任何处理 */
    }];
    
    /* 添加按钮到提示框上面 */
    [alertVC addAction:alertAction];
    
    /* 模态显示提示框 */
    [self presentViewController:alertVC animated:YES completion:^{
        
        
    }];
}

/* 根据字符串 字体 宽度获取label的高度 */
- (CGFloat)getHeigtWithTitle:(NSString *)title font:(UIFont *)font width:(float)width {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    
    [label sizeToFit];
    
    CGFloat height = label.frame.size.height;
    
    return height;
}

/* 网页自适应 */
- (NSString *)htmlAdjustWithPageWidth:(CGFloat)pageWidth
                                 html:(NSString *)html
                              webview:(UIWebView *)webview {
    
    NSMutableString *str = [NSMutableString stringWithString:html];
    
    /* 计算要缩放的比例 */
    CGFloat initialScale = webview.frame.size.width / pageWidth;
    
    /* 将<head>替换为mate+head */
    NSString *headString = [NSString stringWithFormat:@"<head><meta name=\"viewport\" content=\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\"></head>",initialScale];
    
    /* 替换 */
    str = [[NSString stringWithFormat:@"%@%@",headString,str] mutableCopy];
    
    return str;
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












































