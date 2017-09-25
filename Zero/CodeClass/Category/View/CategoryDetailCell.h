//
//  CategoryDetailCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CategoryDetailModel.h"

@interface CategoryDetailCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *titleLB;

@property (strong, nonatomic) IBOutlet UILabel *priceLB;

@property (strong, nonatomic) IBOutlet UILabel *scPriceLB;

@property (strong, nonatomic) CategoryDetailModel *model;

@end
