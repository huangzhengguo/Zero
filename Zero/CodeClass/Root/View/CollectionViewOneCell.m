//
//  CollectionViewOneCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CollectionViewOneCell.h"

@interface CollectionViewOneCell()<UICollectionViewDelegate, UICollectionViewDataSource>



@end

@implementation CollectionViewOneCell

static NSString *oneCell = @"oneCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /* 设置collectionView代理 */
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"oneCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --- collection代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"oneCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[UICollectionViewCell alloc] init];
        
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < 3) {
        
        /* 对于前两个item */
        return CGSizeMake(KWIDTH / 4, KWIDTH / 2);
    }
    else {
        
        
        return CGSizeMake(KWIDTH / 2, KWIDTH / 4);
    }
}

@end































































