//
//  CategoryViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CategoryViewController.h"

#import "CategoryCell.h"

#import "CategoryHeaderReusableView.h"

#import "CategoryModel.h"

#import "AllCategoryModel.h"

/* 分类详情界面 */
#import "CategoryDetailViewController.h"

/* 自定义flowlayout */
#import "CategoryCollectionViewFlowLayout.h"

@interface CategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/* 存储所有类别的数据源 */
@property (nonatomic, strong) NSMutableArray *allCategoryArray;

@property (nonatomic, strong) NSMutableDictionary *allDataDic;

/* 请求参数字典 */
@property (nonatomic, strong) NSDictionary *paramDic;

/* 菜单 */
@property (nonatomic, strong) UIView *menuView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL isUnfold;

@property (nonatomic, assign) NSInteger menuSelectBtnTag;

@end

@implementation CategoryViewController

#pragma mark --- 懒加载部分
- (NSMutableArray *)allCategoryArray {
    
    if (_allCategoryArray == nil) {
        
        self.allCategoryArray = [NSMutableArray array];
    }
    
    return _allCategoryArray;
}

- (NSMutableDictionary *)allDataDic {
    
    if (_allDataDic == nil) {
        
        self.allDataDic = [NSMutableDictionary dictionary];
    }
    
    return _allDataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 初始化菜单选中 */
    self.menuSelectBtnTag = 1000;
    
    /* 初始化标记 */
    self.isUnfold = false;
    
    /* 初始化请求参数 */
    self.paramDic = @{@"action":@"category"};
    
    /* 设置流布局 */
//    CategoryCollectionViewFlowLayout *flowLayout = [[CategoryCollectionViewFlowLayout alloc] init];
//    
//    [self.collectionView setCollectionViewLayout:flowLayout];
    
    /* 设置collectionView代理 */
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    /* 注册区头 */
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CategoryHeaderReusableView"];
    
    /* 注册cell*/
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryCell"];
    
    /* 在collection上面创建一个view */
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 64)];

    self.menuView.layer.borderWidth = 1;
    self.menuView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.menuView];
    
    /* 请求分类数据 */
    [self requestData];
    
    /* 添加下拉刷新 */
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        [self requestData];
    }];
}

#pragma mark --- 菜单添加button及scrollview
- (void)addContentToMenuView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 64)];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.scrollView setContentSize:CGSizeMake(self.allCategoryArray.count * 85, 64)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.menuView addSubview:self.scrollView];
    /* 创建btn到菜单中 */
    for (int i=0;i<self.allCategoryArray.count;i++) {
        AllCategoryModel *tmpModel = self.allCategoryArray[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * 80, 0, 80, 64)];
        
        [btn setTitle:tmpModel.name forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTag:1000 + i];
        [btn addTarget:self action:@selector(btnJumpClick:) forControlEvents:UIControlEventTouchUpInside];
        
        /* 设置button未选中时文本颜色 */
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        /* 设置button选中时文本颜色 */
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self.scrollView addSubview:btn];
    }
    
    /* 添加点击弹出框btn */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(KWIDTH - 40, 0, 40, 64);
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"arrow_01_up"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    
    /* 添加事件 */
    [btn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.menuView addSubview:btn];
    
    UIButton *currentBtn = [SetMenuButton setButtonWithLastSelectButtonTag:self.menuSelectBtnTag currentButtunTag:self.menuSelectBtnTag superView:self.menuView normalColor:[UIColor whiteColor] selectedColor:[UIColor orangeColor]];
    
    currentBtn.selected = YES;
}

