//
//  AddAndSubNumTableViewCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "AddAndSubNumTableViewCell.h"

@implementation AddAndSubNumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)subNum:(UIButton *)sender {
    
    if (self.subNumBlock) {
        
        self.subNumBlock();
    }
}

- (IBAction)addNum:(UIButton *)sender {
    
    if (self.addNumBlock) {
        
        self.addNumBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
