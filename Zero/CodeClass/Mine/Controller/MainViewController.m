//
//  MainViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "MainViewController.h"

#import "LoginAndRegisterViewController.h"

#import "UserInfoManager.h"

#import "UserInfoModel.h"

/* 用户信息model */
#import "MyselfModel.h"

#import "UserSettingViewController.h"

/* 摇一摇界面 */
#import "ShakeViewController.h"

/* 收藏界面 */
#import "CollectionViewController.h"

/* 聊天登录界面 */
#import "HyphenateLoginViewController.h"

/* 个人资料界面 */
#import "MyInfoViewController.h"

#define HEADERVIEWHEIGHT (KHEIGHT * 7 / 24)

/* 头像宽高 */
#define USERHEADERVIEWWIDTH 80
#define USERHEADERVIEWHEIGHT 80

@interface MainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

/* 订单类型数组 */
@property (nonatomic, strong) NSArray *orderTypeArray;

/* 列表标题字典 */
@property (nonatomic, strong) NSDictionary *listDataDic;

@property (nonatomic, strong) UserInfoModel *userModel;

/* 请求用户数据参数 */
@property (nonatomic, strong) NSMutableDictionary *paramDic;

/* 登录用户数据 */
@property (nonatomic, strong) MyselfModel *myselfInfo;

/* 缓存文件大小 */
@property (nonatomic, assign) float cacheSize;

/* 文件管理器 */
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation MainViewController

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* 添加退出登录的观察者 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutJum:) name:@"logout" object:nil];
    
    /* 初始化 */
    self.orderTypeArray = @[@"全部订单",@"待发货",@"待收货",@"待评价"];
    //self.listDataDic = @{@"0":@[@"我的资料",@"我的余额",@"摇一摇",@"我的收藏"],@"1":@[@"零友圈",@"我的评论",@"邀请好友赢福利",@"游戏中心"],@"2":@[@"客服中心",@"发现更多"]};
    
    self.listDataDic = @{@"0":@[@"我的资料",@"我的余额",@"我的收藏"],@"1":@[@"清除缓存"],@"2":@[@"退出登录"]};
    
    /* 设置tableView */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    /* 获取用户信息 */
    self.userModel = [[UserInfoManager shareUserInfoManager] getUserInfo];
    
    /* 创建表头 */
    [self createTableViewHeaderView];
    
    /* 请求数据:请求用户数据 */
    if (self.userModel.ticket && self.userModel.uid)
    {
        self.paramDic = [@{@"action":@"myself",@"ticket":self.userModel.ticket,@"uid":self.userModel.uid} mutableCopy];
        [self requestMyselfData];
        
    }
    
    /* 计算缓存文件大小 */
    self.fileManager = [NSFileManager defaultManager];
    self.cacheSize = [self calculateSizeOfCache:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.hidesBottomBarWhenPushed = NO;
}

- (void)logoutJum:(NSNotification *)notify {
    
    /* 界面跳转到首页 */
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
}

