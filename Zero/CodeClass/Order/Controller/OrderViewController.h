//
//  OrderViewController.h
//  Zero
//
//  Created by 黄郑果 on 16/8/29.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "BaseViewController.h"

#import "ZuInfoModel.h"

@interface OrderViewController : BaseViewController

/* 需要接收的值 */
@property (nonatomic, strong) ZuInfoModel *zuInfoModel;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) NSString *goods_id;

@property (nonatomic, strong) NSString *goods_name;

@property (nonatomic, strong) NSString *wlPrice;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *picture;

@end
