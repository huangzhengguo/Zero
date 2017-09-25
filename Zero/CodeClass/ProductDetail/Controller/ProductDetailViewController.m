//
//  ProductDetailViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/24.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "ProductDetailViewController.h"

/* 重用头视图 */
#import "ProductDetailHeaderView.h"
#import "UserCommentHeaderView.h"
#import "MoreProductHeaderView.h"

#import "DetailInfoCell.h"
#import "UserCommentCell.h"
#import "ProductDetailCell.h"
#import "TransactionRecordCell.h"
#import "MoreGoodProductCell.h"

#import "ProductDetailModel.h"
#import "UserCommentModel.h"
#import "MoreGoodProductModel.h"

/* 评论界面 */
#import "CommentViewController.h"

#import "GoodsWebInfoController.h"

#import "ZuInfoModel.h"

/* 订单界面 */
#import "OrderViewController.h"

#import "ProductManager.h"

#import "LoginAndRegisterViewController.h"

/* 引入友盟分享头文件 */
#import <UMSocial.h>

@interface ProductDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UMSocialUIDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

/* 数据请求参数 */
@property (nonatomic, strong) NSDictionary *paramDic;

/* 轮播图数据源 */
@property (nonatomic, strong) NSMutableArray *thumImgArray;

/* 放大浏览时使用 */
@property (nonatomic, strong) NSMutableArray *allThumImgArray;

/* 价格 物流等 */
@property (nonatomic, strong) NSMutableArray *priceAndStoreArray;

/* 用户评论 */
@property (nonatomic, strong) NSMutableArray *userCommentArray;

/* 商家更多好货 */
@property (nonatomic, strong) NSMutableArray *moreGoodArray;

@property (nonatomic, strong) NSMutableArray *productDetailInfoArray;

/* 构建立即购买界面数据源 */
@property (nonatomic, strong) NSMutableArray *productDetailDataArray;

/* 立即下单视图 */
@property (nonatomic, strong) UIView *buyView;

/* 产品规格 */
@property (nonatomic, strong) NSMutableArray *spec_1Attr;
@property (nonatomic, strong) NSMutableArray *spec_2Attr;

/* 记录选择的规格的名称 */
@property (nonatomic, strong) NSString *spec_1Str;
@property (nonatomic, strong) NSString *spec_2Str;

/* 记录产品的数量 */
@property (nonatomic, assign) NSInteger orderNum;

@property (nonatomic, strong) ZuInfoModel *curentProduct;

/* 当前登录的用户数据 */
@property (nonatomic, strong) UserInfoModel *userInfoModel;

/* cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation ProductDetailViewController

#pragma mark --- 懒加载部分
- (NSMutableArray *)productDetailInfoArray {
    
    if (_productDetailInfoArray == nil) {
        
        self.productDetailInfoArray = [NSMutableArray array];
    }
    
    return _productDetailInfoArray;
}

-(NSMutableArray *)thumImgArray {
    
    if (_thumImgArray == nil) {
        
        self.thumImgArray = [NSMutableArray array];
    }
    
    return _thumImgArray;
}

-(NSMutableArray *)priceAndStoreArray {
    
    if (_priceAndStoreArray == nil) {
        
        self.priceAndStoreArray = [NSMutableArray array];
    }
    
    return _priceAndStoreArray;
}

-(NSMutableArray *)allThumImgArray {
    
    if (_allThumImgArray == nil) {
        
        self.allThumImgArray = [NSMutableArray array];
    }
    
    return _allThumImgArray;
}

-(NSMutableArray *)userCommentArray {
    
    if (_userCommentArray == nil) {
        
        self.userCommentArray = [NSMutableArray array];
    }
    
    return _userCommentArray;
}

- (NSMutableArray *)moreGoodArray {
    
    if (_moreGoodArray == nil) {
        
        self.moreGoodArray = [NSMutableArray array];
    }
    
    return _moreGoodArray;
}

- (NSMutableArray *)productDetailDataArray {
    
    if (_productDetailDataArray == nil) {
        
        self.productDetailDataArray = [NSMutableArray array];
    }
    
    return _productDetailDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 初始化cell高度属性 */
    self.cellHeight = 0.0;
    
    /* 设置collectionview从0的位置开始布局 */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /* 设置导航栏 */
    [self setupNavigationController];
    
    /* 设置请求参数 */
    self.paramDic = @{@"action":@"goodsinfo",@"goods_id":self.goods_id};
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    [self.collectionView setCollectionViewLayout:layout];
    
    /* 设置collection */
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    /* 注册cell */
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    /* 注册头视图 */
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductDetailHeaderView"];
    
    /* 用户评价头视图 */
    [self.collectionView registerNib:[UINib nibWithNibName:@"UserCommentHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UserCommentHeaderView"];
    
    /* 注册价格 库存等信息cell */
    [self.collectionView registerNib:[UINib nibWithNibName:@"DetailInfoCell" bundle:nil] forCellWithReuseIdentifier:@"DetailInfoCell"];
    
    /* 用户评论cell */
    [self.collectionView registerNib:[UINib nibWithNibName:@"UserCommentCell" bundle:nil] forCellWithReuseIdentifier:@"UserCommentCell"];
    
    /* 商品详情cell */
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductDetailCell" bundle:nil] forCellWithReuseIdentifier:@"ProductDetailCell"];
    
    /* 成交记录cell */
    [self.collectionView registerNib:[UINib nibWithNibName:@"TransactionRecordCell" bundle:nil] forCellWithReuseIdentifier:@"TransactionRecordCell"];
    
    /* 商家更多商品head */
    [self.collectionView registerNib:[UINib nibWithNibName:@"MoreProductHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreProductHeaderView"];
    
    /* 商家更多商品cell */
    [self.collectionView registerNib:[UINib nibWithNibName:@"MoreGoodProductCell" bundle:nil] forCellWithReuseIdentifier:@"MoreGoodProductCell"];
    
    /* 请求数据 */
    [self requestData];
    
    /* 获取用户数据 */
    self.userInfoModel = [[UserInfoManager shareUserInfoManager] getUserInfo];
    
    /* 初始化收藏标记 */
    [self initCollectionFlag];
}

#pragma mark --- 设置导航栏项目:设置返回 分享 收藏
- (void)setupNavigationController {
    
    /* 设置导航栏的返回按钮 */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.layer.cornerRadius = 20;
    btn.backgroundColor = [UIColor grayColor];
    //[btn setAlpha:0.3];
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"<" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemOne = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    NSArray *itemBarButtonItems = @[itemOne];
    
    self.navigationItem.leftBarButtonItems = itemBarButtonItems;
    
    /* 设置分享按钮 */
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    shareButton.frame = CGRectMake(KWIDTH - 40, 0, 40, 40);
    shareButton.layer.cornerRadius = 20;
    shareButton.backgroundColor = [UIColor grayColor];
    [shareButton setAlpha:0.3];
    shareButton.layer.masksToBounds = YES;
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    /* 添加收藏按钮 */
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    collectButton.frame = CGRectMake(KWIDTH - 40 - 40, 0, 40, 40);
    collectButton.layer.cornerRadius = 20;
    collectButton.backgroundColor = [UIColor grayColor];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    collectButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [collectButton addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:collectButton];

    collectItem.title = @"收藏";
    NSArray *rightBarItems = @[shareItem,collectItem];
    
    self.navigationItem.rightBarButtonItems = rightBarItems;
}

- (void)viewWillAppear:(BOOL)animated {
    
    /* 设置导航栏透明 */
    /* 创建一张透明图片 */
    UIImage *clearColor = [ImageBackgroundColor ImageWithColor:[UIColor clearColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:clearColor forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.shadowImage=clearColor;
}

- (void)viewWillDisappear:(BOOL)animated {

    UIImage *whiteColor = [ImageBackgroundColor ImageWithColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:whiteColor forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage=whiteColor;
}

#pragma mark --- 点击返回按钮方法
- (void)backAction:(UIBarButtonItem *)sender {
    
    /* 返回上一界面 */
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 分享功能
- (void)shareAction:(UIBarButtonItem *)sender {
    
    /* 添加分享功能 */
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com"];
    
    [UMSocialData defaultData].extConfig.title = @"友盟分享";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://www.baidu.com";
    //[UMSocialData defaultData].extConfig.sinaData.urlResource =
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.baidu.com";

    /* 弹出分享列表
     * shareText:分享时的文本数据
     * shareImg:分享显示的图片
     * shareToSnsName:分享列表名称
     * delegate:代理
     */
    
    /* 这种显示方式，新浪微博分享失败 */
//    [UMSocialSnsService presentSnsController:self appKey:@"57c39ede67e58ead07001040" shareText:@"分享测试" shareImage:[UIImage imageNamed:@"select_hint"] shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone] delegate:self];
    
    /* 分享音乐self.allThumImgArray */
    NSString *imgStr = self.allThumImgArray[0];
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[imgStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[imgStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    /* 这种显示方式是在屏幕的下面以列表的形式显示 */
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"57c39ede67e58ead07001040" shareText:@"友盟分享" shareImage:[UIImage imageWithData:imgData] shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone] delegate:self];
}

#pragma mark --- 分享完成的回调方法
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    
    if (response.responseCode == UMSResponseCodeSuccess) {
        
        /* 获取到分享平台的名称 */
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark --- 收藏方法
- (void)collectAction:(UIButton *)sender {
    
    /* 如果用户没有登录 */
    if ([[UserInfoManager shareUserInfoManager] getUserInfo] == nil) {
        
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginAndRegisterViewController *loginAndRegisterVC = [mainStory instantiateViewControllerWithIdentifier:@"LoginAndRegisterViewController"];
        
        /* 模态出登录界面 */
        [self presentViewController:loginAndRegisterVC animated:YES completion:^{
            
            
        }];
        
        return;
    }
    
    /* 添加收藏功能，也就是把当前的产品的模型添加到本地数据库 */
//    self.userInfoModel = [[UserInfoManager shareUserInfoManager] getUserInfo];
//    if (self.userInfoModel == nil) {
//        
//        NSLog(@"请登录");
//        return;
//    }
    
    [self changeItemButtonText];
}

#pragma mark --- 初始化收藏标记
- (void)initCollectionFlag {
    
    if (self.userInfoModel.uid == nil) {
        
        return;
    }
    
    /* 创建管理对象 */
    ProductManager *manager = [[ProductManager alloc] init];
    UIBarButtonItem *item = self.navigationItem.rightBarButtonItems[1];
    UIButton *btn = item.customView;
    
    /* 直接使用上个界面传递过来的goods——id */
    NSArray *array = [manager queryAllProductsWithUid:self.userInfoModel.uid goods_id:self.goods_id];
    
    if (array.count > 0) {
        
        [btn setTitle:@"取消" forState:UIControlStateNormal];
    }else {
        
        [btn setTitle:@"收藏" forState:UIControlStateNormal];
    }
}

- (void)changeItemButtonText {
    
    /* 创建管理对象 */
    ProductManager *manager = [[ProductManager alloc] init];
    UIBarButtonItem *item = self.navigationItem.rightBarButtonItems[1];
    UIButton *btn = item.customView;
    
    /* 获取到model */
    if (self.priceAndStoreArray.count > 0) {
        
        ProductDetailModel *detailModel = self.priceAndStoreArray[0];
        
        /* 创建表 */
        [manager createProductCollectionTable];
        
        if ([btn.titleLabel.text isEqualToString:@"收藏"]) {
            /* 插入表 */
            BOOL success = [manager insertIntoProductCollectionTable:detailModel uid:self.userInfoModel.uid];
            if (success == YES) {
                
                /* 收藏成功 */
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
        }else {
            
            /* 删除记录 */
            BOOL success = [manager deleteFromProductCollectionTableWithGoodId:detailModel.goods_id uid:self.userInfoModel.uid];
            if (success == YES) {
                
                /* 收藏成功 */
                [btn setTitle:@"收藏" forState:UIControlStateNormal];
            }
        }
    }
}

#pragma mark --- 联系客服方法
- (IBAction)contactAction:(UIButton *)sender {
    
    //NSLog(@"联系客服");
}

#pragma mark --- 立即购买方法
- (IBAction)buyAction:(UIButton *)sender {
    
    //NSLog(@"%ld",self.productDetailDataArray.count);
    
    /* 当前界面显示的产品作为默认产品 */
    ProductDetailModel *detailModel = self.priceAndStoreArray[0];
    
    //NSLog(@"立即购买");
    /* 弹出下单界面 */
    self.buyView = [[UIView alloc] init];
    self.buyView.tag = 10000;
    
    /* 添加关闭按钮 */
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH - 60, 0, 60, 30)];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.backgroundColor = [UIColor greenColor];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBuyView:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyView addSubview:closeBtn];
    
    /* 添加图像 */
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, -10, 100, 100)];
    
    /* 设置图片 */
    [imgView sd_setImageWithURL:[NSURL URLWithString:[detailModel.thumbnail_s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
    imgView.backgroundColor = RANDOMCOLOR;
    imgView.tag = 1001;
    [self.buyView addSubview:imgView];
    
    /* 添加现价标签 */
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + 100 + 5, 0, 100, 40)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",detailModel.Price];
    priceLabel.textColor = [UIColor orangeColor];
    priceLabel.font = [UIFont systemFontOfSize:20];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.tag = 1002;
    [self.buyView addSubview:priceLabel];
    
    /* 添加原价标签 */
    StrikeLabel *scPriceLabel = [[StrikeLabel alloc] initStrikeLabelWithString:[NSString stringWithFormat:@"￥%@",detailModel.scPrice]];
    scPriceLabel.frame = CGRectMake(5 + 100 + 5 + 3, 40, 100, 20);
    scPriceLabel.textColor = [UIColor blackColor];
    scPriceLabel.font = [UIFont systemFontOfSize:15];
    scPriceLabel.backgroundColor = [UIColor clearColor];
    scPriceLabel.tag = 1003;
    [self.buyView addSubview:scPriceLabel];
    
    /* 添加库存标签 */
    UILabel *stockLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + 100 + 5 + 5, 70, 200, 20)];
    stockLabel.font = [UIFont systemFontOfSize:15];
    stockLabel.text = [NSString stringWithFormat:@"库存%@件",detailModel.goodsNowStock];
    stockLabel.textColor = [UIColor blackColor];
    stockLabel.backgroundColor = [UIColor clearColor];
    stockLabel.tag = 1004;
    [self.buyView addSubview:stockLabel];
    
    /* 添加物流费标签 */
    UILabel *wlPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH - 200, 70, 200, 20)];
    wlPriceLabel.textAlignment = NSTextAlignmentRight;
    wlPriceLabel.text = [NSString stringWithFormat:@"物流费￥%@",detailModel.wlPrice];
    wlPriceLabel.textColor = [UIColor blackColor];
    wlPriceLabel.font = [UIFont systemFontOfSize:15];
    wlPriceLabel.backgroundColor = [UIColor clearColor];
    wlPriceLabel.tag = 1005;
    [self.buyView addSubview:wlPriceLabel];
    
    /* 添加一条label用作分割线 */
    UILabel *separateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 95, KWIDTH - 10, 1)];
    separateLabel.backgroundColor = [UIColor grayColor];
    [self.buyView addSubview:separateLabel];
    
    NSInteger heightForZui = 0;
    /* 根据物品信息创建产品尺寸等按钮信息 */
    if (self.productDetailDataArray.count > 0) {
        
        self.spec_1Attr = [NSMutableArray array];
        self.spec_2Attr = [NSMutableArray array];
        for (int i=0;i<self.productDetailDataArray.count;i++) {
            
            ZuInfoModel *firstProduct = self.productDetailDataArray[i];
            
            if (firstProduct.spec_1Attr.length > 0 && ![self.spec_1Attr containsObject:firstProduct.spec_1Attr]) {
                
                [self.spec_1Attr addObject:firstProduct.spec_1Attr];
            }
            
            if (firstProduct.spec_2Attr.length > 0 && ![self.spec_2Attr containsObject:[firstProduct.spec_2Attr stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
                
                [self.spec_2Attr addObject:[firstProduct.spec_2Attr stringByReplacingOccurrencesOfString:@" " withString:@""]];
            }
        }

        /* 创建规格1按钮 */
        NSInteger lineBtnCount = 5;
        NSInteger btnHeight = 30;
        NSInteger hSpace = 8;
        NSInteger vSpace = 5;
        NSInteger btnCount = 0;
        for (int j=0;j<self.spec_1Attr.count;j++) {
            
            btnCount ++;
            CGRect btnFrame = [LayoutButton calculateFrameWithButtonCount:lineBtnCount buttonIndex:j buttonHeight:btnHeight buttonHSpace:hSpace buttonVSpace:vSpace];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnFrame.origin.x, btnFrame.origin.y + 100, btnFrame.size.width, btnFrame.size.height)];
            
            /* 第一组btn tag值从100000开始 */
            btn.tag = 100000 + j;
            
            /* 添加选择规格的方法 */
            [btn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn setTitle:[NSString stringWithFormat:@"%@",self.spec_1Attr[j]] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor grayColor];
            
            [self.buyView addSubview:btn];
        }
        
        /* 计算规格1的高度 */
        heightForZui = (2 * (btnCount / (lineBtnCount + 1)) + 2) * vSpace + (btnCount / (lineBtnCount + 1) + 1) * btnHeight;
        
        btnCount = 0;
        for (int j=0;j<self.spec_2Attr.count;j++) {
            
            btnCount ++;
            CGRect btnFrame = [LayoutButton calculateFrameWithButtonCount:lineBtnCount buttonIndex:j buttonHeight:btnHeight buttonHSpace:hSpace buttonVSpace:vSpace];
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnFrame.origin.x, btnFrame.origin.y + 100 + heightForZui, btnFrame.size.width, btnFrame.size.height)];
            
            btn.tag = 1000000 + j;
            
            [btn addTarget:self action:@selector(attr2SelectAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn setTitle:[NSString stringWithFormat:@"%@",self.spec_2Attr[j]] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor grayColor];
            
            [self.buyView addSubview:btn];
        }
        
        heightForZui += (2 * (btnCount / (lineBtnCount + 1)) + 2) * vSpace + (btnCount / (lineBtnCount + 1) + 1) * btnHeight;
        
        /* 添加分割线 */
        if (heightForZui != 0) {
            
            /* 添加一条label用作分割线 */
            UILabel *separateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, heightForZui + 100 + 5, KWIDTH - 10, 1)];
            separateLabel.backgroundColor = [UIColor grayColor];
            [self.buyView addSubview:separateLabel];
        }
    }
    
    heightForZui += 100;
    /* 添加数量及加减按钮 */
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, heightForZui + 5 + 20, 100, 30)];
    
    numLabel.text = @"数量";
    [self.buyView addSubview:numLabel];
    
    heightForZui = heightForZui + 5 + 20;
    /* 添加加减及数量 */
    UIButton *subBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH / 2, heightForZui, 50, 30)];
    
    subBtn.backgroundColor = [UIColor lightGrayColor];
    subBtn.tag = 10000;
    [subBtn addTarget:self action:@selector(subAndAddAction:) forControlEvents:UIControlEventTouchUpInside];
    [subBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.buyView addSubview:subBtn];
    
    /* 添加数量 */
    UILabel *addNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH / 2 + 50, heightForZui, KWIDTH / 2 - 100, 30)];
    
    addNumLabel.tag = 10001;
    addNumLabel.textAlignment = NSTextAlignmentCenter;
    addNumLabel.text = @"1";
    [self.buyView addSubview:addNumLabel];

    /* 添加加减及数量 */
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWIDTH - 50, heightForZui, 50, 30)];
    
    addBtn.tag = 10002;
    [addBtn addTarget:self action:@selector(subAndAddAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.backgroundColor = [UIColor lightGrayColor];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.buyView addSubview:addBtn];
    
    heightForZui = heightForZui + 50;
    
    /* 在视图最下面添加60高度立即购买的按钮 */
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, heightForZui, KWIDTH, 60)];
    
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyRightNowAction:) forControlEvents:UIControlEventTouchUpInside];
    [buyBtn setBackgroundColor:[UIColor redColor]];
    [self.buyView addSubview:buyBtn];
    
    heightForZui = heightForZui + 80;
    
    /* 设置视图的frame */
    self.buyView.frame = CGRectMake(0, KHEIGHT - heightForZui + 20, KWIDTH, heightForZui);
    self.buyView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.buyView];
    [self.view bringSubviewToFront:self.buyView];
    
    /* 初始化选择项 */
    if (self.spec_1Attr.count > 0) {
        
        self.spec_1Str = self.spec_1Attr[0];
        
        /* 并设置button颜色为红色 */
        UIButton *btn = [self.buyView viewWithTag:100000];
        UIImage *colorImg = [ImageBackgroundColor ImageWithColor:[UIColor redColor]];
        
        [btn setBackgroundImage:colorImg forState:UIControlStateNormal];
    }
    
    if (self.spec_2Attr.count > 0) {
        
        self.spec_2Str = self.spec_2Attr[0];
        
        /* 并设置button颜色为红色 */
        UIButton *btn = [self.buyView viewWithTag:1000000];
        UIImage *colorImg = [ImageBackgroundColor ImageWithColor:[UIColor redColor]];
        
        [btn setBackgroundImage:colorImg forState:UIControlStateNormal];
    }
    
    [self changeAttr];
    
}

