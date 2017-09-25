//
//  ColorSmallPatternCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ColorSmallPatternCell.h"

@implementation ColorSmallPatternCell

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

#pragma mark --- 自适应label
- (void)autoAdjustLableHeight:(ColorArticleModel *)model {
    
    /* 设置图片 */
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[model.imgs_1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    
    /* 设置linebreakmode */
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    /* 设置label宽度自动变化 */
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.frame);
    
    self.titleLabel.text = model.title;

}

@end






























