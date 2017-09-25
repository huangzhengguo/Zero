//
//  URLConfig.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#ifndef URLConfig_h
#define URLConfig_h

/* 定义全局宏 */

/* 屏幕宽高 */
#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

/* 随机颜色宏 */
/* arc4random_uniform(n)是产生0到n-1的随机数 */
#define RANDOMCOLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

/* 打印宏 */
#define KMYLOG(...) NSLog(__VA_ARGS__)

/* 接口宏部分 */
#define ZEROURL @"http://api.0gow.com/interface"

/* 首页猜你喜欢接口 */
#define ZEROURLLIKE @"http://api.0gow.com/site/indexlike"

/* 首页btn按钮的间距 */
#define BTNSPACE 20

/* BTN 区域高度*/
#define BTNAREAHEIGHT 100

/* 占位图片 */
#define PLACEHOLDERPATH @"placeholder.jpg"

/* 登录接口 */
#define LOGINURL @"http://api.0gow.com/interface"

#define WEBFIT @"<meta name='viewport' content='initial-scale=1.0, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\\'>"

#endif /* URLConfig_h */








































