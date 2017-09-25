//
//  DetailInfoCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "DetailInfoCell.h"

@implementation DetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ProductDetailModel *)model {
    
    self.Price.text = [NSString stringWithFormat:@"￥%@",model.Price];
    [self.Price setTextColor:[UIColor orangeColor]];
    [self.Price setFont:[UIFont systemFontOfSize:20]];
    
    NSDictionary *attributeDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.scPrice] attributes:attributeDic];
    
    
    self.scPriceLB.attributedText = attrStr;
    
    
    self.wlPriceLB.text = [NSString stringWithFormat:@"物流费%@元",model.wlPrice];
    self.goods_nameLB.text = [NSString stringWithFormat:@"%@",model.goods_name];
    self.goodsNowStockLB.text = [NSString stringWithFormat:@"库存%@件",model.goodsNowStock];
    self.zk_priceLB.text = [NSString stringWithFormat:@"拍立减%@元",model.zk_price];
    self.saleLB.text = [NSString stringWithFormat:@"已售出%@件",model.sale];
}

@end
