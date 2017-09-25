//
//  YourLikeGoodsCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^myBlock)(NSString *);

typedef void(^mySelectBlock) (NSString *);

@interface YourLikeGoodsCell : UICollectionViewCell

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) mySelectBlock selectBlock;

@end
