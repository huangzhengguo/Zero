//
//  NewRootViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "NewRootViewController.h"

#import "NewRootReusableView.h"

/* 图标model 轮播图*/
#import "IconModel.h"

/* 文章数据源 */
#import "ArticleModel.h"

#import "IconButtonCell.h"

#import "ScrollThreeView.h"

/* 引入cell */
#import "SubjectCell.h"

#import "SubjectModel.h"

#import "GuessLikeCell.h"

#import "SuggestProductCell.h"

/* 热销商品model */
#import "HotProductModel.h"

#import "CollectionViewOneCell.h"

#import "ClotheModel.h"

#import "CollectionViewTwoCell.h"

#import "ProductListCell.h"

#import "RecommandModel.h"

#import "RootArticleCell.h"

#import "YouLikeHeaderView.h"

#import "NewRootSuggestHeaderView.h"

#import "GoodsInfoCollectionViewCell.h"

#import "GoodsPublicModel.h"

#import "ProductDetailViewController.h"

#import "ArticleViewController.h"

#import "ColorfulConsultViewController.h"

#import "ThemeViewController.h"

#import "LikeGoodsModel.h"

#import "YourLikeGoodsCell.h"

#import <MJRefresh.h>

#import "CategoryDetailViewController.h"

#import "DoubleCategoryViewController.h"

#import "DoubleMenuViewController.h"

#import "AllCategoryModel.h"

/* 搜索界面 */
#import "SearchViewController.h"

/* 新品区界面 */
#import "NewProductViewController.h"

/* 弹幕信息model */
#import "DanmakuModel.h"

@interface NewRootViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

/* 声明请求参数 */
@property (nonatomic, strong) NSDictionary *paramDic;

/* 轮播图及title数据源 */
@property (nonatomic, strong) NSMutableArray *bannerDataArray;

/* 轮播图片数据源 */
@property (nonatomic, strong) NSMutableArray *thumbDataArray;

/* 首页特卖推荐，精品区，新品区，零元夺宝，一元秒杀 数据源*/
@property (nonatomic, strong) NSMutableArray *iconDataArray;

/* icon图片 */
@property (nonatomic, strong) NSMutableArray *iconImgArray;

/* icon文字 */
@property (nonatomic, strong) NSMutableArray *iconTitleArray;

/* 轮播文章数据源 */
@property (nonatomic, strong) NSMutableArray *articleDataArray;

/* 主题街图片资源 */
@property (nonatomic, strong) NSMutableArray *subjectArray;

/* 零妹妹直播banner数据源 */
@property (nonatomic, strong) NSMutableArray *liveEntryArray;

/* 热销商品数据源 */
@property (nonatomic, strong) NSMutableArray *hotProductArray;

/* 热销商品图片数据源 */
@property (nonatomic, strong) NSMutableArray *hotProductImgArray;

/* 服装 */
@property (nonatomic, strong) NSMutableArray *clothesDataArray;

/* 居家日用 床上用品等 */
@property (nonatomic, strong) NSMutableArray *lifeDataArray;

/* 动态banner */
@property (nonatomic, strong) NSString *bannerImg;

/* 推荐产品数据源 */
@property (nonatomic, strong) NSMutableArray *recommendProduct;

/* 猜你喜欢数据源 */
@property (nonatomic, strong) NSMutableArray *youLikeDataArray;

/* 下拉上提标记 */
@property (nonatomic, assign) BOOL isDropdown;

@property (nonatomic, strong) NSMutableDictionary *recommandParamDic;
@property (nonatomic, assign) NSInteger page;

/* 自定义导航栏视图 */
@property (nonatomic, strong) UIView *navView;

/* 声明搜索框属性 */
@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation NewRootViewController
#pragma mark --- 懒加载部分
- (NSMutableArray *)recommendProduct {
    
    if (_recommendProduct == nil) {
        
        self.recommendProduct = [NSMutableArray array];
    }
    
    return _recommendProduct;
}

