//
//  CategoryDetailViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryDetailViewController.h"

#import "CategoryDetailModel.h"

#import "CategoryDetailCell.h"

/* 产品详情页面 */
#import "ProductDetailViewController.h"

#import "CategoryCollectionViewFlowLayout.h"

/* 自定义布局 */
#import "CategoryCollectionViewLayout.h"

@interface CategoryDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableDictionary *paramDic;

@property (strong, nonatomic) NSMutableArray *detailDataArray;

@property (strong, nonatomic) NSArray *sortWay;

/* 用来存放图片宽度 高度 地址:数组中的项为字典类型 */
@property (nonatomic, strong) NSMutableArray *imageInfoArray;

/* 自定义布局属性 */
@property (nonatomic, strong) CategoryCollectionViewLayout *layout;

/* 下拉上提标记 */
@property (nonatomic, assign) BOOL isUpOrDown;

/* 数据请求加载页数 */
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger menuSelectBtnTag;

@property (nonatomic, strong) UIView *menuView;

@property (nonatomic, strong) UICollectionViewLayout *oldLayout;

@property (nonatomic, assign) BOOL isOldLayout;

@end

@implementation CategoryDetailViewController

#pragma mark --- 懒加载部分
- (NSMutableArray *)detailDataArray {
    
    if (_detailDataArray == nil) {
        
        self.detailDataArray = [NSMutableArray array];
    }
    
    return _detailDataArray;
}

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (NSMutableArray *)imageInfoArray {
    
    if (_imageInfoArray == nil) {
        
        self.imageInfoArray = [NSMutableArray array];
    }
    
    return _imageInfoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuSelectBtnTag = 1000;
    
    __weak CategoryDetailViewController *weakSelf = self;
    
    /* 设置collectionView */
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    /* 注册cell */
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryDetailCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryDetailCell"];
    
    //[self setNavigateion];
    
//    CategoryCollectionViewFlowLayout *flowLayout = [[CategoryCollectionViewFlowLayout alloc] init];
//    
//    [self.collectionView setCollectionViewLayout:flowLayout];
    
    self.layout = [[CategoryCollectionViewLayout alloc] init];
    
    self.layout.columnCount = 2;
    self.layout.columnSpacing = 10;
    self.layout.rowSpacing = 10;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [self.layout setItemHeightBlock:^CGFloat(CGFloat rowWidth, NSIndexPath *indexPath) {
        
        XRImage *image = [XRImage imageWithImageDic:weakSelf.imageInfoArray[indexPath.row]];
        
        return image.imageH / image.imageW * rowWidth;
    }];

    /* 保存原来的布局 */
    self.oldLayout = self.collectionView.collectionViewLayout;
    
    self.isOldLayout = YES;
    
    //self.collectionView.collectionViewLayout = self.layout;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    /* 添加排序菜单 */
    [self addSortMenu];
    
    /* 初始化排序方式数组 
     * sort 默认
     * view 人气
     * sale 销量
     * price 价格降序
     * price_a 价格升序
     */
    self.sortWay = @[@"sort",@"view",@"sale",@"price",@"price_a"];
    
    /* 初始化请求参数 */
    self.paramDic = [@{@"action":@"n_goodslist",@"order":@"sort",@"page":@(self.page),@"id":self.model.cat_id,@"pid":self.model.p_id} mutableCopy];
    
    [self requestData];
    
    /* 初始化下拉标记 */
    self.isUpOrDown = YES;
    self.page = 1;
    
    /* 添加下拉刷新 */
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        /* 设置page为1 */
        self.page = 1;
        self.isUpOrDown = YES;
        [self.paramDic setValue:@(self.page) forKey:@"page"];
        
        /* 重新请求数据 */
        [self requestData];
    }];
    
    /* 添加上提加载更多 */
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page ++;
        self.isUpOrDown = NO;
        [self.paramDic setValue:@(self.page) forKey:@"page"];
        
        /* 重新请求数据 */
        [self requestData];
    }];
    
}

