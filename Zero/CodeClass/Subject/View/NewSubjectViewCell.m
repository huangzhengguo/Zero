//
//  NewSubjectViewCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NewSubjectViewCell.h"

@implementation NewSubjectViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)setCellWithGoodsModel:(SubjectGoodsDesModel *)goodsModel{
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[goodsModel.default_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",goodsModel.goods_name];
    self.desLabel.text = [NSString stringWithFormat:@"%@",goodsModel.goods_des];
    
    NSAttributedString *attStr = [StrikeForLabel addStrikeToLabel:[NSString stringWithFormat:@"￥%@",goodsModel.scPrice]];
    
    
    self.scPriceLabel.attributedText = attStr;
    self.scPriceLabel.font = [UIFont systemFontOfSize:12];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",goodsModel.Price];
    self.priceLabel.textColor = [UIColor orangeColor];
}

@end
