//
//  UIButton+Category.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/11.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)


+ (instancetype)hcc_buttonWithTitle:(NSString *)title withColor:(UIColor *)color{
    UIButton *button = [UIButton new];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    return button;
}
@end
