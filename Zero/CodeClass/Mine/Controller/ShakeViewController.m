//
//  ShakeViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/29.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ShakeViewController.h"

#import "ShakeModel.h"

@interface ShakeViewController ()

@property (nonatomic, strong) NSMutableDictionary *paramDic;

/* 进入摇一摇界面获取用户摇一摇信息 */
@property (nonatomic, strong) ShakeModel *userShakeInfo;

/* 摇一摇结果码 */
@property (nonatomic, strong) NSString *resultCode;

/* 摇一摇中奖信息 */
@property (nonatomic, strong) NSString *resultMessage;

@property (nonatomic, strong) UserInfoModel *userInfo;

@end

@implementation ShakeViewController

#pragma mark --- 懒加载部分
- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 允许摇一摇功能 */
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    
    /* 并让当前控制器成为第一响应者 */
    [self becomeFirstResponder];
    
    /* 获取用户信息 */
    self.userInfo = [[UserInfoManager shareUserInfoManager] getUserInfo];
    
    if (self.userInfo) {
        
        /* 获取用户摇一摇的信息 */
        self.paramDic = [@{@"action":@"shake",@"ticket":self.userInfo.ticket,@"uid":self.userInfo.uid} mutableCopy];
        
        /* 请求用户摇一摇信息 */
        [self queryUserShakeInfo];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    /* 离开摇一摇界面后，禁止摇一摇 */
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = NO;
}

- (void)queryUserShakeInfo {
    
    /* 设置参数 */
    self.paramDic = [@{@"action":@"shake",@"ticket":self.userInfo.ticket,@"uid":self.userInfo.uid} mutableCopy];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        
        NSDictionary *dic = responseObject[@"data"];
        
        if (self.userShakeInfo == nil) {
            
            self.userShakeInfo = [[ShakeModel alloc] init];
        }
        
        [self.userShakeInfo setValuesForKeysWithDictionary:dic];
        
        /* 主线程添加您今天还可以摇几次的信息 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* 创建label */
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH / 2 - 100, KHEIGHT - 60 - 30, 200, 30)];
            
            label.textAlignment = NSTextAlignmentCenter;
            if (self.userShakeInfo && self.userShakeInfo.left_num) {
                
                label.text = [NSString stringWithFormat:@"您今天还可以摇%@次",self.userShakeInfo.left_num];
            }else {
                
                label.text = @"您今天还可以摇0次";
            }
            
            [self.view addSubview:label];
            [self.view bringSubviewToFront:label];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- 摇一摇请求数据
- (void)requestShakeData {
    
    /* 设置摇一摇参数 */
    [self.paramDic setValue:@"shakeapi" forKey:@"action"];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        
        self.resultCode = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        self.resultMessage = [NSString stringWithFormat:@"%@",responseObject[@"msg"]];
        [self.userShakeInfo setValuesForKeysWithDictionary:dic];
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- 摇一摇功能实现
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {

    /* 开始请求数据 */
    [self requestShakeData];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    /* 创建view */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(KWIDTH / 2 - 150, KHEIGHT / 2 - 150, 300, 300)];
    
    view.tag = 1000;
    view.backgroundColor = [UIColor redColor];
    
    /* 创建关闭按钮 */
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(300 - 50, 0, 50, 50)];
    
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:closeBtn];
    
    /* 创建标题信息 */
    UILabel *titleLable =[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 50)];
    titleLable.textColor = [UIColor yellowColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    /* 根据获取到的信息创建弹出界面 */
    if ([self.resultCode isEqualToString:@"1"]) {

        titleLable.text = self.userShakeInfo.iswin_txt;
        [view addSubview:titleLable];
        
    }else if ([self.resultCode isEqualToString:@"1100101"]) {
        
        titleLable.text = @"对不起";
        [view addSubview:titleLable];
        
        /* 创建中奖信息提示 */
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 300, 50)];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = self.resultMessage;
        
        [view addSubview:messageLabel];
        
    }
    
    /* 在弹出框底部显示剩余次数 */
    UILabel *leftNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300 - 50, 300, 50)];
    
    leftNumLabel.textColor = [UIColor yellowColor];
    leftNumLabel.textAlignment = NSTextAlignmentCenter;
    leftNumLabel.text = self.userShakeInfo.left_txt;
    [view addSubview:leftNumLabel];
    
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
}

#pragma mark --- 关闭中奖信息提示框
- (void)closeViewAction:(UIButton *)sender {
    
    [[self.view viewWithTag:1000] removeFromSuperview];
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





































