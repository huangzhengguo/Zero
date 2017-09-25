//
//  CategoryCollectionViewLayout.h
//  Zero
//
//  Created by 黄郑果 on 16/9/3.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionViewLayout : UICollectionViewLayout

/* 要显示的列数 */
@property (nonatomic, assign) NSInteger columnCount;

/* 列间距 */
@property (nonatomic, assign) NSInteger columnSpacing;

/* 行间距 */
@property (nonatomic, assign) NSInteger rowSpacing;

/* section到collectionview的边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/* 保存每一列最大值的字典 */
@property (nonatomic, strong) NSMutableDictionary *maxYDic;

/* 保存每一个item attributes的数组 */
@property (nonatomic, strong) NSMutableArray *attributesArray;

/* 定义block传递图片大小 */
@property (nonatomic, copy) CGFloat (^itemHeightBlock)(CGFloat itemHeight,NSIndexPath *indexPath);

@end




























