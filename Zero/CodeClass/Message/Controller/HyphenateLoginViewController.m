//
//  HyphenateLoginViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/9/1.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "HyphenateLoginViewController.h"

/* 好友列表界面 */
#import "HyphenateListViewController.h"

#import <EMSDK.h>

@interface HyphenateLoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *accountTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwdTextField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HyphenateLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.accountTextField.text = @"123456789";
    //self.passwdTextField.text = @"123456";
    
    /* 设置scrollView内容视图大小:这里不好使，原因待查 */
    self.scrollView.contentSize = CGSizeMake(KWIDTH, KHEIGHT);
    
    /* 监听键盘弹出通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    /* 监听键盘回收通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /* 设置输入框代理 */
    self.accountTextField.delegate = self;
}

#pragma mark --- 输入框代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    /* 隐藏键盘 */
    [textField resignFirstResponder];
}

#pragma mark --- 键盘弹出时通知方法
- (void)keyboardWillShow:(NSNotification *)notify {
    
    /* 弹出键盘后，改变scrollView内容视图大小，以便输入框不被键盘遮挡住 */
    self.scrollView.contentSize = CGSizeMake(KWIDTH, 1.5 * KHEIGHT);
}

#pragma mark --- 键盘收缩通知方法
- (void)keyboardWillHide:(NSNotification *)notify {
    
    /* 键盘收缩后，改变scrollView内容为原始大小 */
    self.scrollView.contentSize = CGSizeMake(KWIDTH, KHEIGHT);
}

#pragma mark --- 发起登录操作的方法
- (IBAction)loginAction:(UIButton *)sender {
    
    /* 登录成功后，跳转到好友列表界面 */
    if (self.accountTextField.text.length == 0) {
        
        [self showAlertWithTitle:@"账号" message:@"账号不能为空"];
    }
    
    if (self.passwdTextField.text.length == 0) {
        
        [self showAlertWithTitle:@"密码" message:@"密码不能为空"];
    }
    
    /* 发起登录操作 */
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.accountTextField.text password:self.passwdTextField.text];
    if (error == nil) {
        
        /* 隐藏键盘输入 */
        
        /* 登录成功，跳转界面 */
        HyphenateListViewController *hyphenateListVC = [[HyphenateListViewController alloc] init];
        
        [self.navigationController pushViewController:hyphenateListVC animated:YES];
    }else {
        
        /* 提示登录失败 */
        [self showAlertWithTitle:@"登录失败" message:@"登录失败"];
    }
}

#pragma mark --- 注册方法
- (IBAction)registerAction:(UIButton *)sender {
    
    /* 数据有效性监测 */
    if (self.accountTextField.text.length == 0) {
        
        [self showAlertWithTitle:@"账号" message:@"账号不能为空"];
    }
    
    if (self.passwdTextField.text.length == 0) {
        
        [self showAlertWithTitle:@"密码" message:@"密码不能为空"];
    }
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.accountTextField.text password:self.passwdTextField.text];
    if (error == nil) {
        
        NSLog(@"注册成功");
    }else {
        
        NSLog(@"%@",error.errorDescription);
    }
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
