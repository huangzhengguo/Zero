//
//  DoubleMenuView.h
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleMenuView : UIView

- (UIView *)createDoubleMenuViewWithTitle:(NSArray *)titleArray img:(NSArray *)imgArray secondTitle:(NSDictionary *)secondTitleArray firstBackgroundColor:(UIColor *)firstColor secondBackgroundColor:(UIColor *)secondColor fisrtFrame:(CGRect)firstFrame secondFrame:(CGRect)secondFrame firstBtnSize:(CGSize)firstBtnSize secondBtnSize:(CGSize)secondBtnSize firstBtnSelectColor:(UIColor *)firstBtnSelectColor secondBtnSelectColor:(UIColor *)secondBtnSelectColor;

@end
