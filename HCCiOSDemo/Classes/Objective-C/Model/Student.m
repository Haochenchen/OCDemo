//
//  Student.m
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "Student.h"
#import "Car.h"
@implementation Student

//@synthesize name = _name;
//@dynamic name;
- (instancetype)init{
    if (self = [super init]) {
        //内存管理
        [self memoryManager];
    }
    return self;
}

/*
- (void)setName:(NSString *)name{
    _name = name;
}
- (NSString *)name{
    return _name;
}
*/

//内存管理
- (void)memoryManager{
    
    /*
    [self refCount];
    */
    
    [self autoPool];
}

//引用计数
- (void)refCount{
    Car *car = [[Car alloc] init];
    NSLog(@"初始引用计数--%ld",car.retainCount);
    [car retain];
    NSLog(@"retain后引用计数--%ld",car.retainCount);
    [car release];
    NSLog(@"release后引用计数--%ld",car.retainCount);
    [car release];
    //当对象销毁后需要将指向对象的指针设为nil，避免产生野指针
    car = nil;
}

//自动释放池
- (void)autoPool{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    Car *car = [[Car alloc] init];
    NSLog(@"初始引用计数--%ld",car.retainCount);
    [car retain];
    NSLog(@"retain后引用计数--%ld",car.retainCount);
    [car autorelease];
    NSLog(@"autorelease后引用计数--%ld",car.retainCount);
    [car release];
    NSLog(@"release后引用计数--%ld",car.retainCount);
    
    //销毁释放池
    [pool release];

}

@end