#pragma mark --- 设置导航栏
- (void)setNavigateion {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [btn setTitle:@"视图" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *switchLayout = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = switchLayout;
}

- (void)changeView:(UIButton *)sender {
 
    if (self.isOldLayout == YES) {
        
        self.collectionView.collectionViewLayout = self.layout;
        self.isOldLayout = NO;
    }else {
        
        self.collectionView.collectionViewLayout = self.oldLayout;
        self.isOldLayout = YES;
    }
    
    self.isUpOrDown = YES;
    [self.paramDic setValue:@(1) forKey:@"page"];
    [self requestData];
}

#pragma mark --- 添加排序菜单
- (void)addSortMenu {
    
    /* 在视图的顶部添加排序按钮 */
    NSArray *sortMenuTitleArray = @[@"全部",@"人气",@"销量",@"价格"];
    
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 63)];
    
    self.menuView.backgroundColor = [UIColor grayColor];
    
    /* 在menu视图上添加排序按钮 */
    for (int i=0;i<sortMenuTitleArray.count;i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setFrame:CGRectMake(i * KWIDTH / 4, 0, KWIDTH / 4, 63)];
        [btn setTitle:sortMenuTitleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateFocused];
        [btn setTag:1000 + i];
        [btn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.menuView addSubview:btn];
    }
    
    [self.view addSubview:self.menuView];
    
    /* 选中全部 */
    UIButton *currentBtn = [SetMenuButton setButtonWithLastSelectButtonTag:self.menuSelectBtnTag currentButtunTag:self.menuSelectBtnTag superView:self.menuView normalColor:[UIColor whiteColor] selectedColor:[UIColor orangeColor]];
    
    currentBtn.selected = YES;
}

- (void)sortBtnClick:(UIButton *)sender {
    
    UIButton *currentBtn = [SetMenuButton setButtonWithLastSelectButtonTag:self.menuSelectBtnTag currentButtunTag:sender.tag superView:self.menuView normalColor:[UIColor whiteColor] selectedColor:[UIColor orangeColor]];
    
    currentBtn.selected = YES;
    self.menuSelectBtnTag = sender.tag;
    
    /* 重新请求数据 */
    /* 根据tag值取出排序方式,并设置请求参数 */
    NSInteger index = sender.tag - 1000;
    
    NSString *sortStr = self.sortWay[index];
    
    /* 对价格排序特殊处理 */
    if (index == 3) {
        
        if ([[self.paramDic objectForKey:@"order"] isEqualToString:@"price"]) {
            
            [self.paramDic setValue:@"price_a" forKey:@"order"];
        }else {
            
            [self.paramDic setValue:@"price" forKey:@"order"];
        }
    }else {
        
        /* 设置请求参数 */
        [self.paramDic setValue:sortStr forKey:@"order"];
    }
    
    /* 重新请求数据 */
    [self requestData];
}

#pragma mark --- 数据请求
- (void)requestData {
    
    if (self.isUpOrDown == YES) {
        
       [self.detailDataArray removeAllObjects];
    }
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSArray *dataArray = responseObject[@"list"];
        for (NSDictionary *dic in dataArray) {
            
            CategoryDetailModel *model = [[CategoryDetailModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.detailDataArray addObject:model];
            
            /* 存储图片的地址  高度  宽度s */
            NSMutableDictionary *imgDic = [NSMutableDictionary dictionary];
            
            /* 设置地址属性 */
            [imgDic setObject:dic[@"default_image"] forKey:@"img"];
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dic[@"default_image"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
            UIImage *image = [UIImage imageWithData:imageData];
            
            CGFloat imageH = image.size.height * (arc4random_uniform(2) + 2);
            CGFloat imageW = image.size.width;
            
            /* 设置图片高度 */
            [imgDic setObject:@(imageH) forKey:@"h"];
            
            /* 设置图片宽度 */
            [imgDic setObject:@(imageW) forKey:@"w"];
            
            [self.imageInfoArray addObject:imgDic];
        }
        
        /* 主线程刷新数据 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 结束动画 */
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark --- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.detailDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryDetailCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (self.detailDataArray.count > 0) {
        
        CategoryDetailModel *model = self.detailDataArray[indexPath.row];
        
        cell.model = model;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 跳转到三级页面 */
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    
    /* 需要传递goods_id */
    CategoryDetailModel *model = self.detailDataArray[indexPath.row];
    productDetailVC.goods_id = model.goods_id;
    
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

#pragma 设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KWIDTH-30) / 2, (KWIDTH * 3) / 4);
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






























































