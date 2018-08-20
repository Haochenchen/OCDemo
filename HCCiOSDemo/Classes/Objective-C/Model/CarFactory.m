//
//  CarFactory.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "CarFactory.h"
#import "BenzFactory.h"
#import "BMWFactory.h"
@implementation CarFactory

- (instancetype)carWithFactoryType:(CarFactoryType)type{
    CarFactory *factory;
    switch (type) {
        case BenzCarFactory:
            factory = [[BenzFactory alloc] init];
            break;
        case BMWCarFactory:
            factory = [[BMWFactory alloc] init];
        default:
            break;
    }
    return factory;
}

- (Car *)creatCar{
    return nil;
}
@end
