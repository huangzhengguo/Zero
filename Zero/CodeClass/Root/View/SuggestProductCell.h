//
//  SuggestProductCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClotheModel.h"

@interface SuggestProductCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *oneLB;

@property (strong, nonatomic) IBOutlet UILabel *twoLB;

@property (strong, nonatomic) IBOutlet UILabel *threeLB;

@property (strong, nonatomic) IBOutlet UILabel *fourLB;

@property (strong, nonatomic) IBOutlet UILabel *fiveLB;

@property (strong, nonatomic) IBOutlet UILabel *sixLB;

@property (strong, nonatomic) IBOutlet UILabel *sevenLB;

@property (strong, nonatomic) IBOutlet UILabel *eightLB;

@property (strong, nonatomic) IBOutlet UIImageView *oneImg;

@property (strong, nonatomic) IBOutlet UIImageView *twoImg;

@property (strong, nonatomic) IBOutlet UIImageView *threeImg;

@property (strong, nonatomic) IBOutlet UIImageView *fourImg;

@property (strong, nonatomic) NSArray *array;

@end
