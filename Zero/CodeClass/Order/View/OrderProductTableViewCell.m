//
//  OrderProductTableViewCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "OrderProductTableViewCell.h"

@implementation OrderProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderConfirmModel:(ZuInfoModel *)orderConfirmModel {
    
    //[self.imgView sd_setImageWithURL:[NSURL URLWithString:[orderConfirmModel.thumbnail_s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    
    //self.titleLabel.text = [NSString stringWithFormat:@"%@",orderConfirmModel.goods_name];
    if (orderConfirmModel.spec_1Attr && orderConfirmModel.spec_2Attr) {
        
        self.atrrLabel.text = [NSString stringWithFormat:@"%@ %@",orderConfirmModel.spec_1Attr,orderConfirmModel.spec_2Attr];  
    }

    //self.priceLabel.text = [NSString stringWithFormat:@"￥%@",orderConfirmModel.Price];
    //self.wlPriceLabel.text = [NSString stringWithFormat:@"物流费￥%0"];
}

@end
