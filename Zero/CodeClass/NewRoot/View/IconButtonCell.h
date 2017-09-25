//
//  IconButtonCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^iconBtnBlock)(NSInteger);

@interface IconButtonCell : UICollectionViewCell

- (void)createBtnWithImgArr:(NSArray *)btnImageArr titleArray:(NSArray *)btnTitleArr;

/* 使用button个数 */
- (void)createBtnWithImgArr:(NSArray *)btnImageArr titleArray:(NSArray *)btnTitleArr btnCount:(NSInteger)count;

@property (nonatomic, copy) iconBtnBlock btnClock;

@end