- (NSMutableArray *)clothesDataArray {
    
    if (_clothesDataArray == nil) {
        
        self.clothesDataArray = [NSMutableArray array];
    }
    
    return _clothesDataArray;
}

- (NSMutableArray *)iconDataArray {
    
    if (_iconDataArray == nil) {
        
        self.iconDataArray = [NSMutableArray array];
    }
    
    return _iconDataArray;
}

- (NSMutableArray *)iconImgArray {
    
    if (_iconImgArray == nil) {
        
        self.iconImgArray = [NSMutableArray array];
    }
    
    return _iconImgArray;
}

- (NSMutableArray *)iconTitleArray {
    
    if (_iconTitleArray == nil) {
        
        self.iconTitleArray = [NSMutableArray array];
    }
    
    return _iconTitleArray;
}

- (NSMutableArray *)bannerDataArray {
    
    if (_bannerDataArray == nil) {
        
        self.bannerDataArray = [NSMutableArray array];
    }
    
    return _bannerDataArray;
}

- (NSMutableArray *)thumbDataArray {
    
    if (_thumbDataArray == nil) {
        
        self.thumbDataArray = [NSMutableArray array];
    }
    
    return _thumbDataArray;
}

- (NSMutableArray *)articleDataArray {
    
    if (_articleDataArray == nil) {
        
        self.articleDataArray = [NSMutableArray array];
    }
    
    return _articleDataArray;
}

- (NSMutableArray *)subjectArray {
    
    if (_subjectArray == nil) {
        
        self.subjectArray = [NSMutableArray array];
    }
    
    return _subjectArray;
}

- (NSMutableArray *)liveEntryArray {
    
    if (_liveEntryArray == nil) {
        
        self.liveEntryArray = [NSMutableArray array];
    }
    
    return _liveEntryArray;
}

- (NSMutableArray *)hotProductArray {
    
    if (_hotProductArray == nil) {
        
        self.hotProductArray = [NSMutableArray array];
    }
    
    return _hotProductArray;
}

- (NSMutableArray *)hotProductImgArray {
    
    if (_hotProductImgArray == nil) {
        
        self.hotProductImgArray = [NSMutableArray array];
    }
    
    return _hotProductImgArray;
}

- (NSMutableArray *)lifeDataArray {
    
    if (_lifeDataArray == nil) {
        
        self.lifeDataArray = [NSMutableArray array];
    }
    
    return _lifeDataArray;
}

- (NSMutableArray *)youLikeDataArray {
    
    if (_youLikeDataArray == nil) {
        
        self.youLikeDataArray = [NSMutableArray array];
    }
    
    return _youLikeDataArray;
}

- (NSMutableDictionary *)recommandParamDic {
    
    if (_recommandParamDic == nil) {
        
        self.recommandParamDic = [NSMutableDictionary dictionary];
    }
    
    return _recommandParamDic;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    /* 临时代码 */
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    /* 注册轮播图视图 */
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewRootReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewRootReusableView"];
    
    /* 注册cell */
    [self.collectionView registerNib:[UINib nibWithNibName:@"IconButtonCell" bundle:nil] forCellWithReuseIdentifier:@"IconButtonCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RootArticleCell" bundle:nil] forCellWithReuseIdentifier:@"RootArticleCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YouLikeHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YouLikeHeaderView"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewRootSuggestHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewRootSuggestHeaderView"];

    [self.collectionView registerNib:[UINib nibWithNibName:@"GoodsInfoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsInfoCollectionViewCell"];
    
    [self.collectionView registerClass:[YourLikeGoodsCell class] forCellWithReuseIdentifier:@"YourLikeGoodsCell"];
    
    /* 初始化请求参数 */
    self.paramDic = @{@"action":@"home"};
    
    /* 初始化标记 */
    self.isDropdown = YES;
    
    [self requestData];
    
    /* 请求推荐数据 */
    self.page = 1;
    self.recommandParamDic = [@{@"action":@"homerecommend",@"":[NSString stringWithFormat:@"%ld",(long)self.page]} mutableCopy];
    [self requestRecommandData];
    
    /* 添加下拉刷新和上提加载功能 */
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        /* 设置标记 */
        self.isDropdown = YES;
        
        self.page = 1;
        /* 重新请求数据 */
        self.recommandParamDic = [@{@"action":@"homerecommend",@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} mutableCopy];
        [self requestData];
        [self requestRecommandData];
    }];

    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.isDropdown = NO;
        
        self.page ++;
        /* 重新请求数据 */
        self.recommandParamDic = [@{@"action":@"homerecommend",@"page":[NSString stringWithFormat:@"%ld",(long)self.page]} mutableCopy];
        [self requestRecommandData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.hidesBottomBarWhenPushed = NO;
    
    /* 添加弹幕定时器 */
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(danmakuAction) userInfo:nil repeats:YES];
    
    /* 设置搜索框 */
    [self createSearchBar];
}