#pragma mark --- btn点击事件
- (void)menuBtnClick:(UIButton *)sender {
    
    if (self.isUnfold == true) {
        
        [sender setBackgroundImage:[UIImage imageNamed:@"arrow_01_up"] forState:UIControlStateNormal];
        /* 移除视图并返回 */
        [[self.view viewWithTag:10000] removeFromSuperview];
        [[self.view viewWithTag:10001] removeFromSuperview];
        
        self.isUnfold = false;
        return;
    }
    
    [sender setBackgroundImage:[UIImage imageNamed:@"arrow_01_down"] forState:UIControlStateNormal];
    self.isUnfold = true;
    
    /* 创建一个view，上面再添加一个view，后一个view上面添加 */
    UIView *globalView = [[UIView alloc] initWithFrame:CGRectMake(0, 128, KWIDTH, KHEIGHT)];
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 128, KWIDTH, (KHEIGHT - 128) * 5 / 6)];
    
    globalView.backgroundColor = [UIColor lightGrayColor];
    globalView.tag = 10000;
    
    
    subView.backgroundColor = [UIColor whiteColor];
    subView.tag = 10001;
    
    /* 设置底层视图的透明度 */
    globalView.alpha = 0.8;
    
    NSInteger width = KWIDTH / 4;
    NSInteger originY = 0;
    /* 创建btn并添加到视图中 */
    for (int i=0;i<self.allCategoryArray.count;i++) {
    
        AllCategoryModel *tmpModel = self.allCategoryArray[i];
        NSInteger remind = i % 4;
        if (remind == 0) {
            
            width = 0;
        }else {
            
            width = KWIDTH / 4;
        }
        
        originY = i / 4 * 64;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(remind * width, originY, KWIDTH / 4, 64)];
        
        [btn setTitle:tmpModel.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderWidth = 1;
        [btn setTag:1000 + i];
        [btn addTarget:self action:@selector(btnJumpClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [subView addSubview:btn];
    }
    
    [self.view addSubview:globalView];
    [self.view addSubview:subView];
}

#pragma mark --- 点击btn跳转的事件
- (void)btnJumpClick:(UIButton *)sender {
    UIButton *currentBtn = [SetMenuButton setButtonWithLastSelectButtonTag:self.menuSelectBtnTag currentButtunTag:sender.tag superView:self.menuView normalColor:[UIColor whiteColor] selectedColor:[UIColor orangeColor]];
    
    currentBtn.selected = YES;
    self.menuSelectBtnTag = sender.tag;
    
    // AllCategoryModel *tmpModel = self.allCategoryArray[sender.tag - 1000];
    
    // NSLog(@"%@",tmpModel.name);
    
    /* collection滚动到指定位置 */
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(sender.tag - 1000)] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    if (sender.tag - 1000 != 0) {
        
        CGPoint point = self.collectionView.contentOffset;
        
        point.y -= 100;
        [self.collectionView setContentOffset:point];
    }
    
    /* 如果视图显示则移除 */
    if (self.isUnfold == true) {
        
        /* 移除视图并返回 */
        [[self.view viewWithTag:10000] removeFromSuperview];
        [[self.view viewWithTag:10001] removeFromSuperview];
        
        self.isUnfold = false;
        return;
    }
}

#pragma mark --- 请求数据
- (void)requestData {
    
    [self.allDataDic removeAllObjects];
    [self.allCategoryArray removeAllObjects];
    
    [NetworkManager getRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSArray *listArray = responseObject[@"list"];
        for (NSDictionary *dic in listArray) {
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            NSArray *tmpListArray = dic[@"list"];
            for (NSDictionary *tmpDic in tmpListArray) {
                
                CategoryModel *model = [[CategoryModel alloc] init];
                
                [model setValuesForKeysWithDictionary:tmpDic];
                
                [tmpArray addObject:model];
            }
            
            /* 遍历完之后添加这里类数据到字典中 */
            [self.allDataDic setObject:tmpArray forKey:dic[@"id"]];
            
            /* 存储类别信息 */
            AllCategoryModel *tmpModel = [[AllCategoryModel alloc] init];
            
            tmpModel.catagery_id = dic[@"id"];
            tmpModel.name = dic[@"name"];
            tmpModel.cat_id = dic[@"cat_id"];
            tmpModel.p_id = dic[@"p_id"];
            tmpModel.img = dic[@"img"];
            
            [self.allCategoryArray addObject:tmpModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView.mj_header endRefreshing];
            
            [self addContentToMenuView];
            
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.allCategoryArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    /* 先取出array */
    AllCategoryModel *keyMode = self.allCategoryArray[section];
    NSArray *array = [self.allDataDic objectForKey:keyMode.catagery_id];
    
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    if (self.allCategoryArray.count > 0 && self.allDataDic.count > 0) {
        
        /* 取出要显示第几个分区 */
        AllCategoryModel *keyMode = self.allCategoryArray[indexPath.section];
        
        /* 取出第几个分区的数据源 */
        NSArray *dataArray = [self.allDataDic objectForKey:keyMode.catagery_id];
        
        /* 显配置cell */
        cell.model = dataArray[indexPath.row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 跳转到分类二级页面 */
    CategoryDetailViewController *detailVC = [[CategoryDetailViewController alloc] init];
    
    /* 传递参数 */
    AllCategoryModel *keyModel = self.allCategoryArray[indexPath.section];
    NSArray *dataArray = [self.allDataDic objectForKey:keyModel.catagery_id];
    
    detailVC.model = dataArray[indexPath.row];
    detailVC.title = keyModel.name;
    
    /* 跳转时隐藏tabBar */
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(KWIDTH, 90);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CategoryHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CategoryHeaderReusableView" forIndexPath:indexPath];
        
        if (self.allCategoryArray.count > 0) {
            
            AllCategoryModel *keyMode = self.allCategoryArray[indexPath.section];
            headerView.titleLB.text = keyMode.name;
        }
        
        return headerView;
    }

    return [[UICollectionReusableView alloc] init];
}

#pragma 设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KWIDTH-30) / 3, (KWIDTH-30) / 3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end















































