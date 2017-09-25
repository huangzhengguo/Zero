//
//  GoodsInfoCollectionViewCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecommandModel.h"

@interface GoodsInfoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *desLabel;

@property (strong, nonatomic) IBOutlet UILabel *scPriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) RecommandModel *model;

@end
