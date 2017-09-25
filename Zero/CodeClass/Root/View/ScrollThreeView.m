//
//  ScrollThreeView.m
//  Zero
//
//  Created by 黄郑果 on 16/8/22.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ScrollThreeView.h"

@interface ScrollThreeView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation ScrollThreeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ScrollThreeView" owner:self options:nil] lastObject];
        
        self.frame = frame;
        
        /* 设置tableView */
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        /* 添加定时器，实现滚动 */
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        self.currentIndex = 0;
    }
    
    return self;
}

- (IBAction)lifeAction:(UIButton *)sender {
    
    if (self.btnBlock) {
        
        self.btnBlock(sender.tag-1000);
    }
}

- (IBAction)shareAction:(UIButton *)sender {
    
    if (self.btnBlock) {
        
        self.btnBlock(sender.tag-1000);
    }
}

- (IBAction)readAction:(UIButton *)sender {
    
    if (self.btnBlock) {
        
        self.btnBlock(sender.tag-1000);
    }
}

#pragma mark --- tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrollViewCell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scrollViewCell"];
    }
    
    cell.backgroundColor = RANDOMCOLOR;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 36;
}

#pragma mark --- 定时器方法
-(void)timerAction{
    
    //if (self.dataArr.count != 0) {
        //如果公告滚动到最后一个,就从第一个从新开始
        if (self.currentIndex == 9) {
            self.currentIndex = 0;
        }else{
            self.currentIndex += 3;
        }
        //刷新分区
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationTop)];
        
    //}
}

@end










































