//
//  NSObject+Category.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/7.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "NSObject+Category.h"


@implementation NSObject (Category)


- (void)setName:(NSString *)name{
    //关联对象
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name{
    //获取关联的值
    return objc_getAssociatedObject(self, @"name");
}

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    id model = [[self alloc] init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0 ; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //截取掉变量前的_
        ivarName = [ivarName substringFromIndex:1];
        id value = dict[ivarName];
        [model setValue:value forKeyPath:ivarName];
    }
    free(ivars);
    return model;
}

@end
