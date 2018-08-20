//
//  SQLiteWithFMDB.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "SQLiteWithFMDB.h"
#import "Person.h"
#import "FMDB.h"
static FMDatabase *database;//FMDB数据库
@implementation SQLiteWithFMDB
//打开数据库
- (void)open{
    //获取Documents路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject ;
    //生成数据库路径
    NSString *filePath = [path stringByAppendingPathComponent:@"person.sqlite"];
    //获取数据库
    database = [FMDatabase databaseWithPath:filePath];
    if ([database open]) {
        NSLog(@"database数据库打开成功");
    }else{
        NSLog(@"database打开数据库失败");
    }
    
}
#pragma mark - 3.增删改查
//创建表格
- (void)createTable{
    //创建表
    BOOL result = [database executeUpdate:@"create table if not exists person (name text primary key not null, city text, age integer)"];
    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
    
}

//添加数据
- (void)addPerson:(Person *)per{
    //添加数据
    BOOL result = [database executeUpdate:@"insert into person (name,city,age) values (?,?,?)",per.name,per.city,@(per.age)];
    if (result) {
        NSLog(@"添加数据成功");
    } else {
        NSLog(@"添加数据失败");
    }
    
}

//删除数据
- (void)deletePerson:(Person *)per{
    //删除数据
    BOOL result = [database executeUpdate:@"delete from person where name = ?",per.name];
    if (result) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败");
    }
    
}

//修改数据
- (void)updatePerson:(Person *)per{
    //修改数据
    BOOL result = [database executeUpdate:@"update person set city = ?,age = ? where name = ?",per.city,@(per.age),per.name];
    if (result) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
    
}

//查询所有数据
- (NSMutableArray*)selectAllPerson{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //执行结果集
    FMResultSet *result = [database executeQuery:@"select * from person"];
    //进行遍历
    while ([result next]) {
        Person *per = [[Person alloc] init];
        per.name = [result stringForColumn:@"name"];
        per.city = [result stringForColumn:@"city"];
        per.age =  [result intForColumn:@"age"];
        [array addObject:per];
    }
    return array;
}

// 关闭数据库
- (void)close{
    if ([database close]) {
        NSLog(@"关闭database数据库成功");
    } else {
        NSLog(@"关闭database数据库失败");
    }
    
}
@end
