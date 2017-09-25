//
//  GuessLikeCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "GuessLikeCell.h"

@interface GuessLikeCell() <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scro;

@end

@implementation GuessLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
     self.scro = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KWIDTH, 146) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    [self.scrollView addSubview:self.scro];
}

- (void)setScrollViewWithArray:(NSArray *)array {
    

    
    self.scro.imageURLStringsGroup = array;

    //cycleScrollViewWithFrame:CGRectMake(0, 0, KWIDTH, 146) imageURLStringsGroup:array];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
