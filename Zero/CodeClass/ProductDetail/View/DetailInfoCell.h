//
//  DetailInfoCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailModel.h"

@interface DetailInfoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *Price;

@property (strong, nonatomic) IBOutlet UILabel *scPriceLB;

@property (strong, nonatomic) IBOutlet UILabel *wlPriceLB;

@property (strong, nonatomic) IBOutlet UILabel *goods_nameLB;

@property (strong, nonatomic) IBOutlet UILabel *zk_priceLB;

@property (strong, nonatomic) IBOutlet UILabel *goodsNowStockLB;

@property (strong, nonatomic) IBOutlet UILabel *saleLB;


/* 轮播图下面详细信息 */
@property (nonatomic, strong) ProductDetailModel *model;

@end
