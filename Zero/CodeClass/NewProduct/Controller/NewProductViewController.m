//
//  NewProductViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NewProductViewController.h"

#import "GoodsPublicModel.h"

#import "NewProductCell.h"

@interface NewProductViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *menuView;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *productDataArray;

@property (nonatomic, strong) NSMutableDictionary *paramDic;

@property (nonatomic, strong) NSArray *sortArray;

@property (nonatomic, strong) NSArray *sortParamArray;

@property (nonatomic, assign) BOOL isUpSort;

/* 下拉上提参数 */
@property (nonatomic, assign) BOOL isUpOrDown;

/* 请求的页数 */
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation NewProductViewController

- (NSMutableArray *)productDataArray {
    
    if (_productDataArray == nil) {
        
        self.productDataArray = [NSMutableArray array];
    }
    
    return _productDataArray;
}

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectIndex = 1000;
    UIButton *selectButton = [self.menuView viewWithTag:self.selectIndex];
    if (self.selectIndex != 0) {
        
        selectButton.selected = NO;
    }
    selectButton.selected = YES;
    
    /* 初始化排序数组 */
    self.sortArray = @[@"全部",@"人气",@"销量",@"价格"];
    self.sortParamArray = @[@"",@"watch",@"sale",@"price_d",@"price_u"];
    self.isUpSort = NO;
    
    /* 设置collectionview */
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewProductCell" bundle:nil] forCellWithReuseIdentifier:@"NewProductCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    /* 创建排序菜单 */
    [self createSortMenu];
    
    /* 设置请求参数 */
    self.paramDic = [@{@"action":@"region",@"order":@"",@"page":@"1",@"type":@"0"} mutableCopy];
    [self requestData];
    
    /* 初始化 */
    self.isUpOrDown = YES;
    self.page = 1;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.isUpOrDown = YES;
        self.page = 1;
        
        [self.paramDic setValue:@(self.page) forKey:@"page"];
        
        [self requestData];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.isUpOrDown = NO;
        self.page = self.page + 1;
        
        [self.paramDic setValue:@(self.page) forKey:@"page"];
        
        [self requestData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 创建排序菜单
- (void)createSortMenu {
    
    for (int i=0;i<self.sortArray.count;i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * (KWIDTH / self.sortArray.count), 0, KWIDTH / self.sortArray.count, 64)];
        
        [btn setTitle:self.sortArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sortBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:1000 + i];
        
        /* 设置文本未选中颜色 */
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        /* 设置文本选中颜色 */
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [self.menuView addSubview:btn];
    }
}

- (void)sortBtnClickAction:(UIButton *)sender {
    
    self.isUpOrDown = YES;
    
    UIButton *lastButton = [self.menuView viewWithTag:self.selectIndex];
    if (self.selectIndex != 0) {
        
        lastButton.selected = NO;
    }
    
    sender.selected = YES;
    self.selectIndex = sender.tag;
    
    /* 获取按钮下标 */
    NSInteger index = sender.tag - 1000;
    if (index == 3) {
        
        if (self.isUpSort == NO) {
            
            [self.paramDic setValue:self.sortParamArray[index + 1] forKey:@"order"];
            self.isUpSort = YES;
        }else {
            
            [self.paramDic setValue:self.sortParamArray[index] forKey:@"order"];
            self.isUpSort = NO;
        }
    }else {
        
        [self.paramDic setValue:self.sortParamArray[index] forKey:@"order"];
    }
    
    [self.paramDic setValue:@(1) forKey:@"page"];
    
    /* 重新请求数据 */
    [self requestData];
}

#pragma mark --- 请求数据
- (void)requestData {
    
    if (self.isUpOrDown == YES) {
        
       [self.productDataArray removeAllObjects];
    }
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {
            
            GoodsPublicModel *model = [[GoodsPublicModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.productDataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- collectionview代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.productDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewProductCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (self.productDataArray.count > 0) {
        
        GoodsPublicModel *model = self.productDataArray[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 跳转到详情界面 */
    GoodsPublicModel *model = self.productDataArray[indexPath.row];
    
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    
    productDetailVC.goods_id = model.goods_id;
    
    [self.navigationController pushViewController:productDetailVC animated:YES];
    
}

#pragma 设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KWIDTH-30) / 2, (KWIDTH-30) * 2 / 2);
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









































