//
//  ArticleCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ArticleBtnClickBlock)(NSString *,NSString *);

@interface ArticleCell : UITableViewCell

/* 文章信息的数据 */
@property (nonatomic, strong) NSArray *articleDataArray;

@property (nonatomic, copy) ArticleBtnClickBlock btnClickBlock;

@end
