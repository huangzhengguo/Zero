//
//  YouLikeHeaderView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "YouLikeHeaderView.h"

@implementation YouLikeHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /* 初始化布局 */
    
    self.frame = CGRectMake(0, 0, KWIDTH, 120 + KWIDTH * 3 / 4 + 40);
    
    [self addSubview:[self createViewWithSameSizeImgView:CGRectMake(0, 0, KWIDTH, 70) tag:1000]];
    //[self addSubview:[self createViewWithSameSizeImgView:CGRectMake(0, 70, KWIDTH, 50) tag:1001]];
    [self addSubview:[self createViewWithTitle:@"主题街" frame:CGRectMake(0, 70, KWIDTH, 50) tag:1001]];
    
    [self addSubview:[self createViewWithSameSizeImgView:CGRectMake(0, 120, (KWIDTH) / 4, KWIDTH / 2) tag:1002]];
    [self addSubview:[self createViewWithSameSizeImgView:CGRectMake((KWIDTH) / 4, 120, (KWIDTH) / 4, KWIDTH / 2) tag:1003]];
    [self addSubview:[self createViewWithSameSizeImgView:CGRectMake((KWIDTH) / 2, 120, (KWIDTH) / 2, (KWIDTH) / 4) tag:1004]];
    [self addSubview:[self createViewWithSameSizeImgView:CGRectMake((KWIDTH) / 2, 120 + (KWIDTH) / 4, (KWIDTH) / 2, (KWIDTH) / 4) tag:1005]];
    
    [self addSubview:[self createViewWithSameSizeImgView:CGRectMake(0, 120 + (KWIDTH) / 2, (KWIDTH) / 2, (KWIDTH) / 4) tag:1006]];
    
    [self addSubview:[self createViewWithSameSizeImgView:CGRectMake((KWIDTH) / 2, 120 + (KWIDTH) / 2, (KWIDTH) / 2, (KWIDTH) / 4) tag:1007]];
    
    /* 添加文字 */
    [self addSubview:[self createViewWithTitle:@"猜你喜欢" frame:CGRectMake(0, 120 + KWIDTH * 3 / 4, KWIDTH, 40) tag:1008]];
}

- (UIView *)createViewWithSameSizeImgView:(CGRect)frame tag:(NSInteger)tag{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1;
    view.tag = tag;
    
    /* 给view添加手势 */
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
    
    [view addGestureRecognizer:tapGestureRecognizer];
    
    //view.backgroundColor = RANDOMCOLOR;
    /* 添加imgView */
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    imgView.tag = 10000;
    
    [view addSubview:imgView];

    return view;
}

- (void)viewTapAction:(UITapGestureRecognizer *)recognizer {
    
    UIView *view = recognizer.view;
    
    /* 传递tag值 */
    if (self.viewTapBlock) {
        
        self.viewTapBlock(view.tag);
    }
}

- (UIView *)createViewWithTitle:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1;
    view.tag = tag;
    
    /* 添加轻拍手势，回传view tag值 */
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
    
    [view addGestureRecognizer:tapGestureRecognizer];
    
    //view.backgroundColor = RANDOMCOLOR;
    /* 添加label */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, frame.size.height)];
    
    label.text = title;
    label.font = [UIFont systemFontOfSize:20];
    label.tag = 10001;
    label.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:label];
    
    return view;
}

@end
