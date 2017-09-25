//
//  ProductListCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ProductListCell.h"

@implementation ProductListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark --- 重写model
- (void)setModel:(RecommandModel *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.default_image]];
    self.titleLB.text = [NSString stringWithFormat:@"%@",model.goods_title];
    self.stitleLB.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.oldPriceLB.text = [NSString stringWithFormat:@"%@",model.scPrice];
    self.secondPriceLB.text = [NSString stringWithFormat:@"%@",model.wlPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
