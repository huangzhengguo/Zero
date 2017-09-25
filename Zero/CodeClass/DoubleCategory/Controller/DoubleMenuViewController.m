//
//  DoubleMenuViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "DoubleMenuViewController.h"

#import "CategoryListDataModel.h"

#import "CategoryDetailModel.h"

#import "CategoryDetailCell.h"

#import "ProductDetailViewController.h"

/* 一级菜单高度 */
#define FIRSTMENUHEIGHT 60

/* 二级菜单高度 */
#define SECONDMENUHEIGHT 40

/* 菜单按钮宽度 */
#define SECONDBTNWIDTH 100

@interface DoubleMenuViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

/* 请求菜单数据参数 */
@property (nonatomic, strong) NSMutableDictionary *paramDic;

/* 存储大类 */
@property (nonatomic, strong) NSMutableArray *categoryListArray;

/* 存储子类 */
@property (nonatomic, strong) NSMutableDictionary *categoryListDic;

/* 一级菜单 */
@property (nonatomic, strong) UIView *firstView;

@property (nonatomic, strong) UIScrollView *firstScrollView;

/* 二级菜单 */
@property (nonatomic,strong) UIView *secondView;

@property (nonatomic, strong) UIScrollView *secondScrollView;

/* collectionView数据源 */
@property (nonatomic, strong) NSMutableArray *goodListArray;

/* 请求产品数据参数 */
@property (nonatomic, strong) NSMutableDictionary *goodParamDic;

/* 一级分类索引 */
@property (nonatomic, assign) NSInteger firstIndex;

/* 二级分类索引 */
@property (nonatomic, assign) NSInteger secondIndex;

@property (nonatomic, strong) NSArray *sortArray;

@property (nonatomic, assign) NSInteger firstMenuIndex;

@property (nonatomic, assign) NSInteger secondMenuIndex;

@end

@implementation DoubleMenuViewController

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

- (NSMutableArray *)goodListArray {
    
    if (_goodListArray == nil) {
        
        self.goodListArray = [NSMutableArray array];
    }
    
    return _goodListArray;
}

- (NSMutableDictionary *)goodParamDic {
    
    if (_goodParamDic == nil) {
        
        self.goodParamDic = [NSMutableDictionary dictionary];
    }
    
    return _goodParamDic;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* 初始化一级菜单选择 */
    self.firstMenuIndex = 1000;
    
    /* 初始化二级菜单tag */
    self.secondMenuIndex = 1000;
    
    /* 设置collectionView */
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryDetailCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryDetailCell"];
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    /* 创建一级菜单视图 */
    self.firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 60)];
    
    self.firstView.backgroundColor = [UIColor greenColor];
    
    self.firstScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 60)];

    [self.firstView addSubview:self.firstScrollView];
    
    [self.view addSubview:self.firstView];
    
    /* 创建二级视图菜单 */
    self.secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + FIRSTMENUHEIGHT, KWIDTH, SECONDMENUHEIGHT)];
    
    self.secondView.backgroundColor = [UIColor whiteColor];
    
    self.secondScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, SECONDMENUHEIGHT)];
    
    [self.secondView addSubview:self.secondScrollView];
    
    [self.view addSubview:self.secondView];
    
    /* 初始化索引数据:用来记录一级菜单和二级菜单分别点击了那个按钮 */
    self.firstIndex = 0;
    self.secondIndex = 0;
    
    /* 全部 菜单项中的排序方式 */
    self.sortArray = @[@"category_sort",@"view",@"sale"];
    
    /* 请求菜单数据 */
    self.paramDic = [@{@"action":self.action} mutableCopy];
    [self requestData];

    /* 请求产品数据 */
    self.goodParamDic = [@{@"action":@"zerogoodlist",@"order":@"category_sort",@"page":@"1"} mutableCopy];
    [self requestGoodsListData];
}

#pragma mark --- 初始化菜单选择
- (void)setFirstMenuSelect {
    
    UIButton *lastSelectBtn = [self.firstScrollView viewWithTag:self.firstMenuIndex];
    if (self.firstMenuIndex != 0) {
        
        lastSelectBtn.selected = NO;
    }
    
    lastSelectBtn.selected = YES;
}

#pragma mark --- 初始化菜单选择
- (void)setSecondMenuSelect {
    
    UIButton *lastSelectBtn = [self.secondScrollView viewWithTag:self.secondMenuIndex];
    if (self.secondMenuIndex != 0) {
        
        lastSelectBtn.selected = NO;
    }
    
    lastSelectBtn.selected = YES;
}

