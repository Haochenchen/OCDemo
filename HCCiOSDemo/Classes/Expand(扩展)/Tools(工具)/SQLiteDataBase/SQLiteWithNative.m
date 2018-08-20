//
//  SQLiteWithNative.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "SQLiteWithNative.h"
#import "Person.h"
#import <sqlite3.h>

static sqlite3 *db;//指向数据库指针

@implementation SQLiteWithNative

//打开数据库
- (void)open{
    //获取Documents路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject ;
    //生成数据库路径
    NSString *filePath = [path stringByAppendingPathComponent:@"person.sqlite"];
    //判断数据库是否为空，不为空说明已经打开
    if (db != nil) {
        return;
    }else{
        //打开数据库，如果不存在则创建一个
        int result = sqlite3_open([filePath UTF8String], &db);
        if (result == SQLITE_OK) {
            NSLog(@"db数据库打开成功");
        }else{
            NSLog(@"db数据库打开失败");
        }
        
    }
    
}
#pragma mark - 3.增删改查
//创建表格
- (void)createTable{
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"create table if not exists person (name text primary key not null, city text, age integer)"];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    //3.sqlite语句是否执行成功
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
    
}

//添加数据
- (void)addPerson:(Person *)per{
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"insert into person(name,city,age) values ('%@','%@','%ld')",per.name,per.city,per.age];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"添加数据成功");
    } else {
        NSLog(@"添加数据失败");
    }
    
}

//删除数据
- (void)deletePerson:(Person *)per{
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"delete from person where name = '%@'",per.name];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败%s",error);
    }
    
}

//修改数据
- (void)updatePerson:(Person *)per{
    //1.sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"update person set city = '%@',age = '%ld' where name = '%@'",per.city,per.age,per.name];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
    
}

//查询所有数据
- (NSMutableArray*)selectAllPerson{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"select * from person"];
    //2.伴随指针
    sqlite3_stmt *stmt = NULL;
    //3.预执行sqlite语句
    int result = sqlite3_prepare(db, sqlite.UTF8String, -1, &stmt, NULL);//第4个参数是一次性返回所有的参数,就用-1
    if (result == SQLITE_OK) {
        NSLog(@"查询成功");
        //4.执行n次
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Person *per = [[Person alloc] init];
            //从伴随指针获取数据,第0列
            per.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)] ;
            //从伴随指针获取数据,第1列
            per.city = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] ;
            //从伴随指针获取数据,第2列
            per.age = sqlite3_column_int(stmt, 2);
            [array addObject:per];
        }
    } else {
        NSLog(@"查询失败");
    }
    //5.关闭伴随指针
    sqlite3_finalize(stmt);
    return array;
}

// 关闭数据库
- (void)close{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"db数据库关闭成功");
        // 将数据库的指针置空
        db = nil;
    } else {
        NSLog(@"db数据库关闭失败");
    }
    
}
@end
