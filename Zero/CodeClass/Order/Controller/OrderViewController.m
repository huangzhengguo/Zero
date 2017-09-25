//
//  OrderViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/8/29.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "OrderViewController.h"

#import "OrderAddressTableViewCell.h"

#import "OrderProductTableViewCell.h"

#import "AddAndSubNumTableViewCell.h"

#import "UserInfoManager.h"

#import "UserInfoModel.h"

#import "OrderConfirmModel.h"

/* 支付宝功能 */
#import <AlipaySDK/AlipaySDK.h>

@interface OrderViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UserInfoModel *userInfoModel;

@property (nonatomic, strong) NSMutableDictionary *paramDic;

@property (nonatomic, strong) OrderConfirmModel *orderConfirmModel;

@property (nonatomic, strong) NSMutableArray *dataArry;

@end

@implementation OrderViewController

- (NSMutableDictionary *)paramDic {
    
    if (_paramDic == nil) {
        
        self.paramDic = [NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

- (NSMutableArray *)dataArry {
    
    if (_dataArry == nil) {
        
        self.dataArry = [NSMutableArray array];
    }
    
    return _dataArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 获取用户数据 */
    self.userInfoModel = [[UserInfoManager shareUserInfoManager] getUserInfo];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderAddressTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderProductTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddAndSubNumTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddAndSubNumTableViewCell"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    /* 请求数据 */
    self.orderConfirmModel = [[OrderConfirmModel alloc] init];
    //self.paramDic = [@{@"action":@"orderinfo",@"active_id":@"",@"buynum":@(self.num),@"g_id":self.goods_id,@"goods_id":self.zuInfoModel.bindGoodsID,@"pt_num":@"",@"pt_tid":@"",@"ticket":self.userInfoModel.ticket,@"uid":self.userInfoModel.uid} mutableCopy];
//    self.paramDic = [@{@"action":@"orderinfo",@"active_id":@"",@"buynum":@(self.num),@"g_id":[NSString stringWithFormat:@"%@",self.goods_id],@"goods_id":[NSString stringWithFormat:@"%@",self.zuInfoModel.bindGoodsID],@"pt_num":@"",@"pt_tid":@"",@"ticket":[NSString stringWithFormat:@"%@",self.userInfoModel.ticket],@"uid":[NSString stringWithFormat:@"%@",self.userInfoModel.uid]} mutableCopy];
    
    /* http://api.0gow.com/interface?action=addressappver=1.2.0&devicetype=ios&ticket=f3e84fb489e4c7bdcab356b919bd25ce&uid=40570758 */
    self.paramDic = [@{@"action":@"address",@"ticket":[NSString stringWithFormat:@"%@",self.userInfoModel.ticket],@"uid":[NSString stringWithFormat:@"%@",self.userInfoModel.uid]} mutableCopy];
    
    [self requestOrderData];
}

#pragma mark --- 请求订单数据
- (void)requestOrderData {
    
    [NetworkManager postRequestWithUrl:ZEROURL param:self.paramDic success:^(id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"1"]) {
            
            NSDictionary *dic = responseObject[@"list"][0];
            
            self.orderConfirmModel = [[OrderConfirmModel alloc] init];
            [self.orderConfirmModel setValuesForKeysWithDictionary:dic];
            [self.dataArry addObject:self.orderConfirmModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }else {
        
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        OrderAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAddressTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.dataArry.count > 0) {
            
            OrderConfirmModel *orderConfirmModel = self.dataArry[0];
            
            cell.model = orderConfirmModel;
        }
        
        return cell;
    }else {
        
        if (indexPath.row == 0) {
            
            OrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderProductTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (self.dataArry.count > 0) {
                
                //OrderConfirmModel *orderConfirmModel = self.dataArry[0];
                
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[self.picture stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
                cell.orderConfirmModel = self.zuInfoModel;
                cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.goods_name];
                cell.wlPriceLabel.text = [NSString stringWithFormat:@"物流费:￥%@",self.wlPrice];
                cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.price];
            }
            return cell;
        }else if (indexPath.row == 1){
            
            __weak AddAndSubNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAndSubNumTableViewCell" forIndexPath:indexPath];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.numTextField.text = [NSString stringWithFormat:@"%ld",(long)self.num];
            
            cell.subNumBlock = ^(){
                
                NSInteger num = [cell.numTextField.text integerValue] - 1;
                if (num > 0) {
                    
                  cell.numTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
                    
                  self.num = num;
                    
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:indexPath.section]] withRowAnimation:NO];
                }
                
            };
            
            cell.addNumBlock = ^(){
                
                NSInteger num = [cell.numTextField.text integerValue] + 1;
                if (num > 0) {
                    
                    cell.numTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
                    
                    self.num = num;
                    
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:indexPath.section]] withRowAnimation:NO];
                }
                
            };
            
            return cell;
        }else if (indexPath.row == 2){
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            CGFloat sum = [self.price integerValue] * self.num;
            cell.textLabel.text = [NSString stringWithFormat:@"共%ld件商品 合计%.02f元",(long)self.num,sum];
            
            cell.textLabel.textAlignment = NSTextAlignmentRight;
            
            return cell;
        }else{
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor orangeColor];
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            //cell.textLabel.text = @"支付宝支付";
            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 102;
    }else {
        
        if (indexPath.row == 2) {
            
            return 44;
        }
        
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        
//        NSString *partner = @"2088501566833063";
//        NSString *seller = @"chenglianshiye@yeah.net";
//        NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALS8ErohdAbxj+vz4DdLksKlWi+s5yd3zCjx712emFQxEduPIm3eL1rlhtYtNEb9JfdevN3uVhWqUlzqEvkb484IRZ1DWK0pvf3vo0gXYDiaMKqxjQqPo21ByPNnvRsrxq6YkP1CoTT6w/MEV8ylaCfc7fHOgZle49Pn98Z2sub9AgMBAAECgYEArJUvOMe7GOpQqVqez4593RqybPYpYRnXPX4ROY+5HCQjTkp28P0KsTyeLiTKV8NiHr47kZ0GXPfgYFMwvOmx9C/pE6DDpNlAaWDEciQXDzBv9jAJRYgPS5qvfOSsY3Lc5lwnN+mECIwmziPW8FJHM7SgGbrd/XZCyaES8nItFU0CQQDgjuTXWUgCwUQL39Kx+qzeAAelGDeB97jyaGpPa7yaCo8UVt8iojmN7s90KdiyN3/4s3LpMcpAPJePUlvaacGnAkEAzgpcV0TaSSjrYeBZ/5xwEmBU9yVheD8TxD969gIM3mrr/WdGTg65Do+cuiANVPSjHUH54wa0+Z10j6wAFpQ+uwJATFPFrP0H4QfYHUEi2KQgBgV0k8U7eM2+64ZaPEyeeq2EHKG6jocdkQTPNujSYyFCOkKkmGb4HAV8bpbL6d1wmQJAJ+vF/HqwuKAfCzXG+km7RTQ5AjHR8tR15f5Our+m8qlQ1CZgbttXa8TTnxR6wM0tlYuk+SHhisPBQ90Vn0pV5QJAar0Ba8WIzh1Wf5YgAG+Is1j+kbaTx9ltA4pDgsUZB+HOVqpK8+9o1N2NlqzaBale+9iZqAskvjyO1IPGzFIDPQ==";
        
        //    /* 生成订单信息，并对订单进行签名处理 */
        //    Order *order = [[Order alloc] init];
        //
        //    /* 将商品详细信息赋值给订单对象的属性 */
        //    /* 商户的唯一标识 */
        //    order.partner = partner;
        //
        //    /* 卖家支付宝账户 */
        //    order.sellerID = seller;
        //
        //    /* 订单号 */
        //    order.outTradeNO = Str(self.dataDic[@"order_sn"]);
        //
        //    /* 商品的标题 */
        //    order.subject = self.orderModel.product_name;
        //
        //    /* 商品描述信息 */
        //    order.body = @"旅游订单";
        //
        //    /* 订单价钱 */
        //    order.totalFee = [NSString stringWithFormat:@"%.2f",0.01];
        //
        //    /* 支付接口 */
        //    order.service = @"mobile.securitypay.pay";
        //
        //    /* 商户网站使用的编码格式，固定为utf-8 */
        //    order.inputCharset = @"utf-8";
        //
        //    /* 支付类型 */
        //    order.paymentType = @"1";
        //
        //    /* 支付超时时间 */
        //    order.itBPay = @"30m";
        //
        //    /* 商品地址 */
        //    order.showURL = @"";
        //
        //    /* 应用注册scheme，在info.plist定义url types */
        //    NSString *appScheme = @"weilvzhifudingdanceshi";
        //
        //    /* 将商品信息拼接成字符串 */
        //    NSString *orderInfo = [order description];
        //
        //    kMylog(@"orderInfo = %@",orderInfo);
        //
        //    /* 获取私钥，并将商户信息签名处理，外部商户可以根据情况存放私钥和签名，只要遵守rsa签名规范，并将签名字符串base65编码和urlencode */
        //
        //    id<DataSigner>signer = CreateRSADataSigner(privateKey);
        //    NSString *signString = [signer signString:orderInfo];
        //
        //    /* 将签名成功的订单信息转化成订单字符串 */
        //    NSString *orderString = @"";
        //    if (signString != nil) {
        //
        //        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderInfo, signString,@"RSA"];
        //    }
        
        NSString *orderString = @"";
        NSString *appScheme = @"weilvzhifudingdanceshi";
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            /*
             * 返回订单状态的含义:
             * 9000: 支付成功
             * 8000: 正在处理中
             * 4000: 订单处理 还要其他状态
             */
        }];

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
























































