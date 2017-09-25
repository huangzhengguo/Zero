//
//  MyInfoViewController.m
//  Zero
//
//  Created by 黄郑果 on 16/9/2.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "MyInfoViewController.h"

#import "MyInfoTextCell.h"

#import "MyInfoImgCell.h"

@interface MyInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

/* 标题字典 */
@property (nonatomic, strong) NSDictionary *titleDic;

/* 用来方式datepicker */
@property (nonatomic, strong) UIView *datepickerView;

@property (nonatomic, strong) UIDatePicker *datepicker;

@property (nonatomic, strong) NSString *dateStr;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 设置标题 */
    self.title = @"个人资料";
    
    self.dateStr = nil;
    
    /* 初始化标题字典 */
    self.titleDic = @{@"0":@[@"头像",@"昵称",@"性别",@"生日"],@"1":@[@"手机号"],@"2":@[@"会员ID"]};
    
    /* 配置tableView */
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyInfoTextCell" bundle:nil] forCellReuseIdentifier:@"MyInfoTextCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyInfoImgCell" bundle:nil] forCellReuseIdentifier:@"MyInfoImgCell"];
    
}

#pragma mark --- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.titleDic.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key = [self.titleDic.allKeys objectAtIndex:section];
    NSArray *array = [self.titleDic objectForKey:key];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        /* 头像cell */
        MyInfoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoImgCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /* 获取到字典中的数组 */
        NSArray *titleArray = [self.titleDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        
        cell.titleLabel.text = titleArray[indexPath.row];
        
        /* 对头像赋值 */
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[self.myselfInfo.img_b stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:PLACEHOLDERPATH]];
        
        return cell;
    }
        
    MyInfoTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyInfoTextCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    /* 获取到字典中的数组 */
    NSArray *titleArray = [self.titleDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
    
    cell.titleLabel.text = titleArray[indexPath.row];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            
            /* 昵称 */
            cell.titleValueLabel.text = [NSString stringWithFormat:@"%@",self.myselfInfo.nickname];
        }else if (indexPath.row == 2) {
            
            if ([self.myselfInfo.sex isEqualToString:@"1"]) {
                
                cell.titleValueLabel.text = @"男";
            }else {
                
                cell.titleValueLabel.text = @"女";
            }
        }else if (indexPath.row == 3) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (self.dateStr) {
                
                cell.titleValueLabel.text = self.dateStr;
            }
        }
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            cell.titleValueLabel.text = [NSString stringWithFormat:@"%@",self.myselfInfo.tel];
        }
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            cell.titleValueLabel.text = [NSString stringWithFormat:@"%@",self.myselfInfo.name];
        }
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    /* 分组之间间隔高度 */
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        /* view */
        self.datepickerView = [[UIView alloc] initWithFrame:CGRectMake(5, KHEIGHT / 2, KWIDTH - 10, KWIDTH - 10)];
        self.datepickerView.layer.cornerRadius = 10;
        self.datepickerView.layer.borderWidth = 1;
        self.datepickerView.layer.borderColor = [UIColor grayColor].CGColor;
        self.datepickerView.backgroundColor = [UIColor whiteColor];
        
        /* 添加取消和确定按钮 */
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        cancelBtn.frame = CGRectMake(5, 5, 100, 50);
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(datepickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        [self.datepickerView addSubview:cancelBtn];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        confirmBtn.frame = CGRectMake(self.datepickerView.frame.size.width - 105, 5, 100, 50);
        [confirmBtn setBackgroundColor:[UIColor whiteColor]];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(datepickAction:) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        [self.datepickerView addSubview:confirmBtn];
        
        /* 弹出日期选择器 */
        self.datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake((KWIDTH - 10) / 10, (KWIDTH - 10) / 6, (KWIDTH - 10) * 8/ 10, (KWIDTH - 10) * 6/ 10)];
        
        self.datepicker.datePickerMode = UIDatePickerModeDate;
        self.datepicker.backgroundColor = [UIColor whiteColor];
        
        [self.datepickerView addSubview:self.datepicker];
        
        /* 添加日期选择器 */
        [self.view addSubview:self.datepickerView];
    }
}

#pragma mark --- 处理日期选择
- (void)datepickAction:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"取消"]) {
        
        /* 移除视图 */
        [self.datepickerView removeFromSuperview];
    }else {
        
        /* 处理日期选择 */
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        
        dateFormat.dateFormat = @"yyyy-MM-dd";
        
        self.dateStr = [dateFormat stringFromDate:self.datepicker.date];
        
        /* 刷新日期 */
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:NO];
        
        /* 更新生日 */
        /* 地址http://api.0gow.com/interface?action=upUsrBirthday：appver=1.2.0&birthday=19890606&devicetype=ios&ticket=acfe5e38a125f2f8a9cfa86788c8304f&uid=40570758 */
        
        /* 移除视图 */
        [self.datepickerView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end























































