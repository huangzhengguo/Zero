//
//  SuggestProductCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "SuggestProductCell.h"

@implementation SuggestProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    /* 设置tag值 */
    self.oneLB.tag = 1001;
    self.twoLB.tag = 1002;
    self.threeLB.tag = 1003;
    self.fourLB.tag = 1004;
    self.fiveLB.tag = 1005;
    self.sixLB.tag = 1006;
    self.sevenLB.tag = 1007;
    self.eightLB.tag = 1008;
    
    self.oneImg.tag = 1009;
    self.twoImg.tag = 1010;
    self.threeImg.tag = 1011;
    self.fourImg.tag = 1012;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setArray:(NSArray *)array {
    
    for (int i=0;i<array.count;i++) {
        
        ClotheModel *model = array[i];
        UILabel *lbOne = [self viewWithTag:(1000 + i + 1)];
        
        lbOne.text = model.title;
    }
    
    for (int i=0;i<array.count;i++) {
        
        ClotheModel *model = array[i];
        UILabel *lbOne = [self viewWithTag:(1000 + i + 5)];
        
        lbOne.text = model.title;
    }
    
    for (int i=0;i<array.count;i++) {
        
        ClotheModel *model = array[i];
        UIImageView *imgView = [self viewWithTag:(1000 + 9 + i)];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:[model.img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    }
}

@end

















