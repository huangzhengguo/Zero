//
//  ImageBackgroundColor.m
//  Zero
//
//  Created by 黄郑果 on 16/8/29.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ImageBackgroundColor.h"

@implementation ImageBackgroundColor

+ (UIImage *)ImageWithColor:(UIColor *)backgroundColor {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
