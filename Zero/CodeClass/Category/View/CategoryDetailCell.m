//
//  CategoryDetailCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryDetailCell.h"

@implementation CategoryDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark --- 重写modelset方法，配置cell
- (void)setModel:(CategoryDetailModel *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.default_image]];
    
    self.titleLB.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.priceLB.text = [NSString stringWithFormat:@"￥%@",model.Price];
    
    /* 设置中划线 */
    NSAttributedString *attribtStr = [StrikeForLabel addStrikeToLabel:[NSString stringWithFormat:@"%@",model.scPrice]];
    self.scPriceLB.textColor = [UIColor grayColor];
    self.scPriceLB.attributedText = attribtStr;
}


@end
