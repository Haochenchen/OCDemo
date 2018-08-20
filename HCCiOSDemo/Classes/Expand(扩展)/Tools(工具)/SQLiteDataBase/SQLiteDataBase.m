//
//  SQLiteDataBase.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/17.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "SQLiteDataBase.h"
#import "SQLiteWithFMDB.h"
#import "SQLiteWithNative.h"
#import "Person.h"
#import <sqlite3.h>
#import "FMDB.h"
static sqlite3 *db;//指向数据库指针
static FMDatabase *database;//FMDB数据库
@implementation SQLiteDataBase


- (instancetype)initWithType:(DataBaseType)type{
    SQLiteDataBase *database;
    switch (type) {
        case DataBaseWithNative:
            database = [[SQLiteWithNative alloc] init];
            break;
        case DataBAseWithFMDB:
            database = [[SQLiteWithFMDB alloc] init];

        default:
            break;
    }
    return database;
}

- (void)open{
    
}
- (void)createTable{
    
}
- (void)addPerson:(Person *)per{
    
}
- (void)deletePerson:(Person *)per{
    
}
- (void)updatePerson:(Person *)per{
    
}
- (NSMutableArray*)selectAllPerson{
    return nil;
}
- (void)close{
    
}

@end
