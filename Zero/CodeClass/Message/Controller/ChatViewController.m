//
//  ChatViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/9/1.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ChatViewController.h"

/* 引入聊天界面cell */
#import "ChatFromCell.h"
#import "ChatToCell.h"

/* 引入环信SDK */
#import <EMSDK.h>

/* 聊天界面 */
@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource,EMChatManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UITextField *messageEditTextField;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property (nonatomic, strong) EMConversation *conversation;

@property (nonatomic, strong) NSMutableArray *messageDataArray;

@property (nonatomic, assign) double keyboardHeight;

@end

static int firstFlag = 0;

@implementation ChatViewController

- (NSMutableArray *)messageDataArray {
    
    if (_messageDataArray == nil) {
        
        self.messageDataArray = [NSMutableArray array];
    }
    
    return _messageDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 设置titile */
    self.title = self.userAccount;
    
    /* 设置tableView */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    /* 设置自适应cell高度 */
//    self.tableView.estimatedRowHeight = 73;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    /* 取消自动适配 */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /* 设置cell不能被选择 */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    /* 给tableView添加轻拍手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableViewAction:)];
    
    [self.tableView addGestureRecognizer:tap];
    
    /* 注册聊天界面两种cell */
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatFromCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ChatFromCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChatToCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ChatToCell"];
    
    /* 创建获取会话:使用对话的账号创建会话对象 */
    self.conversation = [[EMClient sharedClient].chatManager getConversation:self.userAccount type:EMConversationTypeChat createIfNotExist:YES];
    
    /* 获取消息记录 */
    [self getHistoryMessage];
    
    /* 注册聊天消息回调 */
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    /* 监听键盘弹出通知 */
    self.keyboardHeight = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark --- talbeView轻拍手势
- (void)tapTableViewAction:(UIGestureRecognizer *)recognizer {
    
    [self.view endEditing:YES];
}

#pragma mark --- 获取消息记录
- (void)getHistoryMessage {
    
    /* 获取消息记录 */
    self.messageDataArray = [[self.conversation loadMoreMessagesWithType:EMMessageBodyTypeText before:-1 limit:-1 from:nil direction:EMMessageSearchDirectionUp] mutableCopy];
    
    /* 刷新界面 */
    [self.tableView reloadData];
    
    /* 滚动tableview */
    if (self.messageDataArray.count > 0) {
        
        /* 进行安全判断，如果存在聊天数据的话再进行tableView的滚动：在设备上不能够滚动到最底部，但是弹出
         * 键盘时可以滚动到最底部
         */
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageDataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        [self.tableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    }
}

#pragma mark --- 键盘弹出时通知方法
- (void)keyboardWillShow:(NSNotification *)notify {
    
    /* 键盘弹出式，改变整个view的位置 */
    /* 获取键盘高度 */
    NSDictionary *userInfo = [notify userInfo];
    
    /* 获取键盘区域 */
    CGRect endKeyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    /* 获取键盘高度 */
    self.keyboardHeight = endKeyboardRect.size.height;
    
    firstFlag = firstFlag + 1;
    /* 只有第一次走该方法的时候才改变视图的位置 */
    if (firstFlag != 0) {
        
        /* 移动view */
        self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        /* 移动view */
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - self.keyboardHeight, self.view.frame.size.width, self.view.frame.size.height);
        
        /* 滚动tableview */
        if (self.messageDataArray.count > 0) {
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageDataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        return ;
    }

    /* 移动view */
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - self.keyboardHeight, self.view.frame.size.width, self.view.frame.size.height);
    
    /* 滚动tableview */
    if (self.messageDataArray.count > 0) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageDataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notify {
    
    /* 调整view的frame */
    /* 移动view */
    self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    /* 滚动tableview */
    if (self.messageDataArray.count > 0) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageDataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    /* 移除聊天消息回调 */
    [[EMClient sharedClient].chatManager removeDelegate:self];
    
    /* 移除键盘监听通知 */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)sendMessageAction:(UIButton *)sender {
    
    /* 发送消息 */
    if (self.messageEditTextField.text.length == 0) {
        
        [self showAlertWithTitle:@"消息" message:@"发送消息不能为空"];
    }else {
        
   /* 发送消息 */
        /* 构造消息 */
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:self.messageEditTextField.text];
        
        /* 消息发送方 */
        NSString *from = [[EMClient sharedClient] currentUsername];
        
        /* 生成message */
        EMMessage *messge = [[EMMessage alloc] initWithConversationID:self.conversation.conversationId from:from to:self.userAccount body:body ext:nil];
        /* 设置为单聊消息 */
        messge.chatType = EMChatTypeChat;
        
        /* 发送消息 */
        [[EMClient sharedClient].chatManager asyncSendMessage:messge progress:^(int progress) {
            
            
        } completion:^(EMMessage *message, EMError *error) {
            
            /* 完成消息发送之后 */
            if (error == nil) {
            
                /* 清空输入框 */
                self.messageEditTextField.text = @"";
                
                /* 更新界面显示 */
                [self updateMessageAndDisplay:message];
            }
        }];
    }
}

#pragma mark --- 接收消息
/*
 * 接收到一条及以上非CMD消息
 * 登录之后马上接收发送的消息，登录之后服务器会推送消息，不及时接收就会接收不到
 *
 */
- (void)didReceiveMessages:(NSArray *)aMessages {
    
    for (EMMessage *message in aMessages) {
        
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
                
                /* 文字消息 */
            {
                
                //EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                [self updateMessageAndDisplay:message];

            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark --- 新发送、接收的消息添加到数据源并显示
- (void)updateMessageAndDisplay:(EMMessage *)message {
    
    [self.messageDataArray addObject:message];
    
    /* 刷新界面 */
    [self.tableView reloadData];
    
    /* 滚动界面到最下面 */
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageDataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    /* 返回消息的个数 */
    return self.messageDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.messageDataArray.count > 0) {
        
        EMMessage *message = self.messageDataArray[indexPath.row];
        
        if ([message.from isEqualToString:[[EMClient sharedClient] currentUsername]]) {
            
            /* 如果是自己发送的消息 */
            ChatFromCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatFromCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            EMTextMessageBody *textMessage = (EMTextMessageBody *)message.body;
            cell.messageLabel.text = textMessage.text;
            
            return cell;
        }else {
            
            /* 如果是自己发送的消息 */
            ChatToCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatToCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            EMTextMessageBody *textMessage = (EMTextMessageBody *)message.body;
            cell.messageLabel.text = textMessage.text;
            
            return cell;
        }
    }
    
    /* 默认返回 */
    /* 根据消息类型，选择使用不同的cell */
    ChatFromCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatFromCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 73;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 隐藏键盘 */
    [self.view endEditing:YES];
}

@end







































































