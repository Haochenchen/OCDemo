//
//  Person.h
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property(nonatomic, copy)NSString *name;//姓名
@property(nonatomic, copy)NSString *city;//城市
@property(nonatomic, assign)NSInteger age;//年龄

- (void)work;//工作
- (void)sleep;//睡觉
@end
