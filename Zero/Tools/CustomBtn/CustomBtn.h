//
//  CustomBtn.h
//  VTravel
//
//  Created by lanouhn on 16/8/3.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBtn : UIButton
/**
 frame button大小
 imgArr  图片
 titleArr 标签名字数组
 */
-(instancetype)initWithFrame:(CGRect)frame imageNameArr:(NSString *)imgStr LBTitleArr:(NSString *)titlrStr;

- (instancetype)initWithFrame:(CGRect)frame imageUrlArr:(NSString *)imgUrlStr LBTitleArr:(NSString *)titlrStr;

@end
