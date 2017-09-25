//
//  GoodsInfoCollectionViewCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "GoodsInfoCollectionViewCell.h"

@implementation GoodsInfoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(RecommandModel *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[model.default_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.desLabel.text = [NSString stringWithFormat:@"%@",model.goods_des];
    
    /* 给原价设置中划线 */
    NSAttributedString *attStr = [StrikeForLabel addStrikeToLabel:[NSString stringWithFormat:@"￥%@",model.scPrice]];
    
    self.scPriceLabel.attributedText = attStr;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.Price];
}

@end
