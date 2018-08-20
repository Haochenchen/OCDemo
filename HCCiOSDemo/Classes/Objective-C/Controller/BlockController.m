//
//  BlockController.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/18.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "BlockController.h"

@interface BlockController ()

@end

@implementation BlockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    //声明一个无返回值，有两个int类型参数的，叫做blk的block
    void(^blk)(int);
    
    //无参数无返回值的block表达式
    blk = ^void(int a){
        int b = a+1;
        NSLog(@"这是block块----%d",b);
    };
    blk(4);
    
    //定义了一个返回值为int型，有两个int类型参数的，叫做add的block。表达式内将两个int参数相加，并将结果返回
    int(^add)(int,int) = ^(int a,int b) {
        int c = a+b;
        return c;
    };
    int result = add(5,4);
    NSLog(@"result----%d",result);
    
    //借助typedef简写
    ADD add_k = ^(int a,int b) {
        int c = a+b;
        return c;
    };
    int result_k = add_k(4,2);
    NSLog(@"result_k----%d",result_k);
    
     */
    __block int a = 10;
    void(^blk)(void) = ^(void) {
        NSLog(@"block内部a----%d",a);//block内部a----10
    };
    
    a = 15;
    blk();
    NSLog(@"a----%d", a);//a----15
    __weak typeof(self) weakSelf = self;
    self.addBlock = ^(int a,int b) {
        int c = a+b;
         NSLog(@"In Block : %@",weakSelf);
        return c;
    };
    
    self.addBlock(5, 4);
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
