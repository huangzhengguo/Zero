//
//  StrikeForLabel.m
//  Zero
//
//  Created by 黄郑果 on 16/9/5.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "StrikeForLabel.h"

@implementation StrikeForLabel

+ (NSAttributedString *)addStrikeToLabel:(NSString *)str {
    
    /* 属性字典 */
    NSDictionary *attDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attDic];
    
    return attrStr;
}

@end