/* 创建表头 */
- (void)createTableViewHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, HEADERVIEWHEIGHT)];
    
    headerView.backgroundColor = [UIColor colorWithRed:30.0 / 255 green:144.0 / 255.0 blue:1.0 alpha:1.0];
    
    /* 在右上角添加消息和设置按钮 */
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [settingBtn setFrame:CGRectMake(KWIDTH - 10 - 50, 0, 50, 50)];
    [settingBtn setBackgroundColor:[UIColor whiteColor]];
    [settingBtn setTitle:@"" forState:UIControlStateNormal];
    [settingBtn setBackgroundColor:[UIColor clearColor]];
    [settingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setTag:1000];
    
    [headerView addSubview:settingBtn];
    
    UIButton *messgeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [messgeBtn setFrame:CGRectMake(KWIDTH - 10 - 50 - 30 - 50, 0, 50, 50)];
    [messgeBtn setBackgroundColor:[UIColor grayColor]];
    [messgeBtn setTitle:@"" forState:UIControlStateNormal];
    [messgeBtn setBackgroundColor:[UIColor clearColor]];
    [messgeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [messgeBtn setTag:1001];
    
    [headerView addSubview:messgeBtn];
    
    /* 添加头像 */
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, HEADERVIEWHEIGHT / 3, USERHEADERVIEWWIDTH, USERHEADERVIEWHEIGHT)];
    
    headerImgView.layer.cornerRadius = USERHEADERVIEWWIDTH / 2;
    headerImgView.layer.masksToBounds = YES;
    
    /* 设置头像 */
    [headerImgView sd_setImageWithURL:[NSURL URLWithString:[self.userModel.headimgurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    
    /* 给头像添加轻拍手势 */
    headerImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImgViewTapAction:)];
    [headerImgView addGestureRecognizer:tapRecognizer];
    
    [headerView addSubview:headerImgView];
    
    /* 添加姓名label */
    UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40 + USERHEADERVIEWWIDTH, HEADERVIEWHEIGHT / 3, 200, 30)];
    
    nicknameLabel.text = self.userModel.nickname;
    nicknameLabel.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:nicknameLabel];
    
    /* 添加ID label */
    UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(40 + USERHEADERVIEWWIDTH, HEADERVIEWHEIGHT / 3 + 30, 200, 30)];
    
    idLabel.text = [NSString stringWithFormat:@"ID:%@",self.userModel.name];
    idLabel.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:idLabel];
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark --- 头像轻拍事件
- (void)headerImgViewTapAction:(UITapGestureRecognizer *)tap {
    
    /* 跳转到个人资料界面 */
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc] init];
    
    myInfoVC.hidesBottomBarWhenPushed = YES;
    
    /* 传递个人资料 */
    myInfoVC.myselfInfo = self.myselfInfo;
    
    [self.navigationController pushViewController:myInfoVC animated:YES];
}

#pragma mark --- 请求用户数据
- (void)requestMyselfData {
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {

        NSDictionary *dic = responseObject[@"user"];
        
        self.myselfInfo = [[MyselfModel alloc] init];
        
        [self.myselfInfo setValuesForKeysWithDictionary:dic];
        
        /* 刷新数据 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.listDataDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key = self.listDataDic.allKeys[section];
    NSArray *sectionArray = [self.listDataDic objectForKey:key];
    
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    /* 设置cell样式 */
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSArray *sectionDataArray = [self.listDataDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    
    NSString *str = sectionDataArray[indexPath.row];
    if (indexPath.section == 0) {
        
        if (self.myselfInfo && indexPath.row == 0 && self.myselfInfo.user_money != nil) {
            
            
        }
        
        if (self.myselfInfo && indexPath.row == 1 && self.myselfInfo.user_jifen != nil) {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            str = [NSString stringWithFormat:@"%@(￥%@)",str,self.myselfInfo.user_money];
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 1)
        {
            
        }else if (indexPath.row == 0) {
            
           cell.accessoryType = UITableViewCellAccessoryNone;
            
            /* 显示缓存文件大小 */
           str = [NSString stringWithFormat:@"清理缓存(%.02fM)",self.cacheSize];
        }
    }else if (indexPath.section == 2) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    cell.textLabel.text = str;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
//        /* 创建订单类型列表 */
//        UIView *orderTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 100)];
//        
//        for (int i=0;i<self.orderTypeArray.count;i++) {
//            
//            UIButton *orderBtn = [[UIButton alloc] init];
//                
//            orderBtn.frame = CGRectMake(i * KWIDTH / self.orderTypeArray.count, 10, KWIDTH / self.orderTypeArray.count, 60);
//            /* 给按钮添加tag值 */
//            orderBtn.tag = 1000 + i;
//            
//            /* 给按钮添加点击事件 */
//            [orderBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//            
//            /* 设置订单按钮类型文本 */
//            [orderBtn setTitle:self.orderTypeArray[i] forState:UIControlStateNormal];
//            [orderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            
//            [orderTypeView addSubview:orderBtn];
//        }
//        
//        return orderTypeView;
    }
    
    UIView *defaultHeaderView = [[UIView alloc] init];
    
    defaultHeaderView.backgroundColor = [UIColor lightGrayColor];
    
    return defaultHeaderView;
}

- (void)btnClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    
    if (tag == 1000) {
        
        /* 处理设置按钮点击事件 */
        UserSettingViewController *userSettingVC = [[UserSettingViewController alloc] init];
        
        userSettingVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:userSettingVC animated:YES];
    }else if (tag == 1001) {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            /* 跳转到个人资料界面 */
            MyInfoViewController *myInfoVC = [[MyInfoViewController alloc] init];
            
            myInfoVC.hidesBottomBarWhenPushed = YES;
            
            /* 传递个人资料 */
            myInfoVC.myselfInfo = self.myselfInfo;
            
            [self.navigationController pushViewController:myInfoVC animated:YES];
        }else if (indexPath.row == 3) {
            
            /* 跳转到摇一摇界面 */
            ShakeViewController *shakeVC = [[ShakeViewController alloc] initWithNibName:@"ShakeViewController" bundle:[NSBundle mainBundle]];
            
            [self.navigationController pushViewController:shakeVC animated:YES];
        }else if (indexPath.row == 2) {
            
            CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
            
            [self.navigationController pushViewController:collectionVC animated:YES];
        }
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
            
            /* 弹出聊天登录界面 */
            HyphenateLoginViewController *hyphenateLoginVC = [[HyphenateLoginViewController alloc] init];
            
            hyphenateLoginVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:hyphenateLoginVC animated:YES];
        }else if (indexPath.row == 0) {
            
            /* 清理缓存 */
            /* 清除缓存:删除cache文件中的数据 */
            /* 1.获取cache文件路径 */
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            
            /* 清除缓存 */
            [self clearCacheFileAtPath:cachePath];
        }
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            /* 直接清除 */
            [[UserInfoManager shareUserInfoManager] clearUserInfo];
            
            /* 界面跳转到首页 */
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
            /* 发送退出登录的通知,然后返回上一界面，在我的界面进行界面的跳转 */
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
            
            //[self.navigationController popViewControllerAnimated:YES];
            
            /* 注销 操作 */
            //            [NetworkManager postRequestWithUrl:ZEROURL param:@{@"action":@"login_out",@"ticket":self.userInf.ticket,@"uid":self.userInf.uid} success:^(id responseObject) {
            //
            //                //if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"1"]) {
            //
            //                    /* 退出登录成功:清除用户信息，并且跳转界面到首页 */
            //
            //                    [[UserInfoManager shareUserInfoManager] clearUserInfo];
            //
            //                    /* 发送退出登录的通知,然后返回上一界面，在我的界面进行界面的跳转 */
            //                    [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
            //
            //                    [self.navigationController popViewControllerAnimated:YES];
            //                //}
            //                
            //            } fail:^(NSError *error) {
            //                
            //                
            //            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0;
    }
    
    return 10;
}

