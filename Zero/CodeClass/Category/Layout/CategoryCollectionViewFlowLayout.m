//
//  CategoryCollectionViewFlowLayout.m
//  Zero
//
//  Created by 黄郑果 on 16/8/31.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryCollectionViewFlowLayout.h"

@implementation CategoryCollectionViewFlowLayout

- (void)prepareLayout {
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds

{
    
    return YES;
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 返回每个item的layout属性 */
    /* 使用indexPath创建item对象 */
    UICollectionViewLayoutAttributes *layoutAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger lineNum = indexPath.row / 3;
    
    layoutAttr.frame = CGRectMake(KWIDTH / 3 * (indexPath.row % 3), KWIDTH / 3 * lineNum, KWIDTH / 3, KWIDTH / 3);

    return layoutAttr;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *attrArray = [NSMutableArray array];
    
    for (int i=0;i<array.count;i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [attrArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attrArray;
}

@end










































