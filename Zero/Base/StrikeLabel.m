//
//  StrikeLabel.m
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "StrikeLabel.h"

@implementation StrikeLabel

- (instancetype)initStrikeLabelWithString:(NSString *)str {
    
    if (self = [super init]) {
        
        /* 构造中划线属性字典 */
        NSDictionary *attributeDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attributeDic];
        
        self.attributedText = attribtStr;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
