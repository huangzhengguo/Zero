//
//  ColorfulConsultViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ColorfulConsultViewController.h"

#import "ColorBigPatternCell.h"
#import "ColorSmallPatternCell.h"

#import "ColorArticleModel.h"

#import "ArticleViewController.h"

@interface ColorfulConsultViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *articleDataArray;

@property (strong, nonatomic) NSMutableDictionary *paramDic;

@end

@implementation ColorfulConsultViewController

#pragma mark --- 懒加载部分
- (NSMutableArray *)articleDataArray {
    
    if (_articleDataArray == nil) {
        
        self.articleDataArray = [NSMutableArray array];
    }
    
    return _articleDataArray;
}

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ColorBigPatternCell" bundle:nil] forCellReuseIdentifier:@"ColorBigPatternCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ColorSmallPatternCell" bundle:nil] forCellReuseIdentifier:@"ColorSmallPatternCell"];
    
    /* 创建表头 */
    [self createHeaderView];
    
    self.paramDic = [@{@"action":@"getartlist",@"class_id":self.class_id} mutableCopy];
    
    /* 请求数据 */
    [self requestData];
}

- (void)createHeaderView {
    
    NSArray *titleArray = @[@"生活百科",@"快乐分享",@"美文阅读"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 50)];
    
    /* 在view上面添加button */
    for (int i=0;i<titleArray.count;i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i == 0) {
            
            [btn setFrame:CGRectMake(20, 0, (KWIDTH-120) / 3, 50)];
        }else {
            
            [btn setFrame:CGRectMake(i * (KWIDTH-120) / 3 + i * 40 + 20, 0, (KWIDTH-120) / 3, 50)];
        }
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        /* 添加事件 */
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:1000 + i];
        
        /* 添加到view上面 */
        [view addSubview:btn];
    }
    
    view.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = view;
}

- (void)btnClickAction:(UIButton *)sender {
    
    NSInteger index = sender.tag - 1000;
    if (index == 0) {
        
        /* 请求生活百科数据 */
        [self.paramDic setValue:@"102" forKey:@"class_id"];
        
    }else if (index == 1) {
        
        /* 请求快乐分享数据 */
        [self.paramDic setValue:@"103" forKey:@"class_id"];
        
    }else if (index == 2) {
        
        /* 请求美文阅读数据 */
        [self.paramDic setValue:@"101" forKey:@"class_id"];
        
    }
    
    [self requestData];
}

#pragma mark --- 请求数据
- (void)requestData {
    
    [self.articleDataArray removeAllObjects];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSArray *array = responseObject[@"pagedData"];
        for (NSDictionary *dic in array) {
            
            ColorArticleModel *model = [[ColorArticleModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.articleDataArray addObject:model];
        }
        
        /* 主线程刷新主界面 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.articleDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.articleDataArray.count > 0) {
        
        ColorArticleModel *model = self.articleDataArray[indexPath.row];
        
        if ([model.pattern isEqualToString:@"2"]) {
            
            /* 使用大的cell */
            ColorBigPatternCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorBigPatternCell" forIndexPath:indexPath];
            
            cell.model = self.articleDataArray[indexPath.row];
            
            return cell;
        }else {
            
            /* 使用小的界面 */
            ColorSmallPatternCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorSmallPatternCell" forIndexPath:indexPath];
            
            cell.model = self.articleDataArray[indexPath.row];

            return cell;
        }
    }
    
    /* 默认小的界面 */
    ColorSmallPatternCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorSmallPatternCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.articleDataArray.count > 0) {
        
        ColorArticleModel *model = self.articleDataArray[indexPath.row];
        
        /* 跳转到详情界面 */
        ArticleViewController *articleVC = [[ArticleViewController alloc] init];
        
        articleVC.class_id = model.class_id;
        articleVC.article_id = model.article_id;
        
        [self.navigationController pushViewController:articleVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.articleDataArray.count > 0) {
        
        ColorArticleModel *model = self.articleDataArray[indexPath.row];
        if ([model.pattern isEqualToString:@"2"]) {
        
            return 132;
        }else {
            
            //ColorSmallPatternCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ColorSmallPatternCell" owner:nil options:nil] firstObject];
            
            //ColorArticleModel *model = self.articleDataArray[indexPath.row];
            
            //[cell autoAdjustLableHeight:model];
            
            //CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
            
            //NSLog(@"评论区域高度:%f",size.height);
            
            return 95;
        }
    }
    
    return 100;
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





























































