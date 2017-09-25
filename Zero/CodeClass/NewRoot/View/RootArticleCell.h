//
//  RootArticleCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnBlock)(NSInteger);

typedef void (^articleBtnBlock)(NSString *,NSString *);

@interface RootArticleCell : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *lifeButton;

@property (strong, nonatomic) IBOutlet UIButton *shareButton;

@property (strong, nonatomic) IBOutlet UIButton *readButton;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) btnBlock clickBlock;

@property (strong, nonatomic) articleBtnBlock articleClickBlock;

/* 文章信息的数据 */
@property (nonatomic, strong) NSArray *articleDataArray;

@end
