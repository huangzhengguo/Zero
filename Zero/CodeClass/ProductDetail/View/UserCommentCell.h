//
//  UserCommentCell.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserCommentModel.h"

/* 定义不带参数回调 */
typedef void(^BtnBlock)();

@interface UserCommentCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImg;

@property (strong, nonatomic) IBOutlet UILabel *nameLB;

@property (strong, nonatomic) IBOutlet UILabel *rateLB;

@property (strong, nonatomic) IBOutlet UILabel *addtimeLB;

@property (strong, nonatomic) IBOutlet UILabel *bodyLB;

@property (strong, nonatomic) IBOutlet UILabel *hplLB;

@property (strong, nonatomic) IBOutlet UILabel *tslLB;

- (void)setCellWithModel:(UserCommentModel *)model hpl:(NSString *)hpl tsl:(NSString *)tsl;

@property (nonatomic, copy) BtnBlock btnClikcBlock;
@property (strong, nonatomic) IBOutlet UIButton *viewAllBtn;

/* 评论内容高度自适应问题 */
- (void)cellAutoLayoutHeight:(NSString *)str;

@end































