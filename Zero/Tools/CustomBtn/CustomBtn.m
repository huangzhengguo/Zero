//
//  CustomBtn.m
//  VTravel
//
//  Created by lanouhn on 16/8/3.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

-(instancetype)initWithFrame:(CGRect)frame imageNameArr:(NSString *)imgStr LBTitleArr:(NSString *)titlrStr{
    if (self = [super initWithFrame:frame]) {
        //创建图片对象
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.width)];
       
        imageV.image = [UIImage imageNamed:imgStr];
        [self addSubview:imageV];
        
        //创建label对象
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-15, frame.size.width + 20, frame.size.width + 30, frame.size.height - 20 - frame.size.width)];
       
        label.text = titlrStr;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageUrlArr:(NSString *)imgUrlStr LBTitleArr:(NSString *)titlrStr {
    
    if (self = [super initWithFrame:frame]) {
        //创建图片对象
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.width)];
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:[imgUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        [self addSubview:imageV];
        
        //创建label对象
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-15, frame.size.width + 20, frame.size.width + 30, frame.size.height - 20 - frame.size.width)];
        
        label.text = titlrStr;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
    }
    
    return self;
}

@end
