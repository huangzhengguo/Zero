//
//  SubjectCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgOneView;

@property (strong, nonatomic) IBOutlet UIImageView *imgTwoView;

@property (strong, nonatomic) IBOutlet UIImageView *imgThreeView;

@property (strong, nonatomic) IBOutlet UIImageView *imgFourView;

@property (strong, nonatomic) IBOutlet UIImageView *imgFiveView;

@property (strong, nonatomic) IBOutlet UIImageView *imgSixView;

@property (strong, nonatomic) IBOutlet UIImageView *imgSevenView;

- (void)setCellWithArray:(NSArray *)array;

@end
