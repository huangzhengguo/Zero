//
//  CollectionViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/31.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CollectionViewController.h"

#import "ProductManager.h"

#import "ProductDetailModel.h"

#import "UserCollectionCell.h"

#import "ProductDetailViewController.h"

@interface CollectionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CollectionViewController

#pragma mark --- 懒加载部分
- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        
        self.dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCollectionCell" bundle:nil] forCellReuseIdentifier:@"UserCollectionCell"];

}

- (void)viewWillAppear:(BOOL)animated {
    
    /* 获取用户数据 */
    UserInfoModel *userInfoModel = [[UserInfoManager shareUserInfoManager] getUserInfo];
    
    if (userInfoModel) {
        
        /* 获取收藏数据 */
        ProductManager *manager = [[ProductManager alloc] init];
        
        self.dataArray = [[manager queryAllProductsWithUid:userInfoModel.uid] mutableCopy];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCollectionCell" forIndexPath:indexPath
                                ];
    
    if (self.dataArray.count > 0) {
        
        ProductDetailModel *detailModel = self.dataArray[indexPath.row];
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[detailModel.thumbnail_m stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        
        cell.nameLabel.text = detailModel.goods_name;
        
        cell.titleLabel.text = detailModel.goods_title;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count > 0) {
        
        ProductDetailModel *detailModel = self.dataArray[indexPath.row];
        ProductDetailViewController *productDVC = [[ProductDetailViewController alloc] init];
        
        productDVC.goods_id = detailModel.goods_id;
        
        [self.navigationController pushViewController:productDVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
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






































