//
//  SubjectCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NewSubjectCell.h"
#import "NewSubjectGoodsModel.h"

@implementation NewSubjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /* 给按钮添加手势 */
    for (int i=0;i<5;i++) {
        
        UIButton *btn = [self viewWithTag:1000 + i];
        
        [btn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)imgBtnClick:(UIButton *)sender {
    
    /* 传递tag出去 */
    if (self.imgBtnBlock) {
        
        self.imgBtnBlock(sender.tag - 1000);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithBigImgModel:(NewSubjectModel *)model goodsArray:(NSArray *)array {
    
    [self.bigImgButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[model.banner stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    self.titileLabel.text = [NSString stringWithFormat:@"%@",model.title];
    self.goodsCountLabel.text = [NSString stringWithFormat:@"商品:%@",model.goods_count];
    
    for (int i=0;i<array.count;i++) {
        
        UIButton *btn = [self viewWithTag:1000+i];
        NewSubjectGoodsModel *model = array[i];
        
        /* 要设置背景图片，设置图片会变成蓝色，图片显示不出来 */
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[model.default_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    }
}

@end
































