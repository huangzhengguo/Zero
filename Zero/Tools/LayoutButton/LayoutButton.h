//
//  LayoutButton.h
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LayoutButton : NSObject

+ (CGRect)calculateFrameWithButtonCount:(NSInteger)count buttonIndex:(NSInteger)index buttonHeight:(NSInteger)height buttonHSpace:(NSInteger)hHpace buttonVSpace:(NSInteger)vSpace;

@end
