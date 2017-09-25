//
//  NewProductCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NewProductCell.h"

@implementation NewProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GoodsPublicModel *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[model.default_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.Price];
    
    /* 设置原价为中划线模式 */
    NSAttributedString *attStr = [StrikeForLabel addStrikeToLabel:[NSString stringWithFormat:@"%@",model.scPrice]];
    self.scPriceLabel.attributedText = attStr;
    self.scPriceLabel.textColor = [UIColor orangeColor];
    
    self.viewLabel.text = [NSString stringWithFormat:@"%@",model.view];
    
}

@end
