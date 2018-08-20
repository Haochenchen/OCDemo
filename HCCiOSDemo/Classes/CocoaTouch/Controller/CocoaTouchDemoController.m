//
//  CocoaTouchDemoController.m
//  HCCiOSDemo
//
//  Created by info on 2018/6/13.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "CocoaTouchDemoController.h"
#import "MapController.h"
#import "AnimationController.h"
#import "DrawController.h"
#import "LayerController.h"
#define kCellID @"CocoaTouchCell"
@interface CocoaTouchDemoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy)NSArray *titleArray;
@end

@implementation CocoaTouchDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _titleArray = @[@"地图",@"核心动画",@"绘图",@"图层"];
    
    
    
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
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[MapController alloc] init] animated:YES];
    }else if(indexPath.row == 1){
        [self.navigationController pushViewController:[[AnimationController alloc] init] animated:YES];
    }else if(indexPath.row == 2){
        [self.navigationController pushViewController:[[DrawController alloc] init] animated:YES];
    }else if(indexPath.row == 3){
        [self.navigationController pushViewController:[[LayerController alloc] init] animated:YES];
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
