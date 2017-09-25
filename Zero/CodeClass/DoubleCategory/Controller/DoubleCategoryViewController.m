//
//  DoubleCategoryViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "DoubleCategoryViewController.h"

#import "CategoryListDataModel.h"

@interface DoubleCategoryViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

/* 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *paramDic;

/* 存储大类 */
@property (nonatomic, strong) NSMutableArray *categoryListArray;

/* 存储子类 */
@property (nonatomic, strong) NSMutableDictionary *categoryListDic;

/* 一级菜单 */
@property (nonatomic, strong) UIView *firstView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation DoubleCategoryViewController

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (NSMutableArray *)categoryListArray {
    
    if (_categoryListArray == nil) {
        
        self.categoryListArray = [NSMutableArray array];
    }
    
    return _categoryListArray;
}

- (NSMutableDictionary *)categoryListDic {
    
    if (_categoryListDic == nil) {
        
        self.categoryListDic = [NSMutableDictionary dictionary];
    }
    
    return _categoryListDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 设置collectionView */
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.paramDic = [@{@"action":@"zerocategory"} mutableCopy];
    
    self.firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 60)];

    self.firstView.backgroundColor = RANDOMCOLOR;
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 60)];
//    
//    [self.firstView addSubview:self.scrollView];
    
    [self.view addSubview:self.firstView];
    [self requestData];
}

/* 请求数据 */
- (void)requestData {
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSArray *firstListArray = responseObject[@"list"];
        for (NSDictionary *firstDic in firstListArray) {
            
            CategoryListDataModel *firstModel = [[CategoryListDataModel alloc] init];
            
            firstModel.pro_id = firstDic[@"id"];
            firstModel.name = firstDic[@"name"];
            firstModel.cat_id = firstDic[@"cat_id"];
            firstModel.p_id = firstDic[@"p_id"];
            firstModel.img = firstDic[@"img"];
            
            [self.categoryListArray addObject:firstModel];
            
            NSArray *secondListArray = firstDic[@"list"];
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            for (NSDictionary *secondDic in secondListArray) {
                
                CategoryListDataModel *secondModel = [[CategoryListDataModel alloc] init];
                
                secondModel.pro_id = secondDic[@"id"];
                secondModel.name = secondDic[@"name"];
                secondModel.cat_id = secondDic[@"cat_id"];
                secondModel.p_id = secondDic[@"p_id"];
                secondModel.img = secondDic[@"img"];
                
                [tmpArray addObject:secondModel];
            }
            
            [self.categoryListDic setObject:tmpArray forKey:firstDic[@"id"]];
        }
        
        /* 主线程处理数据 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 创建菜单 */
            [self createDoubleMenu];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

- (void)createDoubleMenu {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end





































