//
//  SubjectCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "SubjectCell.h"

#import "SubjectModel.h"

@implementation SubjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    /* 设置tag值 */
    self.imgTwoView.tag = 1000;
    self.imgThreeView.tag = 1001;
    self.imgFourView.tag = 1002;
    self.imgFiveView.tag = 1003;
    self.imgSixView.tag = 1004;
    self.imgSevenView.tag = 1005;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithArray:(NSArray *)array {
    
    for (int i=0;i<array.count;i++) {
        
        UIImageView *imgView = [self.contentView viewWithTag:(1000+i)];
        SubjectModel *model = array[i];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    }
}

@end






















