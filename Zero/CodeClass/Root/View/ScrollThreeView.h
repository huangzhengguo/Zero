//
//  ScrollThreeView.h
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^myBlock) (NSInteger);

@interface ScrollThreeView : UIView

@property (strong, nonatomic) IBOutlet UIButton *lifeBtn;

@property (strong, nonatomic) IBOutlet UIButton *shareBtn;

@property (strong, nonatomic) IBOutlet UIButton *readBtn;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) myBlock btnBlock;

@end
