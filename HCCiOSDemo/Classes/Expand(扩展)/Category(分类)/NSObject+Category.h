//
//  NSObject+Category.h
//  HCCiOSDemo
//
//  Created by info on 2018/5/7.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

@property(nonatomic, copy) NSString *name;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
