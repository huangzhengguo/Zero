//
//  ColorBigPatternCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ColorArticleModel.h"

@interface ColorBigPatternCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) ColorArticleModel *model;

@end
