//
//  OCDemoController.m
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//


#import "OCDemoController.h"
#import "FirstController.h"
#import "MultithreadingController.h"
#import "SaveDataController.h"
#import "BlockController.h"
#import "SDWebImageDemoController.h"
#import "NotificationController.h"

#define kCellID @"ObjectiveCell"
@interface OCDemoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSArray *titleArray;

@end

@implementation OCDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _titleArray = @[@"@property的详细介绍",@"内存管理",@"KVC与KVO的理解",@"runtime详解",@"深入理解RunLoop",@"分类和扩展",@"多线程编程",@"本地持久化存储",@"Block用法",@"SDWebImage详解",@"本地推送"];
    
    //创建UI控件
    [self setupUI];
}

//页面布局
- (void)setupUI{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [table registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:kCellID];
    [self.view addSubview:table];
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -- UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 6) {
        [self.navigationController pushViewController:[[FirstController alloc] init] animated:YES];
    }else if(indexPath.row == 6){
        [self.navigationController pushViewController:[[MultithreadingController alloc] init] animated:YES];
    }else if(indexPath.row == 7){
       [self.navigationController pushViewController:[[SaveDataController alloc] init] animated:YES];
    }else if(indexPath.row == 8){
        [self.navigationController pushViewController:[[BlockController alloc] init] animated:YES];
    }else if(indexPath.row == 9){
        [self.navigationController pushViewController:[[SDWebImageDemoController alloc] init] animated:YES];
    }else if(indexPath.row == 10){
        [self.navigationController pushViewController:[[NotificationController alloc] init] animated:YES];
    }
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
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
