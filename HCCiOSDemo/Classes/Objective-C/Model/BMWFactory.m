//
//  BMWFactory.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "BMWFactory.h"
#import "BMW.h"
@implementation BMWFactory

- (Car *)creatCar{
    return [[BMW alloc] init];
}
@end
