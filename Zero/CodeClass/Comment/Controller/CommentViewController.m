//
//  CommentViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "CommentViewController.h"

#import "CommentGoodsModel.h"
#import "CommetDetailModel.h"
#import "CommentModel.h"

#import "CommentCell.h"

/* 引入下拉刷新 */
#import <MJRefresh/MJRefresh.h>

@interface CommentViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

/* 商品信息 */
@property (nonatomic, strong) NSMutableArray *goodDataArray;

/* 评论信息 */
@property (nonatomic, strong) NSMutableArray *commentDataArray;

/* 所有评论 */
@property (nonatomic, strong) NSMutableArray *allCommentDataArray;

/* 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *paramDic;

/* 请求评论的页数 */
@property (nonatomic, assign) NSInteger page;

/* 上提 下拉刷新标记 */
@property (nonatomic, assign) BOOL upOrDownFlag;

@end

@implementation CommentViewController

#pragma mark --- 懒加载部分
- (NSMutableArray *)goodDataArray {
    
    if (_goodDataArray == nil) {
        
        self.goodDataArray = [NSMutableArray array];
    }
    
    return _goodDataArray;
}

- (NSMutableArray *)commentDataArray {
    
    if (_commentDataArray == nil) {
        
        self.commentDataArray = [NSMutableArray array];
    }
    
    return _commentDataArray;
}

- (NSMutableArray *)allCommentDataArray {
    
    if (_allCommentDataArray == nil) {
        
        self.allCommentDataArray = [NSMutableArray array];
    }
    
    return _allCommentDataArray;
}

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部评论";
    
    /* 设置tableView */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    
    /* cell高度自适应 */
    self.tableView.estimatedRowHeight = 134;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    /* 请求数据 */
    self.page = 1;
    self.upOrDownFlag = YES;
    self.paramDic = [@{@"action":@"comment",@"goods_id":self.goods_id,@"page":@(self.page)} mutableCopy];
    [self requestData];
    
    /* 添加下拉刷新 */
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        /* 重新请求数据 */
        self.page = 1;
        [self.paramDic setValue:@(self.page) forKey:@"page"];
        self.upOrDownFlag = YES;
        [self requestData];
    }];
    
    /* 添加上提加载 */
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
       /* 重新请求数据 */
        self.page = self.page + 1;
        [self.paramDic setValue:@(self.page) forKey:@"page"];
        self.upOrDownFlag = NO;
        [self requestData];
    }];
}

#pragma mark --- 请求数据
- (void)requestData {
    
    /* 判断是否清除数据源 */
    if (self.upOrDownFlag == YES) {
        
        [self.commentDataArray removeAllObjects];
    }
    
    [self.goodDataArray removeAllObjects];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {

        /* 评价商品信息 */
        NSDictionary *goodsDic = responseObject[@"goods"];
        CommentGoodsModel *goodsModel = [[CommentGoodsModel alloc] init];
        
        [goodsModel setValuesForKeysWithDictionary:goodsDic];
        [self.goodDataArray addObject:goodsModel];
        
        /* 品论总体信息 */
        NSDictionary *dic = responseObject;
        CommetDetailModel *detailModel = [[CommetDetailModel alloc] init];
        
        detailModel.currentPage = dic[@"currentPage"];
        detailModel.pageCount = dic[@"pageCount"];
        detailModel.commentCount = dic[@"commentCount"];
        
        [self.commentDataArray addObject:detailModel];
        
        /* 所有评论 */
        NSDictionary *allCommentArray = responseObject[@"commentResults"];
        for (NSDictionary *tmpDic in allCommentArray) {
            
            CommentModel *tmpModel = [[CommentModel alloc] init];
            
            [tmpModel setValuesForKeysWithDictionary:tmpDic];
            
            [self.allCommentDataArray addObject:tmpModel];
        }
        
        /* 主线程刷新数据 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 停止加载动画 */
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allCommentDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    
    /* 配置cell */
    if (self.allCommentDataArray.count > 0) {
        
        cell.model = self.allCommentDataArray[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return -1;
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









































