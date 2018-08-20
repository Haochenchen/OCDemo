//
//  CarFactory.h
//  HCCiOSDemo
//
//  Created by info on 2018/5/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

typedef NS_ENUM(NSInteger, CarFactoryType){
    BenzCarFactory,
    BMWCarFactory
};

@interface CarFactory : NSObject

- (instancetype)carWithFactoryType:(CarFactoryType)type;
- (Car *)creatCar;
@end
