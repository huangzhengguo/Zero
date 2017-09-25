//
//  HyphenateListViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/9/1.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "HyphenateListViewController.h"

/* 环信SDK */
#import <EMSDK.h>

/* 聊天界面 */
#import "ChatViewController.h"

@interface HyphenateListViewController ()<UITableViewDelegate, UITableViewDataSource,EMContactManagerDelegate,EMChatManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *friendListArray;

@end

@implementation HyphenateListViewController

- (NSMutableArray *)friendListArray {
    
    if (_friendListArray == nil) {
        
        self.friendListArray = [NSMutableArray array];
    }
    
    return _friendListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 设置title */
    self.title = @"好友列表";
    
    /* 设置tableview */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    /* 去掉tableView分割线 */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    /* 添加增加好友按钮 */
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriendAction:)];
    
    /* 设置注销按钮 */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction:)];
    
    /* 设置好友请求代理 */
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    /* 注册聊天消息回调:这里的代理需要在登录之后就设置，如果在登录之后一段时间还未接收消息，则之后无法接收到消息 */
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    /* 获取好友列表 */
    [self getFriendDataList];
}

#pragma mark --- 接收消息
/*
 * 接收到一条及以上非CMD消息
 */
- (void)didReceiveMessages:(NSArray *)aMessages {
    
    for (EMMessage *message in aMessages) {
        
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
                
                /* 文字消息 */
            {
                /* 接收的消息会存储到本地数据库中 */
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    /* 移除代理 */
    [[EMClient sharedClient].contactManager removeDelegate:self];
}

#pragma mark --- 注销登录
- (void)logoutAction:(UIBarButtonItem *)sender {
    
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (error == nil) {
        
        NSLog(@"退出登录成功");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/* 收到好友请求回调 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage {
    
    /* 处理好友请求 */
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"好友请求" message:[NSString stringWithFormat:@"%@想添加你为好友",aUsername] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *acceptAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       /* 同意添加 */
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (error == nil) {
            
            NSLog(@"添加成功");
            
            [self getFriendDataList];
            [self.tableView reloadData];
        }
    }];
    
    UIAlertAction *rejectAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       /* 拒绝添加 */
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:aUsername];
        if (error == nil) {
            
            NSLog(@"拒绝成功");
        }
    }];
    
    [alterController addAction:acceptAction];
    [alterController addAction:rejectAction];
    
    [self presentViewController:alterController animated:YES completion:nil];
}

/*
 * 用户A发送加用户B为好友的请求，用户B同意后，用户A会收到这个请求
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername {
    
     [self showAlertWithTitle:@"请求回复" message:[NSString stringWithFormat:@"%@已经同意你的好友请求",aUsername]];
    
    [self getFriendDataList];
    [self.tableView reloadData];
}

/* 拒绝回复 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername {
    
    [self showAlertWithTitle:@"请求回复" message:[NSString stringWithFormat:@"%@拒绝了你的好友请求",aUsername]];
}

- (void)addFriendAction:(UIBarButtonItem *)sender {
    
    /* 弹出提示框填写要添加的账号信息 */
    [self alertToAddFriend];
}

- (void)alertToAddFriend {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入要添加的好友账号" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *textField = alertController.textFields.firstObject;
        
        /* 发送好友请求 */
        EMError *error = [[EMClient sharedClient].contactManager addContact:textField.text message:@"我想加你为好友"];
        if (error == nil) {
            
            NSLog(@"添加成功");
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
 
    /* 添加取消按钮 */
    [alertController addAction:cancelAction];
    
    /* 添加确认按钮 */
    [alertController addAction:confirmAction];
    
    /* 弹出提示框 */
    [self presentViewController:alertController animated:YES completion:^{
        
        
    }];
}

#pragma mark --- 获取好友列表
- (void)getFriendDataList {
    
    EMError *error;
    NSArray *array = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    self.friendListArray = [array mutableCopy];
}

#pragma mark --- tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.friendListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    /* 设置cell样式 */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (self.friendListArray.count > 0) {
        
        cell.textLabel.text = self.friendListArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        /* 删除好友 */
        /* 发送好友删除请求 */
        EMError *error = [[EMClient sharedClient].contactManager deleteContact:self.friendListArray[indexPath.row]];
        if (error == nil) {
            
            /* 再从本地删除数据 */
            [self.friendListArray removeObjectAtIndex:indexPath.row];
            
            /* 最后删除界面 */
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            NSLog(@"删除成功");
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 弹出聊天界面 */
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    
    /* 跳转到聊天界面:传递好友账号到聊天界面 */
    NSString *userAccount = self.friendListArray[indexPath.row];
    
    chatVC.userAccount = userAccount;
    
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
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





































