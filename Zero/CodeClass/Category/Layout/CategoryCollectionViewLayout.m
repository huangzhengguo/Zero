//
//  CategoryCollectionViewLayout.m
//  Zero
//
//  Created by 黄郑果 on 16/9/3.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryCollectionViewLayout.h"

@implementation CategoryCollectionViewLayout

#pragma mark --- 懒加载
- (NSMutableArray *)attributesArray {
    
    if (_attributesArray == nil) {
        
        self.attributesArray = [NSMutableArray array];
    }
    
    return _attributesArray;
}

- (NSMutableDictionary *)maxYDic {
    
    if (_maxYDic == nil) {
        
        self.maxYDic = [NSMutableDictionary dictionary];
    }
    
    return _maxYDic;
}

/* 重写系统方法 */
/*
 1）- (void)prepareLayout
 2）- (CGSize)collectionViewContentSize
 3）- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
 4）- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
 */

#pragma mark --- 准备工作
- (void)prepareLayout {
    
    /* 初始化每列高度的字典 */
    for (int i=0;i<self.columnCount;i++) {
        
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    
    /* 根据collectionview获取到item的个数 */
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    /* 创建每个item的attri,并保存到数组中 */
    for (int i=0;i<itemCount;i++) {
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        [self.attributesArray addObject:attributes];
    }
}

#pragma mark --- 计算collectionView的大小
- (CGSize)collectionViewContentSize {
    
    __block NSNumber *maxIndex = @(0);
    
    /* 遍历字典，找出最长列 */
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([self.maxYDic[maxIndex] floatValue] < [obj floatValue]) {
            
            maxIndex = key;
        }
    }];
    
    /* collectionview的height就等于最长列的y值加上下面的下边距 */
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

#pragma mark --- 设置每个item的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 创建和item关联的属性 */
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /* 获取collectionview的宽度 */
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    /* 计算item的宽度 */
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    
    /* 找出最短的一列 */
    __block NSNumber *minIndex = @(0);
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([self.maxYDic[minIndex] floatValue] > [obj floatValue]) {
            
            minIndex = key;
        }
        
    }];
    
    /* 根据最短列计算item的x值
     * 计算方法:collectionview的左边距 + （最短列的下标 * (item宽度 + 列间距)）
     */
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex.integerValue;
    
    /* 计算y值
     * 最短列 + 行间距
     */
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    
    /* 计算item的高度：需要使用图片的大小，然后进行等比例的缩放即可：
     * 等比例缩放计算方法： 原图高度 / 原图宽度 * item宽度
     * 需要使用block计算高度
     */
    CGFloat itemHeight = 0.0;
    if (self.itemHeightBlock) {
        
        itemHeight = self.itemHeightBlock(itemWidth,indexPath);
    }
    
    /* 设置attributes并更新字典 */
    /* 创建item的frame */
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    /* 更新字典中的插入列的高度
     * 返回的是frame中 top的y值，也就是frame的下边框的y值
     */
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    /* 返回item对应的attributes */
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    /* 返回item属性数组 */
    return self.attributesArray;
}

@end












































































