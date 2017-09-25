//
//  SetMenuButton.h
//  Zero
//
//  Created by 黄郑果 on 16/9/5.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetMenuButton : NSObject

+ (UIButton *)setButtonWithLastSelectButtonTag:(NSInteger)tag currentButtunTag:(NSInteger)currentTag superView:(UIView *)superView normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end
