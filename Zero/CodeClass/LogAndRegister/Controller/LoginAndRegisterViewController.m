//
//  LoginAndRegisterViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/26.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "LoginAndRegisterViewController.h"

#import "UserInfoModel.h"

#import "MD5Manager.h"

#import "UserInfoManager.h"

#import "TabBarViewController.h"

#import <UMSocialWechatHandler.h>

#import <UMSocialSnsPlatformManager.h>

#import <UMSocialAccountManager.h>

@interface LoginAndRegisterViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *topImgView;

@property (strong, nonatomic) UIButton *wechatButton;

@property (strong, nonatomic) UIButton *phoneButton;

@property (strong, nonatomic) UIImageView *wechatImg;

@property (strong, nonatomic) UITextField *phoneTF;

@property (strong, nonatomic) UITextField *passwordTF;

@property (strong, nonatomic) UIButton *logButton;

@property (strong, nonatomic) UIButton *findPasswordButton;

@property (strong, nonatomic) UIButton *wechatLoginButton;

@property (strong, nonatomic) UIButton *registerButton;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIScrollView *backgroundScrollView;

@property (strong, nonatomic) IBOutlet UIButton *closeButton;



@property (nonatomic, strong) NSMutableDictionary *paramDic;

/* 用户信息数据源 */
@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation LoginAndRegisterViewController

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    /* 注册监听键盘弹出事件 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    /* 注册监听键盘弹出事件 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.closeButton.layer.cornerRadius = 10;
    self.closeButton.layer.masksToBounds = YES;
    
    [self setupView];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    
    /* 增大scrollView大小 */
    [self.backgroundScrollView setContentSize:CGSizeMake(KWIDTH, 1.5 * KHEIGHT)];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    /* 缩小scrollView大小 */
    [self.backgroundScrollView setContentSize:CGSizeMake(KWIDTH, KHEIGHT)];
}

#pragma mark --- 布局控件
- (void)setupView {
    
    /* 添加一个大的scrollview */
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    self.backgroundScrollView.contentSize = CGSizeMake(KWIDTH, KHEIGHT);;
    
    [self.view addSubview:self.backgroundScrollView];
    
    /* 添加背景img:高占 30%，宽为屏宽 */
    self.topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT / 3)];
    self.topImgView.backgroundColor = [UIColor blueColor];
    [self.backgroundScrollView addSubview:self.topImgView];
    
    /* 添加微信快捷登录 */
    self.wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH / 7, KHEIGHT / 3, KWIDTH * 2 / 7, 50)];
    [self.wechatButton setTitle:@"微信快捷登录" forState:UIControlStateNormal];
    [self.wechatButton.titleLabel setTextColor:[UIColor blackColor]];
    [self.wechatButton setTag:1000];
    [self.wechatButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.wechatButton addTarget:self action:@selector(switchLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundScrollView addSubview:self.wechatButton];
    
    /* 添加手机快捷登录按钮 */
    self.phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH - KWIDTH / 7 - KWIDTH * 2 / 7, KHEIGHT / 3, KWIDTH * 2 / 7, 50)];
    [self.phoneButton setTitle:@"手机快捷登录" forState:UIControlStateNormal];
    [self.phoneButton.titleLabel setTextColor:[UIColor blackColor]];
    [self.phoneButton setTag:1001];
    [self.phoneButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.phoneButton addTarget:self action:@selector(switchLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundScrollView addSubview:self.phoneButton];

    /* 添加scrolleView */
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KHEIGHT / 3 + 50, KWIDTH, KHEIGHT - 50 - KHEIGHT / 3)];
    self.scrollView.contentSize = CGSizeMake(KWIDTH * 2, KHEIGHT - 50 - KHEIGHT / 3);
    
    /* 在scrollview上添加微信图标及登录按钮 */
    self.wechatImg = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH - 150) / 2, 20, 150, 150)];
    self.wechatImg.image = [UIImage imageNamed:@"icon_weixin"];
    
    [self.scrollView addSubview:self.wechatImg];
    
    self.wechatLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, KWIDTH - 20, 50)];
    [self.wechatLoginButton setTitle:@"微信快捷登录" forState:UIControlStateNormal];
    self.wechatLoginButton.backgroundColor = [UIColor redColor];
    self.wechatLoginButton.layer.cornerRadius = 25;
    /* 添加微信登录按钮方法 */
    [self.wechatLoginButton addTarget:self action:@selector(wechatLoinAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:self.wechatLoginButton];
    
    /* 在scrollview上添加手机登录控件 */
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(KWIDTH + KWIDTH / 20, 20, KWIDTH - KWIDTH * 2 / 20, 60)];
    self.phoneTF.layer.cornerRadius = 20;
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.backgroundColor = [UIColor whiteColor];
    self.phoneTF.tag = 1002;
    self.phoneTF.delegate = self;
    [self.scrollView addSubview:self.phoneTF];
    
    self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(KWIDTH + KWIDTH / 20, 20 + 20 + 60, KWIDTH - KWIDTH * 2 / 20, 60)];
    self.passwordTF.layer.cornerRadius = 20;
    self.passwordTF.backgroundColor = [UIColor whiteColor];
    self.passwordTF.placeholder = @"请输入密码";
    self.passwordTF.tag = 1003;
    self.passwordTF.delegate = self;
    [self.scrollView addSubview:self.passwordTF];
    
    self.logButton = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH + KWIDTH / 20, 20 + 20 + 60 + 20 + 60, KWIDTH - 2 * KWIDTH / 20, 60)];
    self.logButton.layer.cornerRadius = 20;
    self.logButton.backgroundColor = [UIColor grayColor];
    [self.logButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.logButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:self.logButton];
    
    [self.backgroundScrollView addSubview:self.scrollView];
    
    [self.view bringSubviewToFront:self.closeButton];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1002) {
        
        [self.phoneTF resignFirstResponder];
    }
}