/* 请求数据 */
- (void)requestData {
    
    /* 添加数据之前，分类前面应该添加全部分类一项 */
    CategoryListDataModel *allModel = [[CategoryListDataModel alloc] init];
    
    allModel.name = @"全部";
    allModel.pro_id = @"100000000000000";
    
    [self.categoryListArray addObject:allModel];
    NSArray *allTmpArray = @[@"综合",@"人气",@"销量"];
    NSMutableArray *allFirstArray = [NSMutableArray array];
    
    for (int i=0;i<3;i++) {
        
        CategoryListDataModel *secondModel = [[CategoryListDataModel alloc] init];
        
        secondModel.pro_id = @"100000000000000";
        secondModel.name = allTmpArray[i];
        
        [allFirstArray addObject:secondModel];
    }
    
    [self.categoryListDic setObject:allFirstArray forKey:@"100000000000000"];
    
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
            CategoryListDataModel *allSecondModel = [[CategoryListDataModel alloc] init];
            
            allSecondModel.name = @"全部";
            [tmpArray addObject:allSecondModel];
            
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

#pragma mark --- 请求商品数据
- (void)requestGoodsListData {
    
    /* 再次请求前需要清空数据源 */
    [self.goodListArray removeAllObjects];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.goodParamDic success:^(id responseObject) {
        
        NSArray *dataArray = responseObject[@"list"];
        for (NSDictionary *dic in dataArray) {
            
            CategoryDetailModel *model = [[CategoryDetailModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.goodListArray addObject:model];
        }
        
        /* 刷新数据 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

- (void)createDoubleMenu {
    
    /* 设置scrollview内容区域大小 */
    [self.firstScrollView setContentSize:CGSizeMake(self.categoryListArray.count * 100, 60)];
    
    for (int i=0;i<self.categoryListArray.count;i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 60)];
        
        [btn setBackgroundColor:[UIColor greenColor]];
        [btn setTag:1000 + i];
        [btn addTarget:self action:@selector(firstCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
        
        /* 设置button选中和被选中颜色 */
        UIImage *selectColorImg = [ImageBackgroundColor ImageWithColor:[UIColor whiteColor]];
        [btn setBackgroundImage:selectColorImg forState:UIControlStateSelected];
        
        UIImage *selectNoneColorImg = [ImageBackgroundColor ImageWithColor:[UIColor greenColor]];
        [btn setBackgroundImage:selectNoneColorImg forState:UIControlStateNormal];
        
        CategoryListDataModel *model = self.categoryListArray[i];
        
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        /* 添加到scroller上面 */
        [self.firstScrollView addSubview:btn];
    }
    
    [self setFirstMenuSelect];
    
    /* 创建默认二级菜单 */
    [self creatSecondMenu:0];
    
    /* 初始化二级菜单默认选择 */
    [self setSecondMenuSelect];
}

#pragma mark --- 点击一级菜单事件
- (void)firstCategoryClick:(UIButton *)sender {
    
    NSInteger index = sender.tag - 1000;

    /* 获取上次点击的button */
    UIButton *lastSelectBtn = [self.firstScrollView viewWithTag:self.firstMenuIndex];
    if (self.firstMenuIndex != 0) {
        
        lastSelectBtn.selected = NO;
    }
    
    sender.selected = YES;
    
    self.firstMenuIndex = sender.tag;
    
    /* 记录一级菜单当前点击索引 */
    self.firstIndex = index;
    
    /* 根据点击的索引创建二级菜单项 */
    [self creatSecondMenu:index];
    
    /* 初始化二级菜单默认选择 */
    self.secondMenuIndex = 1000;
    [self setSecondMenuSelect];
    
    /* 点击一级菜单进行筛选 */
    CategoryListDataModel *model = self.categoryListArray[index];
    /* 设置排序参数 */
    
    /* 不管点击哪个，先把排序方式设置为默认 */
    [self.goodParamDic setValue:@"category_sort" forKey:@"order"];
    
    if (self.firstIndex == 0) {
        
        /* 如果点击的是全部，需要移除id参数 */
        [self.goodParamDic removeObjectForKey:@"id"];
        [self.goodParamDic removeObjectForKey:@"pid"];
    }else {
        
        /* 如果点击的是其他的一级菜单按钮 */
        /* 如果点击的还是当前的按钮，不做任何处理(先不考虑这种情况) */
        /* 首先移除pid参数 */
        /* 移除pid */
        [self.goodParamDic removeObjectForKey:@"pid"];
        
        /* 重新设置id参数 */
        if ([self.goodParamDic.allKeys containsObject:@"id"]) {
            
            [self.goodParamDic setValue:model.cat_id forKey:@"id"];
        }else {
            
            [self.goodParamDic setObject:model.cat_id forKey:@"id"];
        }
    }
    
    /* 再次请求参数 */
    [self requestGoodsListData];
}

#pragma mark --- 创建二级菜单
- (void)creatSecondMenu:(NSInteger)index {
    
    /* 首先要删除scrollView上的btn */
    for (UIView *view in self.secondScrollView.subviews) {
        
        [view removeFromSuperview];
    }
    
    /* 获取一级菜单模型数据 */
    CategoryListDataModel *model = self.categoryListArray[index];
    
    /* 点击对应btn的时候创建二级按钮 */
    /* 取出对应二级菜单的数组 */
    NSArray *secondMenuArray = [self.categoryListDic objectForKey:model.pro_id];
    
    /* 设置二级菜单滑动内容视图的宽度 */
    self.secondScrollView.contentSize = CGSizeMake(secondMenuArray.count * SECONDBTNWIDTH, SECONDMENUHEIGHT);
    
    /* 使用该数组创建菜单 */
    for (int i=0;i<secondMenuArray.count;i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * SECONDBTNWIDTH, 0, SECONDBTNWIDTH, SECONDMENUHEIGHT)];
        
        CategoryListDataModel *secondModel = secondMenuArray[i];
        [btn setTitle:secondModel.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTag:1000 + i];
        
        /* 设置选中文本颜色 */
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        /* 设置未选中颜色 */
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        /* 添加二级菜单点击事件 */
        [btn addTarget:self action:@selector(secondBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.secondScrollView addSubview:btn];
    }
}

#pragma mark --- 二级菜单点击事件
- (void)secondBtnClick:(UIButton *)sender {
    
    /* 获取btn下标索引 */
    NSInteger index = sender.tag - 1000;
    
    UIButton *lastSelectButton = [self.secondScrollView viewWithTag:self.secondMenuIndex];
    if (self.secondMenuIndex != 0) {
        
        lastSelectButton.selected = NO;
    }
    
    self.secondMenuIndex = sender.tag;
    
    sender.selected = YES;
    
    self.secondMenuIndex = sender.tag;
    /* 记录二级菜单点击索引 */
    self.secondIndex = index;
    
    /* 获取一级分类的模型数据 */
    CategoryListDataModel *firstModel = self.categoryListArray[self.firstIndex];
    
    /* 获取二级分类的模型数据 */
    NSArray *secondMenuArray = [self.categoryListDic objectForKey:firstModel.pro_id];
    
    CategoryListDataModel *secondModel = secondMenuArray[self.secondIndex];
    
    /* 设置请求参数 */
    if (self.firstIndex == 0) {
        
        /* 如果点击的是全部分类的中的二级按钮，则进行排序 */
        [self.goodParamDic setValue:self.sortArray[self.secondIndex] forKey:@"order"];
    }else {

        if (self.secondIndex == 0) {
            
            /* 移除pid */
            [self.goodParamDic removeObjectForKey:@"pid"];
            
            [self.goodParamDic setObject:@"category_sort" forKey:@"order"];
            
            [self.goodParamDic setObject:firstModel.cat_id forKey:@"id"];
            
        }else {
            
            /* 其他二级按钮则进行筛选 */
            if ([self.goodParamDic.allKeys containsObject:@"id"]) {
                
                [self.goodParamDic setValue:secondModel.cat_id forKey:@"id"];
            }else {
                
                [self.goodParamDic setObject:secondModel.cat_id forKey:@"id"];
            }
            
            if ([self.goodParamDic.allKeys containsObject:@"pid"]) {
                
                [self.goodParamDic setValue:secondModel.p_id forKey:@"pid"];
            }else {
                
                [self.goodParamDic setObject:secondModel.p_id forKey:@"pid"];
            }
        }
    }
    
    /* 重新请求商品数据 */
    [self requestGoodsListData];
}

#pragma mark --- 代理fangfa
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.goodListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryDetailCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    if (self.goodListArray.count > 0) {
        
        CategoryDetailModel *model = self.goodListArray[indexPath.row];
        
        cell.model = model;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.goodListArray.count > 0) {
        
        CategoryDetailModel *model = self.goodListArray[indexPath.row];
        
        /* 跳转到详情界面 */
        ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
        
        productDetailVC.goods_id = model.goods_id;
        
        productDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productDetailVC animated:YES];
    }
}

#pragma mark --- 返回item大小
#pragma 设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KWIDTH-20) / 2, (KWIDTH-20) * 2 / 2);
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































