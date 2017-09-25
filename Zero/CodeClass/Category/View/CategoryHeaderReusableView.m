//
//  CategoryHeaderReusableView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryHeaderReusableView.h"

@implementation CategoryHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLB.layer.borderWidth = 1;
    self.titleLB.layer.borderColor = [UIColor blackColor].CGColor;
    
}

@end
