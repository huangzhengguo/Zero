//
//  NewRootSuggestHeaderView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NewRootSuggestHeaderView.h"

@implementation NewRootSuggestHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /* 初始化 */
    UIView *viewOne = [self createVerticalViewWithframe:CGRectMake(0, 0, KWIDTH / 4, KWIDTH / 2) tag:10001];
    [self addSubview:viewOne];
    
    UIView *viewTwo = [self createVerticalViewWithframe:CGRectMake(KWIDTH / 4, 0, KWIDTH / 4, KWIDTH / 2) tag:10002];
    [self addSubview:viewTwo];
    
    UIView *viewThree = [self createHorizontalViewWithframe:CGRectMake(KWIDTH / 2, 0, KWIDTH / 2, KWIDTH / 4) tag:10003];
    [self addSubview:viewThree];
    
    UIView *viewFour = [self createHorizontalViewWithframe:CGRectMake(KWIDTH / 2, KWIDTH / 4, KWIDTH / 2, KWIDTH / 4) tag:10004];
    [self addSubview:viewFour];
    
    /* 这个是活动图片 */
    UIView *viewFive = [self createViewWithSameSizeImgView:CGRectMake(0, KWIDTH / 2, KWIDTH, 50) tag:10005];
    [self addSubview:viewFive];
    
    UIView *viewSix = [self createHorizontalViewWithframe:CGRectMake(0, KWIDTH / 2 + 50, KWIDTH / 2, KWIDTH / 4) tag:10006];
    [self addSubview:viewSix];

    UIView *viewSeven = [self createHorizontalViewWithframe:CGRectMake(KWIDTH / 2, KWIDTH / 2 + 50, KWIDTH / 2, KWIDTH / 4) tag:10007];
    [self addSubview:viewSeven];
    
    UIView *viewEight = [self createVerticalViewWithframe:CGRectMake(0, KWIDTH * 3 / 4 + 50, KWIDTH / 4, KWIDTH / 2) tag:10008];
    [self addSubview:viewEight];
    
    UIView *viewNine = [self createVerticalViewWithframe:CGRectMake(KWIDTH / 4, KWIDTH * 3 / 4 + 50, KWIDTH / 4, KWIDTH / 2) tag:10009];
    [self addSubview:viewNine];
    
    UIView *viewTen = [self createVerticalViewWithframe:CGRectMake(KWIDTH / 2, KWIDTH * 3 / 4 + 50, KWIDTH / 4, KWIDTH / 2) tag:10010];
    [self addSubview:viewTen];
    
    UIView *viewEleven = [self createVerticalViewWithframe:CGRectMake(KWIDTH * 3 / 4, KWIDTH * 3 / 4 + 50, KWIDTH / 4, KWIDTH / 2) tag:10011];
    [self addSubview:viewEleven];
    
    UIView *viewTwelve = [self createHorizontalViewWithframe:CGRectMake(0, KWIDTH * 5 / 4 + 50, KWIDTH / 2, KWIDTH / 4) tag:10012];
    [self addSubview:viewTwelve];
    
    UIView *viewThirteen = [self createHorizontalViewWithframe:CGRectMake(KWIDTH / 2, KWIDTH * 5 / 4 + 50, KWIDTH / 2, KWIDTH / 4) tag:10013];
    [self addSubview:viewThirteen];
    
    UIView *viewFourteen = [[UIView alloc] initWithFrame:CGRectMake(0, KWIDTH * 3 / 2 + 50, KWIDTH, 50)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 50)];
    
    label.tag = 100001;
    //viewFourteen.backgroundColor = RANDOMCOLOR;
    viewFourteen.tag = 10014;
    
    [viewFourteen addSubview:label];
    [self addSubview:viewFourteen];
    
    self.frame = CGRectMake(0, 0, KWIDTH, KWIDTH * 3 / 2 + 100);
}

- (UIView *)createViewWithSameSizeImgView:(CGRect)frame tag:(NSInteger)tag{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1;
    view.tag = tag;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
    [view addGestureRecognizer:tapGestureRecognizer];
    
    /* 添加imgView */
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    imgView.tag = 100000;
    [view addSubview:imgView];
    
    return view;
}

- (UIView *)createVerticalViewWithframe:(CGRect)frame tag:(NSInteger)tag{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    //view.backgroundColor = RANDOMCOLOR;
    view.tag = tag;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1;
    
    /* 添加轻拍手势，回传view tag值 */
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
    
    [view addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
    
    labelOne.tag = 100001;
    labelOne.font = [UIFont systemFontOfSize:10];
    [view addSubview:labelOne];
    
    UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 50, 20)];
    
    labelTwo.tag = 100002;
    labelTwo.font = [UIFont systemFontOfSize:10];
    [view addSubview:labelTwo];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, KWIDTH / 2 - 80, KWIDTH / 4, 80)];
    
    imgView.tag = 100003;
    [view addSubview:imgView];
    
    return view;
}

- (UIView *)createHorizontalViewWithframe:(CGRect)frame tag:(NSInteger)tag{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    //view.backgroundColor = RANDOMCOLOR;
    view.tag = tag;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 1;
    
    /* 添加轻拍手势，回传view tag值 */
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
    
    [view addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
    
    labelOne.tag = 100001;
    labelOne.font = [UIFont systemFontOfSize:10];
    [view addSubview:labelOne];
    
    UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 50, 20)];
    labelTwo.tag = 100002;
    labelTwo.font = [UIFont systemFontOfSize:10];
    [view addSubview:labelTwo];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KWIDTH / 2 - 80, 0, 80, KWIDTH / 4)];
    
    imgView.tag = 100003;
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

@end




















