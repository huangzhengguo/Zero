//
//  XRImage.h
//  Zero
//
//  Created by 黄郑果 on 16/9/4.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XRImage : NSObject

/* 图片url地址 */
@property (nonatomic, strong) NSURL *imageURL;

/* 图片宽度 */
@property (nonatomic, assign) CGFloat imageW;

/* 图片高度 */
@property (nonatomic, assign) CGFloat imageH;

/* 初始化方法 */
+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic;

@end
