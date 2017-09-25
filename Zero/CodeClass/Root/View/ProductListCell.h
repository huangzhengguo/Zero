//
//  ProductListCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommandModel.h"

@interface ProductListCell : UITableViewCell

@property (nonatomic, strong) RecommandModel *model;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *titleLB;

@property (strong, nonatomic) IBOutlet UILabel *stitleLB;

@property (strong, nonatomic) IBOutlet UILabel *oldPriceLB;

@property (strong, nonatomic) IBOutlet UILabel *secondPriceLB;



@end
