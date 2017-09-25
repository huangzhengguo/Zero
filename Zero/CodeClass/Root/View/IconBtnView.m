//
//  IconBtnView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "IconBtnView.h"

#import "IconModel.h"

@implementation IconBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        
        self.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}

- (void)setBtnArray:(NSMutableArray *)btnArray {
    
    if (btnArray == nil) {
        
        return;
    }
    
    NSInteger width = KWIDTH / btnArray.count;

    /* 创建btn */
    for (int i=0;i<btnArray.count;i++) {
        
        IconModel *model = btnArray[i];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, width)];
        
        //[btn.imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        /* 设置button图片 */
        [btn sd_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 30, 0)];
        
        /* 设置标题 */
        [btn setTitle:model.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 23, 0)];
        
        [self addSubview:btn];
    }
}

@end















































