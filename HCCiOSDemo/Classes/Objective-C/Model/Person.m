//
//  Person.m
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "Person.h"

@implementation Person

// 默认方法都有两个隐式参数，
void eat(id self,SEL sel)
{
    NSLog(@"the person is eating");
}
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(eat)) {
        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), eat, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method workMethod = class_getInstanceMethod(self, @selector(work));
        Method sleepMethod = class_getInstanceMethod(self, @selector(sleep));
        
        method_exchangeImplementations(workMethod, sleepMethod);
        
    });
}

- (void)work{
    NSLog(@"the person is working");
}

- (void)sleep{
    NSLog(@"the person is sleeping");
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);

}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
