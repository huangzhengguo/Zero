//
//  ColorBigPatternCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ColorBigPatternCell.h"

@implementation ColorBigPatternCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ColorArticleModel *)model {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[model.imgs_1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
}

@end
