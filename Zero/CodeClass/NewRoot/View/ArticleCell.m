//
//  ArticleCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ArticleCell.h"

#import "ArticleModel.h"

#import "ArticleModel.h"

@interface ArticleCell()

@property (nonatomic, strong) NSArray *articleArray;

@end

@implementation ArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setArticleDataArray:(NSArray *)articleDataArray {
    
    self.articleArray = articleDataArray;
    
    for (int i=0;i<articleDataArray.count;i++) {
        
        ArticleModel *model = articleDataArray[i];
        
        UIButton *btn = [self viewWithTag:1000 + i];
        
        [btn setTitle:model.title forState:UIControlStateNormal];
        
        /* 取第一个元素的图像对button赋值 */
        if (i == 0) {
            
            UIButton *btnImg = [self viewWithTag:1003];
            
            [btnImg sd_setBackgroundImageWithURL:[NSURL URLWithString:[model.imgs_1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
        }
    }
}

- (IBAction)articleClickAction:(UIButton *)sender {
    
    NSInteger index = sender.tag - 1000;
    /* 点击事件 */
    if (self.btnClickBlock) {
        
        if (index == 3) {
            
            /* 说明点击的是图片 */
            ArticleModel *model = self.articleArray[0];
            self.btnClickBlock(model.article_id,model.class_id);
        }else {
            ArticleModel *model = self.articleArray[index];
            self.btnClickBlock(model.article_id,model.class_id);
        }
        /* 这里需要把文章的id传递回去：根据tag值去数组中查找 */
        
    }
}


@end





