#pragma mark --- 选择规格按钮的方法
- (void)selectAction:(UIButton *)sender {
 
    for (int i=0;i<self.spec_1Attr.count;i++) {
        
        UIButton *btn = [self.buyView viewWithTag:100000 + i];
        if ((100000 + i) == sender.tag) {
            
            /* 记录选择的 */
            self.spec_1Str = self.spec_1Attr[i];
            
            /* 设置选择的颜色 */
            UIImage *colorImg = [ImageBackgroundColor ImageWithColor:[UIColor redColor]];
            
            [btn setBackgroundImage:colorImg forState:UIControlStateNormal];
        }else {
            
            /* 设置选择的颜色 */
            UIImage *colorImg = [ImageBackgroundColor ImageWithColor:[UIColor grayColor]];
            
            [btn setBackgroundImage:colorImg forState:UIControlStateNormal];
        }
    }
    
    [self changeAttr];
}

- (void)attr2SelectAction:(UIButton *)sender {
    
    for (int i=0;i<self.spec_2Attr.count;i++) {
        
        UIButton *btn = [self.buyView viewWithTag:1000000 + i];
        if ((1000000 + i) == sender.tag) {
            
            /* 记录选择的 */
            self.spec_2Str = self.spec_2Attr[i];
            
            /* 设置选择的颜色 */
            UIImage *colorImg = [ImageBackgroundColor ImageWithColor:[UIColor redColor]];
            
            [btn setBackgroundImage:colorImg forState:UIControlStateNormal];
        }else {
            
            /* 设置选择的颜色 */
            UIImage *colorImg = [ImageBackgroundColor ImageWithColor:[UIColor grayColor]];
            
            [btn setBackgroundImage:colorImg forState:UIControlStateNormal];
        }
    }
    
    [self changeAttr];
}

