//
//  YourLikeGoodsCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "YourLikeGoodsCell.h"

#import "LikeGoodsModel.h"

@interface YourLikeGoodsCell()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation YourLikeGoodsCell

/* 初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        /* 放置一个scrollView */
        self.frame = CGRectMake(0, 0, KWIDTH, 130);
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        
        [self addSubview:self.scrollView];
        
    }
    
    return self;
}

- (void)setArray:(NSArray *)array {
    
    self.dataArray = array;
    
    /* 移除scrollVie所有子视图 */
    for (UIView *view in self.scrollView.subviews) {
        
        [view removeFromSuperview];
    }
    
    /* 图片的宽度 */
    NSInteger kwidth = (KWIDTH - 40) / 3;
    
    for (int i=0;i<array.count;i++) {
        
        /* 根据数据往item上添加 */
        /* 创建view */
        UIView *view = [[UIView alloc] init];
        if (i == 0) {
            
            view.frame = CGRectMake(10, 10, kwidth, 120);
            
        }else {
            
            view.frame = CGRectMake(i * kwidth + (i+1) * 10, 10, kwidth, 120);
        }
        
        //view.backgroundColor = [UIColor yellowColor];
        view.tag = 1000 + i;
        
        /* 在view上添加imgView */
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kwidth - 10, 120 - 30)];
        
        LikeGoodsModel *model = array[i];
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:[model.default_image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
        
        [view addSubview:imgView];
        
        UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, kwidth - 10, 20)];
        
        labelOne.text =[NSString stringWithFormat:@"%@",model.goods_name];
        labelOne.font = [UIFont systemFontOfSize:10];
        
        [view addSubview:labelOne];
        
        UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, kwidth - 10, 10)];
        
        labelTwo.text =[NSString stringWithFormat:@"%@",model.Price];
        labelTwo.font = [UIFont systemFontOfSize:10];
        
        [view addSubview:labelTwo];
        
        /* 给view添加手势 */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
        
        [view addGestureRecognizer:tap];
        /* 添加到scrollerView上 */
        [self.scrollView addSubview:view];
    }
    
    self.scrollView.contentSize = CGSizeMake(array.count * kwidth + (array.count + 1) * 10, 130);
}
 
                                                                                                           
- (void)viewTapAction:(UITapGestureRecognizer *)recognizer {
    
    UIView *view = recognizer.view;
    
    /* 传递tag值 */
    if (self.selectBlock && self.dataArray.count > 0) {
        
        LikeGoodsModel *model = self.dataArray[view.tag - 1000];
        self.selectBlock(model.goods_id);
    }
}
                                                                                                           
@end





































