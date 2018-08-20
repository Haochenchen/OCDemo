//
//  Student.h
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

{
    @private
    __strong NSString *_name;
}
/*
{
    //ivar
    NSString *_name;
}
// setter
- (void)setName:(NSString *)name;
// getter
- (NSString*)name;
*/

@property(nonatomic, copy)NSString *name;
@end
