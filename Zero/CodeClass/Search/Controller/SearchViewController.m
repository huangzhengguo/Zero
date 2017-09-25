//
//  SearchViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/27.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "SearchViewController.h"

#import "CategoryDetailModel.h"

#import "CategoryDetailCell.h"

/* 科大讯飞语音识别 */
#import <iflyMSC/iflyMSC.h>

@interface SearchViewController () <UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,IFlyRecognizerViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

/* 搜索框 */
@property (nonatomic, strong) UISearchBar *searchBar;

/* 搜索请求参数 */
@property (nonatomic, strong) NSMutableDictionary *paramDic;

/* 搜索数据数据源 */
@property (nonatomic, strong) NSMutableArray *searchDataArray;

/* 声明语音搜索属性 */
@property (nonatomic, strong) IFlyRecognizerView *iFlyRecognizerView;

@end

@implementation SearchViewController

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (NSMutableArray *)searchDataArray {
    
    if (_searchDataArray == nil) {
        
        self.searchDataArray = [NSMutableArray array];
    }
    
    return _searchDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 设置collectionView */
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CategoryDetailCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryDetailCell"];
    
    /* 初始化请求参数 */
    self.paramDic = [@{@"action":@"search"} mutableCopy];
    
    /* 创建语音识别按钮 */
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    voiceButton.frame = CGRectMake(KWIDTH - 50, 10, 80, 40);
    [voiceButton setTitle:@"语音搜索" forState:UIControlStateNormal];
    [voiceButton setBackgroundColor:[UIColor clearColor]];
    [voiceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [voiceButton addTarget:self action:@selector(voiceSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:voiceButton];
    
    self.navigationItem.rightBarButtonItems = @[rightBarItem];
}

#pragma mark --- 语音搜索
//- (void)voiceSearchAction:(UIButton *)sender {
//    
//    /* 实现语音搜索，并把语音识别的结果填写到搜索框中 */
//    /* 1.创建语音听写对象 */
//    self.iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
//    
//    /* 设置语音识别代理对象 */
//    self.iFlySpeechRecognizer.delegate = self;
//    
//    /* 2.设置听写参数 */
//    /* 听写模式 */
//    [self.iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
//    /* 录音文件以及保存路径 */
//    [self.iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
//    
//    /* 3.启动识别服务 */
//    [self.iFlySpeechRecognizer startListening];
//}

- (void)voiceSearchAction:(UIButton *)sender {
    
    self.iFlyRecognizerView = [[IFlyRecognizerView alloc] initWithOrigin:CGPointMake(10, KHEIGHT / 2)];
    
    self.iFlyRecognizerView.delegate = self;
    
    [self.iFlyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    [self.iFlyRecognizerView setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [self.iFlyRecognizerView start];
}

#pragma mark --- 语音识别代理
/* 识别结果返回代理
 * 参数1：result 识别结果
 * 参数2：isLast 表示是否最后一次结果
 */

- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast {
    
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    NSMutableString *mutStr = [NSMutableString string];
    
    for (NSString *key in dic.allKeys) {
        
        [mutStr appendString:key];
    }
    
    NSData *data = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    mutStr = [@"" mutableCopy];
    
    if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"sn"]] isEqualToString:@"1"]) {
        
        NSArray *array = [resultDic objectForKey:@"ws"];
        for (NSDictionary *tmpDic in array) {
            
            NSDictionary *dic = tmpDic[@"cw"][0];
            [mutStr appendString:dic[@"w"]];
        }
        
        self.searchBar.text = [NSString stringWithFormat:@"%@",mutStr];
        
        /* 发起搜索 */
        [self searchProduct];
    }
}

/* 识别会话结束返回代理
 * 参数:errorCode 0表示正常结束，非0表示发生错误
 */
- (void)onError: (IFlySpeechError *) error {
    
    NSLog(@"%@%@%@",@(error.errorCode),@(error.errorType),error.errorDesc);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self createSearchBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.searchBar resignFirstResponder];
    [self.searchBar removeFromSuperview];
}

#pragma mark --- 创建搜索框
- (void)createSearchBar {
    
    CGRect searchFrame = CGRectMake(100, 0, KWIDTH - 200, 42);
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:searchFrame];
    self.searchBar.delegate = self;
    self.searchBar.text = @"";
    
    [self.navigationController.navigationBar addSubview:self.searchBar];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    /* 在这里请求搜索建议列表 */
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchProduct];
}

#pragma mark --- 搜索
- (void)searchProduct {
    
    /* 请求搜索数据 */
    NSString *searchKey = self.searchBar.text;
    
    /* 设置请求参数 */
    if ([self.paramDic.allKeys containsObject:@"key"]) {
        
        [self.paramDic setValue:searchKey forKey:@"key"];
    }else {
        
        [self.paramDic setObject:searchKey forKey:@"key"];
    }
    
    [self.searchBar resignFirstResponder];
    
    /* 请求数据 */
    [self requestData];
}

#pragma mark --- 数据请求
- (void)requestData {
    
    [self.searchDataArray removeAllObjects];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSArray *dataList = responseObject[@"list"];
        for (NSDictionary *dic in dataList) {
            
            CategoryDetailModel *model = [[CategoryDetailModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.searchDataArray addObject:model];
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
    
    return self.searchDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryDetailCell" forIndexPath:indexPath];
    
    if (self.searchDataArray.count > 0) {
        
        CategoryDetailModel *model = self.searchDataArray[indexPath.row];
        
        cell.model = model;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryDetailModel *model = self.searchDataArray[indexPath.row];
    
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    
    productDetailVC.goods_id = model.goods_id;
    
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

#pragma 设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KWIDTH-30) / 2, (KWIDTH-30) / 2);
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






































