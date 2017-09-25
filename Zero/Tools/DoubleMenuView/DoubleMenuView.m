//
//  DoubleMenuView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//
/* 
 * 本类实现双层菜单
 *
 */


#import "DoubleMenuView.h"

@implementation DoubleMenuView


- (UIView *)createDoubleMenuViewWithTitle:(NSArray *)titleArray img:(NSArray *)imgArray secondTitle:(NSDictionary *)secondTitleArray firstBackgroundColor:(UIColor *)firstColor secondBackgroundColor:(UIColor *)secondColor fisrtFrame:(CGRect)firstFrame secondFrame:(CGRect)secondFrame firstBtnSize:(CGSize)firstBtnSize secondBtnSize:(CGSize)secondBtnSize firstBtnSelectColor:(UIColor *)firstBtnSelectColor secondBtnSelectColor:(UIColor *)secondBtnSelectColor {
    
    UIView *doubleMenuView = [[UIView alloc] init];
    
    /* 设置整个菜单的frame */
    doubleMenuView.frame = CGRectMake(firstFrame.origin.x, firstFrame.origin.y, KWIDTH, firstFrame.size.height + secondFrame.size.height);
    
    /* 创建一级菜单 */
    //UIScrollView *firstScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(firstFrame.origin.x, firstFrame.origin.y, KWIDTH, firstFrame.size.height)];
    
    /* 循环创建 */
//    for (NSString *firstTitle in titleArray) {
//        
//        //
//    }
    
    return doubleMenuView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


















































