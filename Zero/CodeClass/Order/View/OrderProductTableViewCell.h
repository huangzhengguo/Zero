//
//  OrderProductTableViewCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZuInfoModel.h"

@interface OrderProductTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *atrrLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *wlPriceLabel;

@property (nonatomic, strong) ZuInfoModel *orderConfirmModel;

@end
