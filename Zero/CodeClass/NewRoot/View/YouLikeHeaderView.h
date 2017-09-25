//
//  YouLikeHeaderView.h
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^viewBlock) (NSInteger);

@interface YouLikeHeaderView : UICollectionReusableView

@property (nonatomic, copy) viewBlock viewTapBlock;

@end
