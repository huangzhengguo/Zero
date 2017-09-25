//
//  SubjectDetailListViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "SubjectDetailListViewController.h"

#import "NewSubjectHeaderView.h"

#import "NewSubjectViewCell.h"

#import "SubjectGoodsDesModel.h"

#import "ProductDetailViewController.h"

@interface SubjectDetailListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableDictionary *paramDic;

@property (nonatomic, copy) NSString *bannerImg;

@property (nonatomic, strong) NSMutableArray *goodsDataArray;

@end

@implementation SubjectDetailListViewController

#pragma mark --- 懒加载部分
- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (NSMutableArray *)goodsDataArray {
    
    if (_goodsDataArray == nil) {
        
        self.goodsDataArray = [NSMutableArray array];
    }
    
    return _goodsDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewSubjectHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewSubjectHeaderView"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewSubjectViewCell" bundle:nil] forCellWithReuseIdentifier:@"NewSubjectViewCell"];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
    [self.collectionView setCollectionViewLayout:layout];
    
    self.paramDic = [@{@"action":@"getSubject",@"id":self.subject_id,@"page":@"1"} mutableCopy];
    
    [self requestData];
}

#pragma mark --- 请求数据
- (void)requestData {
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSDictionary *dic = responseObject;
        
        self.bannerImg = dic[@"subject"][@"banner"];
        
        NSArray *array = dic[@"goods"];
        for (NSDictionary *tmpDic in array) {
            
            SubjectGoodsDesModel *model = [[SubjectGoodsDesModel alloc] init];
            
            [model setValuesForKeysWithDictionary:tmpDic];
            
            [self.goodsDataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.goodsDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewSubjectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewSubjectViewCell" forIndexPath:indexPath];
    
    if (self.goodsDataArray.count > 0) {
        
        SubjectGoodsDesModel *model = self.goodsDataArray[indexPath.row];
        
        [cell setCellWithGoodsModel:model];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return CGSizeMake(KWIDTH, 120);
    }
    
    return CGSizeMake(KWIDTH, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KWIDTH - 20) / 2, KWIDTH);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        NewSubjectHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NewSubjectHeaderView" forIndexPath:indexPath];
        
        if (self.bannerImg != nil) {
            
            [headerView.headerImg sd_setImageWithURL:[NSURL URLWithString:[self.bannerImg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        }
        
        return headerView;
    }
    
    return [[UICollectionReusableView alloc] init];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 跳转到详情 */
    /* 跳转到对应商品界面 */
    SubjectGoodsDesModel *goodsModel = self.goodsDataArray[indexPath.row];
    
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    
    productDetailVC.goods_id = goodsModel.goods_id;
    
    [self.navigationController pushViewController:productDetailVC animated:YES];
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
































