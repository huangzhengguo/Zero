//
//  IconButtonCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "IconButtonCell.h"

#import "CustomBtn.h"

@implementation IconButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)createBtnWithImgArr:(NSArray *)btnImageArr titleArray:(NSArray *)btnTitleArr {
    
    /* 设置时删除所有butn */
    for (int i = 0; i < btnTitleArr.count; i ++) {
        
        [[self viewWithTag:3000 + i] removeFromSuperview];
    }
    
    //每一个button的宽度
    CGFloat btn_W = (KWIDTH - 6 * BTNSPACE) / 5;
    
    for (int i = 0; i < btnTitleArr.count; i ++) {
        
        CustomBtn *btn = [[CustomBtn alloc] initWithFrame:CGRectMake(BTNSPACE + i*(btn_W + BTNSPACE), 0, btn_W, BTNAREAHEIGHT) imageUrlArr:btnImageArr[i] LBTitleArr:btnTitleArr[i]];
        
        //btn.backgroundColor = [UIColor yellowColor];
        
        btn.tag = 3000 + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:btn];
    }
}

- (void)createBtnWithImgArr:(NSArray *)btnImageArr titleArray:(NSArray *)btnTitleArr btnCount:(NSInteger)count {
    
    /* 设置时删除所有butn */
    for (int i = 0; i < btnTitleArr.count; i ++) {
        
        [[self viewWithTag:3000 + i] removeFromSuperview];
    }
    
    //每一个button的宽度
    CGFloat btn_W = (KWIDTH - (count + 1) * BTNSPACE) / count;
    
    for (int i = 0; i < btnTitleArr.count; i ++) {
        
        CustomBtn *btn = [[CustomBtn alloc] initWithFrame:CGRectMake(BTNSPACE + i*(btn_W + BTNSPACE), 0, btn_W, BTNAREAHEIGHT) imageUrlArr:btnImageArr[i] LBTitleArr:btnTitleArr[i]];
        
        //btn.backgroundColor = [UIColor yellowColor];
        
        btn.tag = 3000 + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:btn];
    }
}

- (void)btnClickAction:(UIButton *)sender {
    
    if (self.btnClock) {
        
        self.btnClock(sender.tag - 3000);
    }
}

@end
