//
//  NewProductCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsPublicModel.h"

@interface NewProductCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *scPriceLabel;

@property (strong, nonatomic) IBOutlet UIImageView *iconImg;

@property (strong, nonatomic) IBOutlet UILabel *viewLabel;

@property (strong, nonatomic) GoodsPublicModel *model;

@end
