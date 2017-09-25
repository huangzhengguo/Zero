//
//  SetMenuButton.m
//  Zero
//
//  Created by 黄郑果 on 16/9/5.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "SetMenuButton.h"

@implementation SetMenuButton

+ (UIButton *)setButtonWithLastSelectButtonTag:(NSInteger)tag currentButtunTag:(NSInteger)currentTag superView:(UIView *)superView normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    /* 设置上次选择的button为未选中 */
    UIButton *lastButton = [superView viewWithTag:tag];
    if (lastButton) {
        
        lastButton.selected = NO;
    }
    
    [lastButton setTitleColor:normalColor forState:UIControlStateNormal];
    [lastButton setTitleColor:selectedColor forState:UIControlStateSelected];
    
    /* 设置当前button为选中 */
    UIButton *curentButton = [superView viewWithTag:currentTag];
    if (curentButton) {
        
        curentButton.selected = YES;
    }
    
    [curentButton setTitleColor:normalColor forState:UIControlStateNormal];
    [curentButton setTitleColor:selectedColor forState:UIControlStateSelected];
    
    return curentButton;
}

@end
