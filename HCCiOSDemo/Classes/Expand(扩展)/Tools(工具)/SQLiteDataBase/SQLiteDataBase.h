//
//  SQLiteDataBase.h
//  HCCiOSDemo
//
//  Created by info on 2018/5/17.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

typedef  NS_ENUM(NSInteger, DataBaseType){
    DataBaseWithNative,//系统原生方法
    DataBAseWithFMDB//fmdb框架
};
@interface SQLiteDataBase : NSObject

- (instancetype)initWithType:(DataBaseType)type;

- (void)open;
- (void)createTable;
- (void)addPerson:(Person *)per;
- (void)deletePerson:(Person *)per;
- (void)updatePerson:(Person *)per;
- (NSMutableArray*)selectAllPerson;
- (void)close;
@end
