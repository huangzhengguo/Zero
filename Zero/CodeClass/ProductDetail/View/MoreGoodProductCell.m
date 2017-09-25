//
//  MoreGoodProductCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "MoreGoodProductCell.h"

@implementation MoreGoodProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


#pragma mark --- 设置cell
- (void)setModel:(MoreGoodProductModel *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[model.default_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    
    self.nameLB.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.priceLB.text = [NSString stringWithFormat:@"￥%@",model.Price];
    self.priceLB.textColor = [UIColor orangeColor];
    self.priceLB.font = [UIFont systemFontOfSize:20];
    
    NSAttributedString *attStr = [StrikeForLabel addStrikeToLabel:[NSString stringWithFormat:@"￥%@",model.scPrice]];
    
    self.scPriceLB.attributedText = attStr;
}

@end
