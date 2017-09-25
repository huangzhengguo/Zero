//
//  CommentCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommentModel.h"

@interface CommentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImg;

@property (strong, nonatomic) IBOutlet UILabel *nickLabel;

@property (strong, nonatomic) IBOutlet UILabel *rateLabel;

@property (strong, nonatomic) IBOutlet UILabel *addtimeLabel;

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UILabel *goodsLabel;

@property (strong, nonatomic) CommentModel *model;

@end
