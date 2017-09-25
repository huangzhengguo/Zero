//
//  ProductDetailHeaderView.h
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>

@interface ProductDetailHeaderView : UICollectionReusableView<SDCycleScrollViewDelegate>

/* 声明轮播图属性，在网络数据请求之后赋值图片组属性 */
@property (nonatomic, strong) SDCycleScrollView *cycScrollView;

@end
