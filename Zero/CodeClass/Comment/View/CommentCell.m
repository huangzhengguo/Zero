//
//  CommentCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --- 配置cell
- (void)setModel:(CommentModel *)model {
    
    /* 删除tag值大于9999的label */
//    for (UIView *view in self.subviews) {
//        
//        if ([view isKindOfClass:[UILabel class]]) {
//            
//            UILabel *label = (UILabel *)view;
//            
//            if (label.tag > 9999) {
//                
//                [label removeFromSuperview];
//            }
//        }
//    }
    
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[model.img_s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    
    /* 圆形头像设置 */
    self.headerImg.layer.cornerRadius = self.headerImg.frame.size.height / 2;
    self.headerImg.layer.masksToBounds = YES;
    
    self.nickLabel.text = [NSString stringWithFormat:@"%@",model.nickname];
    self.rateLabel.text = [NSString stringWithFormat:@"%@",model.rate];
    self.addtimeLabel.text = [NSString stringWithFormat:@"%@",model.addtime];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.body];
    self.goodsLabel.text = [NSString stringWithFormat:@"%@",model.spec_des];
    
    /* 根据回复动态添加label */
//    NSInteger count = 0;
//    for (NSDictionary *dic in model.replys) {
//        
//        /* 创建label */
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.origin.y + count * 50, KWIDTH, 50)];
//        
//        label.backgroundColor = [UIColor grayColor];
//        label.tag = 10000 + count;
//        
//        [self addSubview:label];
//        
//        count ++;
//    }
    
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, KWIDTH, self.frame.size.height + count * 50);
}

@end





























