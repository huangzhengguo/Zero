//
//  CollectionViewTwoCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CollectionViewTwoCell.h"
#import "RootCollectionViewCell.h"

@interface CollectionViewTwoCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CollectionViewTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /* 设置collectionView */
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RootCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"RootCollectionViewCell"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --- collview代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RootCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootCollectionViewCell" forIndexPath:indexPath];
    
    return collectionCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KWIDTH-40) / 2, KWIDTH / 2);
}

//定义每个UICollectionView 的大小

@end





















