#pragma mark --- 弹幕方法
- (void)danmakuAction {
    
    /* 发送弹幕信息请求 */
    [NetworkManager postRequestWithUrl:ZEROURL param:@{@"action":@"lastPurchase"} success:^(id responseObject) {
        
        /* 主线程弹出订单信息 */
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"1"]) {
            
            NSDictionary *dic = responseObject[@"data"];
            if ([[NSString stringWithFormat:@"%@",dic[@"code"]] isEqualToString:@"1"]) {
                
                NSDictionary *dataDic = dic[@"data"];
                DanmakuModel *model = [[DanmakuModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dataDic];
                
                UIView *danmakuView = [self.view viewWithTag:1000000];
                if (danmakuView == nil) {
                    
                    /* 创建view并弹出 */
                    danmakuView = [[UIView alloc] initWithFrame:CGRectMake(20, 70 + 40, KWIDTH - 40, 40)];
                    danmakuView.layer.cornerRadius = 20;
                    danmakuView.backgroundColor = [UIColor redColor];
                    danmakuView.tag = 1000000;
                    
                    /* 添加订单信息 */
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
                    
                    imgView.layer.cornerRadius = 15;
                    imgView.layer.masksToBounds = YES;
                    imgView.tag = 1000;
                    
                    [danmakuView addSubview:imgView];
                    
                    
                    /* 添加label */
                    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, KWIDTH - 40 - 30, 30)];
                    
                    orderLabel.tag = 1001;
                    [danmakuView addSubview:orderLabel];
                }
                
                /* 设置订单信息 */
                UIImageView *headerImg = [danmakuView viewWithTag:1000];
                
                [headerImg sd_setImageWithURL:[NSURL URLWithString:[model.img_s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
                
                UILabel *orderLabel = [danmakuView viewWithTag:1001];
                
                orderLabel.text = [NSString stringWithFormat:@"%@",model.content];
                
                danmakuView.hidden = NO;
                danmakuView.backgroundColor = [UIColor grayColor];
                danmakuView.alpha = 0.8;
                [danmakuView setFrame:CGRectMake(20, 70 + 40, KWIDTH - 40, 40)];
                
                [self.view addSubview:danmakuView];
                
                [UIView animateWithDuration:0.6 animations:^{
                    
                    /* 只有在首页才会弹出 */
                    //danmakuView.backgroundColor = [UIColor grayColor];
                    [danmakuView setFrame:CGRectMake(20, 70, KWIDTH - 40, 40)];
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:3 animations:^{
                        
                        /* 在原地停留3秒 */
                        [danmakuView setFrame:CGRectMake(20, 69, KWIDTH - 40, 40)];
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.6 animations:^{
                            
                            [danmakuView setFrame:CGRectMake(20, 70 - 40, KWIDTH - 40, 40)];
                        } completion:^(BOOL finished) {
                        
                            danmakuView.hidden = YES;
                        }];
                    }];
                }];
            }
        }
        
    } fail:^(NSError *error) {
        
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    /* 设置导航栏颜色 */
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    [self.searchView removeFromSuperview];
}

