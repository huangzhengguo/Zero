//
//  RootViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "RootViewController.h"

/* 图标model 轮播图*/
#import "IconModel.h"

/* 文章数据源 */
#import "ArticleModel.h"

#import "IconBtnView.h"

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

#import <MJRefresh/MJRefresh.h>

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

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

/* 轮播文章数据源 */
@property (nonatomic, strong) NSMutableArray *articleDataArray;

/* 首页使用一个tableView和collectionView实现 */
@property (nonatomic, strong) UITableView *tableView;

/* 轮播图属性 */
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

/* btn按钮创建 */
@property (nonatomic, strong) IconBtnView *iconBtnView;

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

/* 推荐产品数据源 */
@property (nonatomic, strong) NSMutableArray *recommendProduct;

@end

@implementation RootViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 初始化请求参数 */
    self.paramDic = @{@"action":@"home"};
 
    /* 创建tableView */
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    /* 添加到视图上 */
    [self.view addSubview:self.tableView];
    
    /* 注册cell */
    [self.tableView registerNib:[UINib nibWithNibName:@"SubjectCell" bundle:nil] forCellReuseIdentifier:@"SubjectCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GuessLikeCell" bundle:nil] forCellReuseIdentifier:@"GuessLikeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SuggestProductCell" bundle:nil] forCellReuseIdentifier:@"SuggestProductCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewOneCell" bundle:nil] forCellReuseIdentifier:@"CollectionViewOneCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionViewTwoCell" bundle:nil] forCellReuseIdentifier:@"CollectionViewTwoCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductListCell" bundle:nil] forCellReuseIdentifier:@"ProductListCell"];
    
    
    /* 创建tableview头视图 */
    [self createtableHeaderView];
    
    /* 请求数据 */
    [self requestData];
}

#pragma mark --- 创建表头视图
- (void)createtableHeaderView {
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 360)];
    
    /* 整个透视图为灰色背景 */
    self.tableView.backgroundColor = [UIColor grayColor];
    
    /* 创建轮播图 */
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KWIDTH, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    [self.tableView.tableHeaderView addSubview:self.cycleScrollView];
}

#pragma mark --- 请求首页数据
- (void)requestData {
    
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
        
        /* 获取展示数据 */
        NSArray *clothesArray = responseObject[@"home"][@"ad"][@"two"];
        for (NSDictionary *dic in clothesArray) {
            
            ClotheModel *model = [[ClotheModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.clothesDataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 由于轮播图 按钮及滚动都是网络数据，需要重新设置 */
            self.cycleScrollView.imageURLStringsGroup = self.thumbDataArray;
            
            /* 创建五个按钮 */
            self.iconBtnView = [[IconBtnView alloc] initWithFrame:CGRectMake(0, 170, KWIDTH, 80)];
            
            [self.tableView.tableHeaderView addSubview:self.iconBtnView];
            
            /* 设置btn图片 */
            self.iconBtnView.btnArray = self.iconDataArray;
            
            /* 创建生活百科 快乐分享 美文阅读部分 */
            ScrollThreeView *scrollThreeView = [[ScrollThreeView alloc]initWithFrame:CGRectMake(0, 250, KWIDTH, 110)];
            
            /* 实现btn block回调 */
            scrollThreeView.btnBlock = ^ (NSInteger index) {
                
                /* 点击 */
                NSLog(@"%@",@(index));
                
            };
            
            [self.tableView.tableHeaderView addSubview:scrollThreeView];
            
           /* 刷新数据 */
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
    /* 首页推荐 */
    [NetworkManager getRequestWithUrl:ZEROURL param:@{@"action":@"homerecommend"} success:^(id responseObject) {
        
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            
            RecommandModel *model = [[RecommandModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.recommendProduct addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
    
    
}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3) {
        
        return self.recommendProduct.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell" forIndexPath:indexPath];
        
        if (self.liveEntryArray.count > 0) {
            
            IconModel *model = self.liveEntryArray[0];
            [cell.imgOneView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        }
        
        if (self.subjectArray.count > 0) {
            
            [cell setCellWithArray:self.subjectArray];
        }
        
        return cell;
    }else if (indexPath.section == 1) {
        
        /* 放置轮播图 */
        GuessLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuessLikeCell" forIndexPath:indexPath];

        if (self.hotProductArray.count > 0) {
            
            [cell setScrollViewWithArray:self.hotProductImgArray];
        }
        
        return cell;
    }else if (indexPath.section == 2) {
        
        SuggestProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestProductCell" forIndexPath:indexPath];
        
        /* 设置 */
        if (self.clothesDataArray.count > 0) {
            
            cell.array = self.clothesDataArray;
        }
        
        return cell;
    }else if (indexPath.section == 3) {
        
        ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListCell" forIndexPath:indexPath];
        
        if (self.recommendProduct.count > 0) {
            
            cell.model = self.recommendProduct[indexPath.row];
        }
        
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UIView *uiview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 44)];
        
        uiview.backgroundColor = [UIColor redColor];
        
        return uiview;
    }else {
        
        return [[UIView alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 240;
    }else if (indexPath.section == 1) {
        
        return 146;
    }else if (indexPath.section == 2) {
        
        return 243;
    }else if (indexPath.section == 3) {
        
        return 241;
    }
    
    return 44;
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
