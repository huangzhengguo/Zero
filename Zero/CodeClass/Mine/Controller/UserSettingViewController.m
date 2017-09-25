//
//  UserSettingViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "UserSettingViewController.h"

#import "NewRootViewController.h"

#import "UserInfoManager.h"

#import "TabBarViewController.h"

@interface UserSettingViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *dataListDic;

@property (strong, nonatomic) UserInfoModel *userInf;

/* 缓存文件大小 */
@property (nonatomic, assign) float cacheSize;

/* 文件管理器 */
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation UserSettingViewController

- (NSMutableDictionary *)dataListDic {
    
    if (_dataListDic == nil) {
        
        self.dataListDic = [NSMutableDictionary dictionary];
    }
    
    return _dataListDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    /* 获取保存的用户数据 */
    self.userInf = [[UserInfoManager shareUserInfoManager] getUserInfo];
     
    /* 初始化列表数据 */
    self.dataListDic = [@{@"0":@[@"个人资料",@"支付管理",@"新消息通知",@"呼叫客服",@"清除本地缓存"],@"1":@[@"关注微信公众号",@"关于"],@"2":@[@"注销"]} mutableCopy];
    
    /* 计算缓存文件大小 */
    self.fileManager = [NSFileManager defaultManager];
    self.cacheSize = [self calculateSizeOfCache:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]];
    
    [self.tableView reloadData];
}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = self.dataListDic[[NSString stringWithFormat:@"%ld",(long)section]];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    NSArray *array = self.dataListDic[[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    
    if (indexPath.section == 0 && indexPath.row == 4) {
        
        /* 显示缓存文件大小 */
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%.02fM)",array[indexPath.row],self.cacheSize];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }else {
        
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }

    
    if (indexPath.section == 2) {
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 4) {
            
            /* 清除缓存:删除cache文件中的数据 */
            /* 1.获取cache文件路径 */
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            
            /* 清除缓存 */
            [self clearCacheFileAtPath:cachePath];
        }
         
    }else if (indexPath.section == 1) {
        
        

    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            /* 直接清除 */
            [[UserInfoManager shareUserInfoManager] clearUserInfo];
            
            /* 发送退出登录的通知,然后返回上一界面，在我的界面进行界面的跳转 */
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
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
































