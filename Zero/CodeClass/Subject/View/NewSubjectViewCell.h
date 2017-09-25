//
//  NewSubjectViewCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SubjectGoodsDesModel.h"

@interface NewSubjectViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *desLabel;

@property (strong, nonatomic) IBOutlet UILabel *scPriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

- (void)setCellWithGoodsModel:(SubjectGoodsDesModel *)goodsModel;

@end
