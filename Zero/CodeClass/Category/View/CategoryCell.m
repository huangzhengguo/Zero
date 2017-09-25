//
//  CategoryCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /* 设置label渐变色 */
    CAGradientLayer *layer = [CAGradientLayer layer];

    self.nameLB.backgroundColor = [UIColor clearColor];
    layer.frame = self.nameLB.frame;

    layer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor grayColor].CGColor, nil];
    
    [self.imgView.layer insertSublayer:layer atIndex:0];
    
}

- (void)setModel:(CategoryModel *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.img_b]];
    
    self.nameLB.text = [NSString stringWithFormat:@"%@",model.name];
}

@end