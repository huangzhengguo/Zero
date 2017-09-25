//
//  RootArticleCell.m
//  Zero
//
//  Created by 黄郑果 on 16/8/25.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "RootArticleCell.h"
#import "ArticleCell.h"

@interface RootArticleCell()

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation RootArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.currentIndex = 0;
    
    /* 添加定时器 */
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ArticleCell" bundle:nil] forCellReuseIdentifier:@"ArticleCell"];
    
    /* 设置button边框 */
    self.lifeButton.layer.borderWidth = 1;
    self.lifeButton.layer.borderColor = [UIColor orangeColor].CGColor;
    
    self.shareButton.layer.borderWidth = 1;
    self.shareButton.layer.borderColor = [UIColor orangeColor].CGColor;
    
    self.readButton.layer.borderWidth = 1;
    self.readButton.layer.borderColor = [UIColor orangeColor].CGColor;
}

#pragma mark --- 定时器方法
-(void)timerAction{
    
    //if (self.rowCount != 0) {
    //如果公告滚动到最后一个,就从第一个从新开始
    if (self.currentIndex == self.articleDataArray.count / 3 - 1) {
        self.currentIndex = 0;
    }else{
        self.currentIndex += 1;
    }
    //刷新分区
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationTop)];
    
    
    //}
}

- (IBAction)lifeClick:(UIButton *)sender {
    
    if (self.clickBlock) {
        
        self.clickBlock(sender.tag - 1000);
    }
}

- (IBAction)shareClick:(UIButton *)sender {
    
    if (self.clickBlock) {
        
        self.clickBlock(sender.tag - 1000);
    }
}

- (IBAction)readClick:(UIButton *)sender {
    
    if (self.clickBlock) {
        
        self.clickBlock(sender.tag - 1000);
    }
}

#pragma mark --- 重写
//-(void)setArticleDataArray:(NSArray *)articleDataArray {
//    
//    /* 配置cell，需要把这个值传递到cell进行复制 */
//}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.articleDataArray.count > 0) {
        
        if (self.articleDataArray.count % 3 == 0) {
            
            return self.articleDataArray.count / 3;
        }
        return self.articleDataArray.count / 3 + 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell" forIndexPath:indexPath];
    
    /* 实现block */
    cell.btnClickBlock = ^(NSString *article_id,NSString *class_id) {
        
        if (self.articleClickBlock) {
            
            /* 传递文章信息 */
            self.articleClickBlock(article_id,class_id);
        }
    };
    
    if (self.articleDataArray.count > 0) {
        
        /* 取三个数据组成一个数组然后传递到cell中:把下标对应的值传递过去 */
//        NSArray *tmpArray = @[self.articleDataArray[indexPath.row * 3 + 1],self.articleDataArray[indexPath.row * 3 + 2],self.articleDataArray[indexPath.row * 3 + 3]];
        NSArray *tmpArray = @[self.articleDataArray[self.currentIndex * 3],self.articleDataArray[self.currentIndex * 3 + 1],self.articleDataArray[self.currentIndex * 3 + 2]];
        
        cell.articleDataArray = tmpArray;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return BTNAREAHEIGHT;
}

@end








































