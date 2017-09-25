//
//  LayoutButton.m
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "LayoutButton.h"

@implementation LayoutButton

+ (CGRect)calculateFrameWithButtonCount:(NSInteger)count buttonIndex:(NSInteger)index buttonHeight:(NSInteger)height buttonHSpace:(NSInteger)hHpace buttonVSpace:(NSInteger)vSpace {
    
    CGRect frame;
    
    NSInteger remind = index % count;
    NSInteger lines = index / count;
    NSInteger width = (KWIDTH - (count + 1) * hHpace) / count;
    
    /* fram x坐标:说明：按钮前面有remind + 1个空格，有remind个按钮 */
    frame.origin.x = (remind + 1) * hHpace + remind * width;
    
    /* frame y坐标 */
    frame.origin.y = (2 * lines + 1) * vSpace + lines * height;
    
    /* 宽度 */
    frame.size.width = width;
    
    /* 高度 */
    frame.size.height = height;
    
    return frame;
}

@end