#pragma mark --- 计算文件大小
- (long long)fileOfSizeAtPath:(NSString *)path {
    
    /* 1.获取文件管理器 */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    /* 2.判断传入的文件是否存在 */
    if ([fileManager fileExistsAtPath:path]) {
        
        /* 3.如果文件存在则返回文件大小 */
        return [[fileManager attributesOfItemAtPath:path error:nil] fileSize];
    }
    
    /* 4.其他情况返回0 */
    return 0;
}

#pragma mark --- 计算缓存目录大小
- (float)calculateSizeOfCache:(NSString *)path{
    
    /* 1.获取文件管理器 */
    NSFileManager *manager = [NSFileManager defaultManager];
    
    /* 2.获取文件遍历器 */
    NSEnumerator *fileEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
    
    /* 3.遍历文件计算缓存大小 */
    NSString *fileName;
    float fileSize = 0.0;
    while ((fileName = [fileEnumerator nextObject]) != nil) {
        
        /* 拼接文件的绝对路径 */
        NSString *fileAbsulatePath = [path stringByAppendingPathComponent:fileName];
        
        /* 累加文件大小:递归调用计算文件大小 */
        fileSize += [self fileOfSizeAtPath:fileAbsulatePath];
    }
    
    return fileSize / 1024.0 / 1024.0;
}

#pragma mark --- 清除缓存
- (void)clearCacheFileAtPath:(NSString *)path {
    
    /* 1.获取文件管理器 */
    NSFileManager *manager = [NSFileManager defaultManager];
    
    /* 2.获取文件遍历器 */
    NSEnumerator *fileEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
    
    /* 3.遍历文件计算缓存大小 */
    NSString *fileName;
    
    while ((fileName = [fileEnumerator nextObject]) != nil) {
        
        /* 拼接文件的绝对路径 */
        NSString *fileAbsulatePath = [path stringByAppendingPathComponent:fileName];
        
        /* 累加文件大小:递归调用计算文件大小 */
        [manager removeItemAtPath:fileAbsulatePath error:nil];
    }
    
    /* 设置缓存文件大小并刷新显示 */
    self.cacheSize = 0;
    
    [self.tableView reloadData];
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



































