//
//  HCCTabBarController.m
//  HCCiOSDemo
//
//  Created by info on 2018/4/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "HCCTabBarController.h"

#import "HCCBaseNavController.h"
#import "HCCBaseController.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface HCCTabBarController ()

@end

@implementation HCCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加子控制器
    [self addChildController];
}

- (void)addChildController{
    NSArray *childItemArray = @[
                                @{
                                    kClassKey:@"OCDemoController",
                                    kTitleKey:@"Objective-C",
                                    },
                                @{
                                    kClassKey:@"CocoaTouchDemoController",
                                    kTitleKey:@"CocoaTouch",
                                    }
                                ];
    [childItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HCCBaseController *vc = [NSClassFromString([obj valueForKey:kClassKey ]) new];
        vc.title = [obj valueForKey:kTitleKey];
        HCCBaseNavController *nav = [[HCCBaseNavController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
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
