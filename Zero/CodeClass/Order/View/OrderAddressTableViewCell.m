//
//  OrderAddressTableViewCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "OrderAddressTableViewCell.h"

@implementation OrderAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(OrderConfirmModel *)model {
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@",model.tel];
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.address];
}

@end
