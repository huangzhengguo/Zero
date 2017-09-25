//
//  AddAndSubNumTableViewCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/30.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAndSubNumTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *subButton;

@property (strong, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) IBOutlet UITextField *numTextField;

@property (nonatomic, copy) void(^addNumBlock)();

@property (nonatomic, copy) void(^subNumBlock)();

@end
