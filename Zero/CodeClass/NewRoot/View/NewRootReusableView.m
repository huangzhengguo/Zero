//
//  NewRootReusableView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NewRootReusableView.h"

@implementation NewRootReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, KWIDTH, 150);
    
    /* 使用占位图片创建轮播图 */
    self.cycScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:self placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    [self addSubview:self.cycScrollView];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    /* 需要把index传递出去 */
    if (self.cycBlock) {
        
        self.cycBlock(index);
    }
}

@end
