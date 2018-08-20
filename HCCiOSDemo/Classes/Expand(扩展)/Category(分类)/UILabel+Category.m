//
//  UILabel+Category.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/15.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)
+ (instancetype)hcc_labelWithTitle:(NSString *)title withColor:(UIColor *)color{
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightLight];
    label.backgroundColor = [UIColor whiteColor];
    return label;
}
@end