#pragma mark --- 更改选择
- (void)changeAttr {
    
    self.orderNum = 1;
    /* 同时需要改变库存和价格及物流费 */
    for (ZuInfoModel *model in self.productDetailDataArray) {
        
        if ([model.spec_1Attr isEqualToString:self.spec_1Str] && [model.spec_2Attr isEqualToString:self.spec_2Str]) {
            
            /* 找到了对应的商品 */
            UIImageView *headImgView = [self.buyView viewWithTag:1001];
            
            [headImgView sd_setImageWithURL:[NSURL URLWithString:[model.thumbnail_s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
            
            /* 设置现价和原价 */
            UILabel *priceLabel = [self.buyView viewWithTag:1002];
            
            priceLabel.text = [NSString stringWithFormat:@"￥%@",model.Price];
            
            StrikeLabel *scPriceLabel = [self.buyView viewWithTag:1003];
            
            scPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.scPrice];
            
            UILabel *stockLabel = [self.buyView viewWithTag:1004];
            
            stockLabel.text = [NSString stringWithFormat:@"库存%@件",model.goodsNowStock];
            
            UILabel *wlLabel = [self.buyView viewWithTag:1005];
            
            wlLabel.text = [NSString stringWithFormat:@"物流费%@",model.wlPrice];
            
            /* 记录选择的model */
            self.curentProduct = model;
        }
    }
}

#pragma mark --- 关闭下单界面
- (void)closeBuyView:(UIButton *)sender {
    
    /* 退出 */
    [self.buyView removeFromSuperview];
}

- (void)subAndAddAction:(UIButton *)sender {
    
    UILabel *label = [[self.view viewWithTag:10000] viewWithTag:10001];
    NSInteger value = [label.text integerValue];
    if (sender.tag == 10000) {
        
        if (value > 1) {
            
           label.text = [NSString stringWithFormat:@"%ld",(long)--value];
            
            /* 记录数量 */
            self.orderNum = value;
        }
    }else if (sender.tag == 10002) {
        
        label.text = [NSString stringWithFormat:@"%ld",(long)++value];
        self.orderNum = value;
    }
}

#pragma mark --- 立即购买方法
- (void)buyRightNowAction:(UIButton *)sender {
    
    
    /* 如果用户没有登录 */
    if ([[UserInfoManager shareUserInfoManager] getUserInfo] == nil) {
        
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginAndRegisterViewController *loginAndRegisterVC = [mainStory instantiateViewControllerWithIdentifier:@"LoginAndRegisterViewController"];
        
        /* 模态出登录界面 */
        [self presentViewController:loginAndRegisterVC animated:YES completion:^{
            
            
        }];
        
        return;
    }
    
    /* 跳转到订单界面 */
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    ProductDetailModel *detailModel = self.priceAndStoreArray[0];
    
    orderVC.title = @"确认订单";
    orderVC.zuInfoModel = self.curentProduct;
    orderVC.num = self.orderNum;
    orderVC.goods_name = detailModel.goods_name;
    orderVC.wlPrice = detailModel.wlPrice;
    orderVC.goods_id = detailModel.goods_id;
    orderVC.price = detailModel.Price;
    orderVC.picture = [NSString stringWithFormat:@"%@",self.thumImgArray[0]];
    
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark --- 请求数据
- (void)requestData {
    
    /* 清除数据源 */
    [self.thumImgArray removeAllObjects];
    [self.priceAndStoreArray removeAllObjects];
    [self.userCommentArray removeAllObjects];
    [self.moreGoodArray removeAllObjects];
    [self.productDetailDataArray removeAllObjects];
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        /* 解析所有数据 */
        /* 轮播图数据 */
        NSArray *imgArray = responseObject[@"img"];
        NSInteger tmpCount = 0;
        for (NSDictionary *dic in imgArray) {
            
            [self.allThumImgArray addObject:dic[@"thumbnail_m"]];
            if (tmpCount < 3) {
                
                [self.thumImgArray addObject:dic[@"thumbnail_m"]];
            }
            
            tmpCount ++;
        }
        
        /* 获取价格 物流 库存等信息 */
        NSDictionary *detailDic = responseObject;
        ProductDetailModel *detailModel = [[ProductDetailModel alloc] init];
        
        [detailModel setValuesForKeysWithDictionary:detailDic];
        
        detailModel.hpl = detailDic[@"commentStatic"][@"hpl"];
        detailModel.tsl = detailDic[@"commentStatic"][@"tsl"];
        
        [self.priceAndStoreArray addObject:detailModel];
        
        
        /* 获取评论信息 */
        NSArray *commentArray = responseObject[@"comments"];
        for (NSDictionary *dic in commentArray) {
            
            UserCommentModel *model = [[UserCommentModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.userCommentArray addObject:model];
        }
        
        /* 获取商家更多商品 */
        NSArray *recommendArray = responseObject[@"recommend"];
        for (NSDictionary *dic in recommendArray) {
            
            MoreGoodProductModel *model = [[MoreGoodProductModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.moreGoodArray addObject:model];
        }
        
        /* 获取构建立即购买界面数据 */
        NSArray *zuInfoArray = responseObject[@"zuInfo"];
        for (NSDictionary *dic in zuInfoArray) {
            
            ZuInfoModel *model = [[ZuInfoModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [self.productDetailDataArray addObject:model];
        }
        
        
        /* 主线程刷新界面 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        /* 商品详情cell */
        return 1;
    }if (section == 1) {
        
        /* 用户评论区域 */
        if (self.userCommentArray.count > 0) {
            
            return 1;
        }
        
        return 0;
    }else if (section == 2) {
        
        return 1;
    }else if (section == 3) {
        
        return 1;
    }
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        DetailInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailInfoCell" forIndexPath:indexPath];
        
        if (self.priceAndStoreArray.count > 0) {
            
            ProductDetailModel *detailModel = self.priceAndStoreArray[0];
            
            cell.model = detailModel;
        }
        
        return cell;
    }else if (indexPath.section == 1) {
        
        UserCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserCommentCell" forIndexPath:indexPath];
        
        /* 实现cell回调 */
        cell.btnClikcBlock = ^ {
            
            /* 把所有评论数据传递到评论界面 */
            CommentViewController *commentVC = [[CommentViewController alloc] init];
            
            if (self.priceAndStoreArray.count > 0) {
                
                ProductDetailModel *detailModel = self.priceAndStoreArray[0];
                commentVC.goods_id = detailModel.goods_id;
            }

            /* 跳转 */
           [self.navigationController pushViewController:commentVC animated:YES];
        };
        
        if (self.userCommentArray.count > 0 && self.priceAndStoreArray.count > 0) {
            
            ProductDetailModel *detailModel = self.priceAndStoreArray[0];
            
            UserCommentModel *model = self.userCommentArray[indexPath.row];
            
            [cell setCellWithModel:model hpl:detailModel.hpl tsl:detailModel.tsl];
        }
        
        return cell;
    }else if (indexPath.section == 2) {
        
        ProductDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductDetailCell" forIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.section == 3) {
        
        TransactionRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TransactionRecordCell" forIndexPath:indexPath];
        
        if (self.priceAndStoreArray.count > 0) {
            
            ProductDetailModel *detailModel = self.priceAndStoreArray[0];
            
            cell.recordLB.text = [NSString stringWithFormat:@"成交记录(%@)",detailModel.sale];
        }
        
        return cell;
    }else if (indexPath.section == 4) {
        
        MoreGoodProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoreGoodProductCell" forIndexPath:indexPath];
        
        if (self.moreGoodArray.count > 0) {
            
            MoreGoodProductModel *model = self.moreGoodArray[indexPath.row];
            
            cell.model = model;
        }
        
        return cell;
    }
    
    
    /* 其他情况防止出错 */
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

/* 这个代理方法必须写，否则区头显示不出来 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return CGSizeMake(KWIDTH, 150);
    }else if (section == 1) {
        
        return CGSizeMake(KWIDTH, 50);
    }else if (section == 4) {
        
        return CGSizeMake(KWIDTH, 60);
    }
    
    return CGSizeMake(KWIDTH, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            
            /* 如果是第一个头视图，重用轮播图 */
            ProductDetailHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductDetailHeaderView" forIndexPath:indexPath];
            
            /* 对轮播图赋值 */
            headerView.cycScrollView.imageURLStringsGroup = self.thumImgArray;
            
            return headerView;
        }else if (indexPath.section == 1) {
            
            /* 用户评价头视图 */
            UserCommentHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UserCommentHeaderView" forIndexPath:indexPath];
            
            if (self.priceAndStoreArray.count > 0) {
                
                ProductDetailModel *detailModel = self.priceAndStoreArray[0];
                
                /* 填充评论总数 */
                headerView.userCommentLB.text = [NSString stringWithFormat:@"用户评价(%@)",detailModel.commentCount];
            }

            return headerView;
        }else if (indexPath.section == 4) {
            
            /* 商家更多好货头视图 */
            MoreProductHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreProductHeaderView" forIndexPath:indexPath];
            
            return headerView;
        }

    }

    return [[UICollectionReusableView alloc] init];
}

#pragma 设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return CGSizeMake(KWIDTH, 138);
    }else if (indexPath.section == 1) {
        
        /* 评论区域自适应大小 */
        /* 获取item从nib文件直接加载即可，如果从重用池中获取会出错 */
        UserCommentCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"UserCommentCell" owner:nil options:nil] firstObject];
        UserCommentModel *model = self.userCommentArray[indexPath.row];
        
        /* cell调用自适应高度的方法 */
        [cell cellAutoLayoutHeight:model.body];
        
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
        
        return CGSizeMake(KWIDTH, size.height);
   
    }else if (indexPath.section == 2) {
        
        return CGSizeMake(KWIDTH, 50);
    }
    else if (indexPath.section == 3) {
        
        return CGSizeMake(KWIDTH, 50);
    }else if (indexPath.section == 4) {
        
        return CGSizeMake((KWIDTH-10) / 2, (KWIDTH-10) * 2 / 2);
    }
    
    return CGSizeMake((KWIDTH-30) / 3, (KWIDTH-30) * 2 / 3);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        /* 跳转到商品详情 */
        GoodsWebInfoController *goodsWebInfoVC = [[GoodsWebInfoController alloc] init];
        
        /* goods_id */
        if (self.priceAndStoreArray.count > 0) {
            
            ProductDetailModel *detailModel = self.priceAndStoreArray[0];
            
            goodsWebInfoVC.product_description = detailModel.product_description;
            
            [self.navigationController pushViewController:goodsWebInfoVC animated:YES];
        }

        
    }else if (indexPath.section == 3){
        
        /* 跳转到成交记录 */
    }else if (indexPath.section == 4) {
        
        /* 取出goods_id,跳转到详情页面 */
        /* 跳转到三级页面 */
        ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
        
        /* 需要传递goods_id */
        MoreGoodProductModel *model = self.moreGoodArray[indexPath.row];

        productDetailVC.goods_id = model.goods_id;
        
        [self.navigationController pushViewController:productDetailVC animated:YES];
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








































