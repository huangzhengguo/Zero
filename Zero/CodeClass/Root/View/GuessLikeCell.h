//
//  GuessLikeCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessLikeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *scrollView;

- (void)setScrollViewWithArray:(NSArray *)array;

@end
