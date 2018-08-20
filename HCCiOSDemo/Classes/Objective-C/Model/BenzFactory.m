//
//  BenzFactory.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "BenzFactory.h"
#import "Benz.h"
@implementation BenzFactory


- (Car *)creatCar{
    return [[Benz alloc] init];
}
@end
