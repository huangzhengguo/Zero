//
//  SubjectViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "SubjectViewController.h"

#import "NewSubjectCell.h"

#import "NewSubjectModel.h"
#import "NewSubjectGoodsModel.h"

#import "ProductDetailViewController.h"

#import "SubjectDetailListViewController.h"

@interface SubjectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSDictionary *paramDic;

/* 大图部分 */
@property (nonatomic, strong) NSMutableArray *bigImgArray;

/* 存放所有的小图片部分 */
@property (nonatomic, strong) NSMutableDictionary *allDataDic;

@end

@implementation SubjectViewController

#pragma mark --- 懒加载部分
- (NSMutableArray *)bigImgArray {
    
    if (_bigImgArray == nil) {
        
        self.bigImgArray = [NSMutableArray array];
    }
    
    return _bigImgArray;
}

- (NSMutableDictionary *)allDataDic {
    
    if (_allDataDic == nil) {
        
        self.allDataDic = [NSMutableDictionary dictionary];
    }
    
    return _allDataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 设置tableView */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    /* 注册系统cell */
    [self.tableView registerNib:[UINib nibWithNibName:@"NewSubjectCell" bundle:nil] forCellReuseIdentifier:@"NewSubjectCell"];
    
    self.paramDic = @{@"action":@"subject_new",@"page":@"1"};
    
    [self requestData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestData];
    }];
}

#pragma mark --- 请求数据
- (void)requestData {
    
    [self.bigImgArray removeAllObjects];
    [self.allDataDic removeAllObjects];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        //NewSubjectGoodsModel
        //NewSubjectModel
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            
            NewSubjectModel *newSubjectModel = [[NewSubjectModel alloc] init];
            
            [newSubjectModel setValuesForKeysWithDictionary:dic];
            
            [self.bigImgArray addObject:newSubjectModel];
            
            /* 创建临时数组，存放主体对应的商品，然后添加到字典中 */
            NSMutableArray *tmpGoodArray = [NSMutableArray array];
            for (NSDictionary *goodsDic in dic[@"subject_goods"]) {
                
                NewSubjectGoodsModel *newSubjectGoodsModel = [[NewSubjectGoodsModel alloc] init];
                
                [newSubjectGoodsModel setValuesForKeysWithDictionary:goodsDic];
                
                [tmpGoodArray addObject:newSubjectGoodsModel];
            }
            
            /* 遍历商品完毕后，添加到字典中:把商品对应为数组存放在字典中 */
            [self.allDataDic setObject:tmpGoodArray forKey:dic[@"id"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
    
}

#pragma mark --- tableView代理fangfa
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bigImgArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewSubjectCell"];
    
    /* 实现cell的block */
    cell.imgBtnBlock = ^(NSInteger index) {
        
        /* 实现界面跳转 */
        if (self.bigImgArray.count > 0 && self.allDataDic.count > 0) {
            
            NewSubjectModel *model = self.bigImgArray[indexPath.row];
            NSArray *array = self.allDataDic[model.subject_id];
            if (index == 4) {
                
                /* 跳转到对应主体页面 */
                SubjectDetailListViewController *subjectDetailListVC = [[SubjectDetailListViewController alloc] init];
                
                subjectDetailListVC.title = model.title;
                subjectDetailListVC.subject_id = model.subject_id;
                
                [self.navigationController pushViewController:subjectDetailListVC animated:YES];
                
            }else {
                
                /* 跳转到对应商品界面 */
                NewSubjectGoodsModel *goodsModel = array[index];
                
                ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
                
                productDetailVC.goods_id = goodsModel.goods_id;
                
                [self.navigationController pushViewController:productDetailVC animated:YES];
            }
        }
    };
    
    if (self.bigImgArray.count > 0 && self.allDataDic.count > 0) {
        
        NewSubjectModel *model = self.bigImgArray[indexPath.row];
        NSArray *array = self.allDataDic[model.subject_id];
        
        [cell setCellWithBigImgModel:model goodsArray:array];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 307;
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
