//
//  ProductDetailHeaderView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ProductDetailHeaderView.h"

@implementation ProductDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /* 设置视图大小 */
    self.frame = CGRectMake(0, 0, KWIDTH, 150);
    self.backgroundColor = [UIColor redColor];
    /* 使用占位图片初始化轮播图 */
    self.cycScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:self placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    /* 添加到头视图 */
    [self addSubview:self.cycScrollView];
}

#pragma mark --- 点击轮播图片方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    //NSLog(@"%ld",index);
}

@end
