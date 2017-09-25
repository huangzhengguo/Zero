//
//  XRImage.m
//  Zero
//
//  Created by 黄郑果 on 16/9/4.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "XRImage.h"

@implementation XRImage


#pragma mark --- 初始化方法
+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic {
    
    XRImage *image = [[XRImage alloc] init];
    
    image.imageURL = [NSURL URLWithString:[imageDic[@"img"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    image.imageH = [imageDic[@"h"] floatValue];
    image.imageW = [imageDic[@"w"] floatValue];
    
    return image;
}

@end
