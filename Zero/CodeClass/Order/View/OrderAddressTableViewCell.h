//
//  OrderAddressTableViewCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderConfirmModel.h"

@interface OrderAddressTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong) OrderConfirmModel *model;

@end