#pragma mark --- 自定义导航栏
- (void)createSearchBar {
    
    CGRect searchFrame = CGRectMake(10, 10, KWIDTH - 80, 30);
    
    /* 创建搜索框视图 */
    self.searchView = [[UIView alloc] initWithFrame:searchFrame];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.layer.cornerRadius = 10;
    self.searchView.layer.masksToBounds = 10;
    
    /* 创建textfield并且添加到搜索视图中 */
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, KWIDTH - 80, 35)];
    /* 设置搜索框代理 */
    self.searchTextField.delegate = self;
    self.searchTextField.alpha = 0.5;
    self.searchTextField.layer.cornerRadius = 10;
    self.searchTextField.layer.masksToBounds = YES;
    self.searchTextField.placeholder = @"搜索您喜欢的";
    
    [self.searchView addSubview:self.searchTextField];

    [self.navigationController.navigationBar addSubview:self.searchView];
    
    /* 设置导航栏颜色 */
    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
}

- (void)setupCellectionLayout {
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    /* 跳转到搜索界面 */
    SearchViewController *searchVC = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:[NSBundle mainBundle]];
    
    /* 跳转 */
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark --- 请求首页数据
- (void)requestData {
    
    /* 每次重新请求前需要清空所有数据源 */
    [self.thumbDataArray removeAllObjects];
    [self.bannerDataArray removeAllObjects];
    [self.iconImgArray removeAllObjects];
    [self.iconTitleArray removeAllObjects];
    [self.iconDataArray removeAllObjects];
    [self.articleDataArray removeAllObjects];
    [self.liveEntryArray removeAllObjects];
    [self.subjectArray removeAllObjects];
    [self.hotProductImgArray removeAllObjects];
    [self.hotProductArray removeAllObjects];
    [self.clothesDataArray removeAllObjects];
    [self.lifeDataArray removeAllObjects];
    [self.youLikeDataArray removeAllObjects];

    
    /* 上提加载时，首页推荐数据需要更新加载更多，其他不需要 */
    
    [NetworkManager getRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        /* 获取轮播图 */
        NSArray *bannerArray = responseObject[@"home"][@"banner"][@"items"];
        for (NSDictionary *dic in bannerArray) {
            
            IconModel *model = [[IconModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            /* 轮播图图片 */
            [self.thumbDataArray addObject:model.img];
            
            /* 添加到数据源 */
            [self.bannerDataArray addObject:model];
        }
        
        /* 获取中间图标 */
        NSArray *iconArray = responseObject[@"home"][@"icon"];
        for (NSDictionary *dic in iconArray) {
            
            IconModel *model = [[IconModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.iconImgArray addObject:model.img];
            [self.iconTitleArray addObject:model.title];
            /* 添加到数据源 */
            [self.iconDataArray addObject:model];
        }
        
        /* 获取轮播文章数据 */
        NSArray *articleArray = responseObject[@"home"][@"article"];
        for (NSDictionary *dic in articleArray) {
            
            ArticleModel *model = [[ArticleModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            /* 添加到数据源 */
            [self.articleDataArray addObject:model];
        }
        
        /* 获取banner */
        NSDictionary *liveDic = responseObject[@"home"][@"live_entry"];
        
        IconModel *liveModel = [[IconModel alloc] init];
        
        [liveModel setValuesForKeysWithDictionary:liveDic];
        [self.liveEntryArray addObject:liveModel];
        
        /* 获取主题街资源 */
        SubjectModel *homeLeftModel = [[SubjectModel alloc] init];
        homeLeftModel.ad_id = responseObject[@"home"][@"homeLeft"][@"ad_id"];
        homeLeftModel.url = responseObject[@"home"][@"homeLeft"][@"items"][0][@"url"];
        homeLeftModel.image = responseObject[@"home"][@"homeLeft"][@"items"][0][@"image"];
        homeLeftModel.title = responseObject[@"home"][@"homeLeft"][@"items"][0][@"title"];
        homeLeftModel.appurl = responseObject[@"home"][@"homeLeft"][@"items"][0][@"appurl"];
        
        [self.subjectArray addObject:homeLeftModel];
        
        SubjectModel *homeRight1Model = [[SubjectModel alloc] init];
        homeRight1Model.ad_id = responseObject[@"home"][@"homeRight1"][@"ad_id"];
        homeRight1Model.url = responseObject[@"home"][@"homeRight1"][@"items"][0][@"url"];
        homeRight1Model.image = responseObject[@"home"][@"homeRight1"][@"items"][0][@"image"];
        homeRight1Model.title = responseObject[@"home"][@"homeRight1"][@"items"][0][@"title"];
        homeRight1Model.appurl = responseObject[@"home"][@"homeRight1"][@"items"][0][@"appurl"];
        
        [self.subjectArray addObject:homeRight1Model];
        
        SubjectModel *homeRight2Model = [[SubjectModel alloc] init];
        homeRight2Model.ad_id = responseObject[@"home"][@"homeRight2"][@"ad_id"];
        homeRight2Model.url = responseObject[@"home"][@"homeRight2"][@"items"][0][@"url"];
        homeRight2Model.image = responseObject[@"home"][@"homeRight2"][@"items"][0][@"image"];
        homeRight2Model.title = responseObject[@"home"][@"homeRight2"][@"items"][0][@"title"];
        homeRight2Model.appurl = responseObject[@"home"][@"homeRight2"][@"items"][0][@"appurl"];
        
        [self.subjectArray addObject:homeRight2Model];
        
        NSArray *rightThree = responseObject[@"home"][@"rightThree"];
        for (NSDictionary *dic in rightThree) {
            
            SubjectModel *homeRight3Model = [[SubjectModel alloc] init];
            
            homeRight3Model.image = dic[@"img"];
            homeRight3Model.title = dic[@"title"];
            homeRight3Model.appurl = dic[@"appurl"];
            
            [self.subjectArray addObject:homeRight3Model];
        }
        
        /* 获取热销商品 */
        NSArray *hotListArray = responseObject[@"home"][@"hotlist"];
        for (NSDictionary *dic in hotListArray) {
            
            HotProductModel *model = [[HotProductModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.hotProductImgArray addObject:dic[@"default_image"]];
            
            [self.hotProductArray addObject:model];
        }
        
        /* 获取展示数据:公告上面四个数据 */
        NSArray *clothesArray = responseObject[@"home"][@"ad"][@"two"];
        for (NSDictionary *dic in clothesArray) {
            
            ClotheModel *model = [[ClotheModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.clothesDataArray addObject:model];
        }
        
        /* 公告下面数据 */
        NSArray *lifeArray = responseObject[@"home"][@"ad"][@"three"];
        for (NSDictionary *dic in lifeArray) {
            
            ClotheModel *model = [[ClotheModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.lifeDataArray addObject:model];
        }
        
        /* act_banner: */
        NSArray *act_bannerArray = responseObject[@"home"][@"act_banner"][@"items"];
        if (act_bannerArray.count > 0) {
            
            self.bannerImg = act_bannerArray[0][@"image"];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 请求完成数据后移除刷新加载动画 */
            [self.collectionView.mj_header endRefreshing];
            
            /* 刷新数据 */
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    /* 请求猜你喜欢数据 */
    [NetworkManager getRequestWithUrl:ZEROURLLIKE param:@{} success:^(id responseObject) {
        
        /* 请求猜你喜欢数据 */
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            
            LikeGoodsModel *model = [[LikeGoodsModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.youLikeDataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 请求完成数据后移除刷新加载动画 */
            [self.collectionView.mj_header endRefreshing];
            
            /* 刷新对应分区行 */
            //[self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
            //[self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- 请求推荐数据
- (void)requestRecommandData {
    
    /* 对于首页推荐数据，如果是下拉的话需要清空数据，如果是上提则不清空 */
    if (self.isDropdown == YES) {
        
        [self.recommendProduct removeAllObjects];
    }
    
    /* 首页推荐 */
    [NetworkManager postRequestWithUrl:ZEROURL param:self.recommandParamDic success:^(id responseObject) {
        
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            
            RecommandModel *model = [[RecommandModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.recommendProduct addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 请求完成数据后移除刷新加载动画 */
            [self.collectionView.mj_footer endRefreshing];
            
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        

    }];
}

#pragma mark --- collection代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 2;
    }else if (section == 1) {
        
        return 1;
    }else if (section == 2) {
        
        return self.recommendProduct.count;
    }
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            IconButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IconButtonCell" forIndexPath:indexPath];
            
            /* 实现block */
            cell.btnClock = ^(NSInteger index) {
                
                if (index == 0) {
                    
                    /* 跳转到特卖推荐 */
                    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    
                    DoubleMenuViewController *doubleMenuVC = [mainStory instantiateViewControllerWithIdentifier:@"DoubleMenuViewController"];
                    
                    doubleMenuVC.action = @"特卖推荐";
                    doubleMenuVC.action = @"zerocategory";
                    doubleMenuVC.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:doubleMenuVC animated:YES];
                }else if (index == 1) {
                    
                    /* 跳转到精品区 */
                    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                    
                    DoubleMenuViewController *doubleMenuVC = [mainStory instantiateViewControllerWithIdentifier:@"DoubleMenuViewController"];
                    
                    doubleMenuVC.title = @"精品区";
                    doubleMenuVC.action = @"category";
                    doubleMenuVC.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:doubleMenuVC animated:YES];
                }else if (index == 2) {
                    
                    /* 跳转到新品区 */
                    NewProductViewController *newProductVC = [[NewProductViewController alloc] init];
                    
                    newProductVC.title = @"新品区";
                    
                    [self.navigationController pushViewController:newProductVC animated:YES];
                }else if (index == 3) {
                    
                    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
                }else if (index == 4) {
                    
                    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
                }
            };
            
            /* 创建button */
            if (self.iconImgArray.count > 0 && self.iconTitleArray.count > 0) {
                
                [self.iconTitleArray removeAllObjects];
                self.iconTitleArray = [@[@"特卖推荐",@"精品区",@"新品区",@"分类",@"专题"] mutableCopy];
                [cell createBtnWithImgArr:self.iconImgArray titleArray:self.iconTitleArray];
                //[cell createBtnWithImgArr:self.iconImgArray titleArray:self.iconTitleArray btnCount:self.iconTitleArray.count];
            }
            
            return cell;
        }else {
            
            /* 滚动文章区域 */
            RootArticleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootArticleCell" forIndexPath:indexPath];

            /* 传递文章数据到cell */
            if (self.articleDataArray.count > 0) {
                
                cell.articleDataArray = self.articleDataArray;
            }
            
            /* 实现btn点击block */
            cell.clickBlock = ^(NSInteger index) {
                
                if (self.articleDataArray.count > 0) {
                    
                    ColorfulConsultViewController *colorfulConsultVC = [[ColorfulConsultViewController alloc] init];
                    
                    /* 传递类型 */
                    /* 
                     * 101:美文阅读
                     * 102:生活百科
                     * 103:快乐分享
                     */
                    colorfulConsultVC.class_id = [NSString stringWithFormat:@"%d",index + 100];
                    
                    /* 跳转 */
                    [self.navigationController pushViewController:colorfulConsultVC animated:YES];
                }

            };
            
            cell.articleClickBlock = ^(NSString *article_id,NSString *class_id) {
              
                /* 根据article_id跳转到文章界面 */
                ArticleViewController *articleVC = [[ArticleViewController alloc] init];
                
                articleVC.article_id = article_id;
                articleVC.class_id = class_id;
                
                [self.navigationController pushViewController:articleVC animated:YES];
            };
            
            return cell;
        }

    }else if (indexPath.section == 1) {
        
        /* 轮播图cell */
        YourLikeGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YourLikeGoodsCell" forIndexPath:indexPath];
        
        if (self.youLikeDataArray.count > 0) {
            
            cell.array = self.youLikeDataArray;
        }
        
        cell.selectBlock = ^ (NSString *goods_id) {
            
            ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
            
            productDetailVC.goods_id = goods_id;
            
            productDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        };
        
        return cell;
    }else {
        
        GoodsInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsInfoCollectionViewCell" forIndexPath:indexPath];
        
        if (self.recommendProduct.count > 0) {
            
            RecommandModel *model = self.recommendProduct[indexPath.row];
            
            cell.model = model;
        }
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return CGSizeMake(KWIDTH, 150);
    }else if (section == 1) {
        
        return CGSizeMake(KWIDTH, 120 + KWIDTH * 3 / 4 + 40);
    }else if (section == 2) {
        
        return CGSizeMake(KWIDTH, 50 + KWIDTH * 3 / 2 + 50);
    }
    
    return CGSizeMake(KWIDTH, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            /* 重用轮播图 */
            NewRootReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewRootReusableView" forIndexPath:indexPath];
            if (self.thumbDataArray.count > 0) {
                
                headerView.cycScrollView.imageURLStringsGroup = self.thumbDataArray;
                
                /* 实现轮播图跳转功能：点击轮播图时会把点击的图片的下标传递过来 */
                headerView.cycBlock = ^(NSInteger index) {
                    
                    
                };
            }

            return headerView;
        }
    }else if (indexPath.section == 1) {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            /* 猜你喜欢 */
            YouLikeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YouLikeHeaderView" forIndexPath:indexPath];
            
            /* 对零妹妹及主题街图片赋值 */
            if (self.liveEntryArray.count > 0) {
                
                /* 取出 */
                IconModel *model = self.liveEntryArray[0];
                UIView *view = [headerView viewWithTag:1000];
                UIImageView *imgView = [view viewWithTag:10000];
                
                [imgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
            }
            
            /* 添加主题街 */
            //UIView *view = [headerView viewWithTag:1001];
            
            if (self.subjectArray.count > 0) {
                
                for (int i=0;i<self.subjectArray.count;i++) {
                    
                    SubjectModel *model = self.subjectArray[i];
                    
                    UIView *view = [headerView viewWithTag:(1002 + i)];
                    UIImageView *imgView = [view viewWithTag:10000];
                    
                    [imgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
                }
                
            }
            
            /* 实现view的block接收回传的tag值，跳转界面 */
            headerView.viewTapBlock = ^ (NSInteger tag) {
                
                NSInteger index = tag - 1000;
                if (index == 0) {
                    
                    /* 零妹妹直播跳转 */
                }else if (index == 1) {
                    
                    /* 不做处理 */
                }else if (index < self.subjectArray.count + 2){
                    
                    /* 跳转到指定主题 */
                    //SubjectModel *model = self.subjectArray[index-2];
                    
                    //ThemeViewController *themeVC = [[ThemeViewController alloc] init];
                    
                    //[self.navigationController pushViewController:themeVC animated:YES];
                }
            };
            
            return headerView;
        }
    }else if (indexPath.section == 2) {
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            /* 首页推荐区头 */
            NewRootSuggestHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewRootSuggestHeaderView" forIndexPath:indexPath];
            
            if (self.clothesDataArray.count > 0) {

                /* 图片和标题赋值 */
                for (int i=0;i<self.clothesDataArray.count;i++) {
                    
                    UIView *view = [headerView viewWithTag:(10000 + i + 1)];
                    
                    /* 处理带文字的图片 */
                    /* 取出model */
                    ClotheModel *model = self.clothesDataArray[i];
                    
                    UILabel *labelOne = [view viewWithTag:100001];
                    UILabel *labelTwo = [view viewWithTag:100002];
                    UIImageView *imgView = [view viewWithTag:100003];
                    
                    labelOne.text = model.title;
                    labelTwo.text = model.stitle;
                    
                    [imgView sd_setImageWithURL:[NSURL URLWithString:[model.img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
                }
            }
            
            if (self.lifeDataArray.count > 0) {
                
                for (int i=0;i<self.lifeDataArray.count;i++) {
                    
                    UIView *view = [headerView viewWithTag:(10000 + i + 6)];
                    
                    /* 处理带文字的图片 */
                    /* 取出model */
                    ClotheModel *model = self.lifeDataArray[i];
                    
                    UILabel *labelOne = [view viewWithTag:100001];
                    UILabel *labelTwo = [view viewWithTag:100002];
                    UIImageView *imgView = [view viewWithTag:100003];
                    
                    labelOne.text = model.title;
                    labelTwo.text = model.stitle;
                    
                    [imgView sd_setImageWithURL:[NSURL URLWithString:[model.img stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
                }
            }
            
            if (self.bannerImg != nil) {
                
                UIView *view = [headerView viewWithTag:(10000 + 5)];
                
                /* 处理图片 */
                UIImageView *imgView = [view viewWithTag:100000];

                [imgView sd_setImageWithURL:[NSURL URLWithString:[self.bannerImg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
            }
            
            /* 设置首页推荐标题 */
            UIView *view = [headerView viewWithTag:(10000 + 14)];
            UILabel *label = [view viewWithTag:100001];
            
            label.text = @"首页推荐";
            label.textAlignment = NSTextAlignmentCenter;
            
            /* 实现block接收tag值 */
            headerView.viewTapBlock = ^ (NSInteger tag) {
                
                NSInteger index = tag - 10000;
                if (index < 5) {
                    
                    ClotheModel *model = self.clothesDataArray[index - 1];
                    //http://www.0gow.com/category/index?id=332&pid=324
                    NSString *urlParam = [model.url substringFromIndex:35];
                    NSArray *paramArray = [urlParam componentsSeparatedByString:@"&"];
                    
                    //获取参数
                    CategoryModel *paramModel = [[CategoryModel alloc] init];
                    
                    paramModel.cat_id = [paramArray[0] substringFromIndex:3];
                    paramModel.p_id = [paramArray[1] substringFromIndex:4];
                    
                    CategoryDetailViewController *categoryDetailVC = [[CategoryDetailViewController alloc] init];
                    
                    categoryDetailVC.title = model.title;
                    categoryDetailVC.model = paramModel;
                    /* 跳转 */
                    categoryDetailVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:categoryDetailVC animated:YES];
                }else if (index > 5) {
                    
                    ClotheModel *model = self.lifeDataArray[index - 6];
                    
                    NSString *urlParam = [model.url substringFromIndex:35];
                    NSArray *paramArray = [urlParam componentsSeparatedByString:@"&"];
                    
                    //获取参数
                    CategoryModel *paramModel = [[CategoryModel alloc] init];
                    
                    paramModel.cat_id = [paramArray[0] substringFromIndex:3];
                    paramModel.p_id = [paramArray[1] substringFromIndex:4];
                    
                    CategoryDetailViewController *categoryDetailVC = [[CategoryDetailViewController alloc] init];
                    categoryDetailVC.title = model.title;
                    categoryDetailVC.model = paramModel;
                    /* 跳转 */
                    categoryDetailVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:categoryDetailVC animated:YES];
                }
            };
            
            return headerView;
        }
    }
    
    /* 防止其它其它情况出错 */
    return [[UICollectionReusableView alloc] init];
}

//#pragma 设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return CGSizeMake(KWIDTH - 10, 110);
    }else if (indexPath.section == 1) {
        
        return CGSizeMake(KWIDTH - 10, 130);
    }else if (indexPath.section == 2) {
        
        return CGSizeMake((KWIDTH - 40) / 2, KWIDTH * 4 / 5);
    }
    
    
    return CGSizeMake(20, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 跳转 */
    if (indexPath.section == 2) {
        
        /* 首页推荐中的跳转 */
        RecommandModel *model = self.recommendProduct[indexPath.row];
        
        ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
        
        productDetailVC.goods_id = model.goods_id;
        
        productDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:productDetailVC animated:YES];        
    }
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
