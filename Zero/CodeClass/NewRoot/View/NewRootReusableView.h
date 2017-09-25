//
//  NewRootReusableView.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cycClickBlock) (NSInteger);

@interface NewRootReusableView : UICollectionReusableView <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycScrollView;

@property (nonatomic, copy) cycClickBlock cycBlock;

@end
