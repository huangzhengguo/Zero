//
//  SubjectCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewSubjectModel.h"

typedef void(^tagBlock) (NSInteger);

@interface NewSubjectCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titileLabel;

@property (strong, nonatomic) IBOutlet UILabel *goodsCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *hotLabel;

@property (strong, nonatomic) IBOutlet UIButton *bigImgButton;

@property (strong, nonatomic) IBOutlet UIButton *oneImgButton;

@property (strong, nonatomic) IBOutlet UIButton *twoImgButton;

@property (strong, nonatomic) IBOutlet UIButton *threeImgbButton;

@property (strong, nonatomic) IBOutlet UIButton *fourImgButton;

@property (strong, nonatomic) IBOutlet UILabel *onePriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *twoPriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *threePriceLabel;

@property (strong, nonatomic) IBOutlet UILabel *fourPriceLabel;


@property (copy, nonatomic) tagBlock imgBtnBlock;

- (void)setCellWithBigImgModel:(NewSubjectModel *)model goodsArray:(NSArray *)array;

@end