#pragma mark --- 微信登录
- (void)wechatLoinAction:(UIButton *)sender {
    
    /* 添加微信登录方法 */
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response) {
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            //NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            
            //NSLog(@"字典数据:%@",dict);
            
            /* 成功 */
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            
            //NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
            /* 获取到用户信息之后，跳转到用户信息界面，并保存用户信息 */
            /* 保存用户信息 */
            UserInfoModel *model = [[UserInfoModel alloc] init];
            
            model.nickname = response.thirdPlatformUserProfile[@"nickname"];;
            model.token = snsAccount.accessToken;
            model.headimgurl = response.thirdPlatformUserProfile[@"headimgurl"];

            /* 保存用户信息 */
            [[UserInfoManager shareUserInfoManager] saveUserInfo:model];
            
            /* 跳转界面 */
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
            
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
        }
    });
}

/* 切换登录界面方法 */
- (void)switchLoginAction:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        
        /* 滚动视图 */
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (sender.tag == 1001) {
        
        /* 滚动视图 */
        [self.scrollView setContentOffset:CGPointMake(KWIDTH, 0) animated:YES];
    }
}

/* 手机登录事件 */
- (void)loginAction:(UIButton *)sender {
    
    /* 取出手机号 */
    NSString *phoneNumber = self.phoneTF.text;
    NSString *password = self.passwordTF.text;
    
    /* 进行简单判断 */
    if (phoneNumber.length == 0) {
        
        [self showAlertWithTitle:@"手机号不能为空" message:@"登录信息"];
        
        /* 直接返回 */
        return;
    }
    
    if (password.length == 0) {
        
        [self showAlertWithTitle:@"密码不能为空" message:@"登录信息"];
        
        /* 直接返回 */
        return;
    }
    
    /* 密码需要MD5加密后发送 */
    NSString *md5Password = [[MD5Manager encryptStringWithMD5:password] lowercaseString];

    //NSLog(@"%@",md5Password);
    
    /* 设置登录参数 */
    self.paramDic = [@{@"action":@"loginTel",@"DeviceID":@"69010f2ebf717830beb4e3ffc2c26998",@"tel":phoneNumber,@"password":md5Password} mutableCopy];
    
    /* 登录请求 */
    [self loginWithPhoneNum];
}

- (void)loginWithPhoneNum {
    
    [NetworkManager postRequestWithUrl:LOGINURL param:self.paramDic success:^(id responseObject) {
        
        /* 登录成功后跳转到我的界面 */
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"1"]) {
            
            /* 如果请求成功 */
            NSDictionary *userInfoDic = responseObject[@"user"];
            UserInfoModel *userInfoModel = [[UserInfoModel alloc] init];
            
            [userInfoModel setValuesForKeysWithDictionary:userInfoDic];
            
            /* 保存用户信息 */
            [[UserInfoManager shareUserInfoManager] saveUserInfo:userInfoModel];
            
            /* 跳转界面 */
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
            
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
            
        }
        
    } fail:^(NSError *error) {
        
        
    }];
}

- (IBAction)closeAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
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
