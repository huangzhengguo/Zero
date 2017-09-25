//
//  UserCommentCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "UserCommentCell.h"

@implementation UserCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImg.layer.cornerRadius = self.headImg.frame.size.height / 2;
    self.headImg.layer.masksToBounds = YES;
    
    self.viewAllBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.viewAllBtn.layer.borderWidth = 1;
}

#pragma mark --- 点击查看全部评论
- (IBAction)lookAllComment:(UIButton *)sender {
    
    if (self.btnClikcBlock) {
        
        /* 如果block不为空就调用block */
        self.btnClikcBlock();
    }
}

#pragma mark --- 设置
- (void)setCellWithModel:(UserCommentModel *)model hpl:(NSString *)hpl tsl:(NSString *)tsl {
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[model.img_s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    
    self.nameLB.text = [NSString stringWithFormat:@"%@",model.name];
    
    if ([[NSString stringWithFormat:@"%@",model.rate] isEqualToString:@"1"]) {
        
       self.rateLB.text = @"好评";
    }else {
        
        self.rateLB.text = @"差评";
    }
    
    self.addtimeLB.text = [NSString stringWithFormat:@"%@",model.addtime];
    
    self.bodyLB.text = [NSString stringWithFormat:@"%@",model.body];
    
    self.hplLB.text = [NSString stringWithFormat:@"%@%%",hpl];
    self.tslLB.text = [NSString stringWithFormat:@"%@%%",tsl];
}

- (void)cellAutoLayoutHeight:(NSString *)str {
    
    self.bodyLB.lineBreakMode = NSLineBreakByWordWrapping;
    
    /* 使用方法获取frame中的宽度 */
    self.bodyLB.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLB.frame);
    
    /* 赋值 */
    self.bodyLB.text = str;
}

@end







































