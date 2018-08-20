//
//  DrawController.m
//  HCCiOSDemo
//
//  Created by info on 2018/6/22.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "DrawController.h"
#import "BezierView.h"
@interface DrawController ()

@end

@implementation DrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BezierView *view = [[BezierView alloc] initWithFrame:CGRectMake(90, Height_NavBar, 200, 200)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
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
