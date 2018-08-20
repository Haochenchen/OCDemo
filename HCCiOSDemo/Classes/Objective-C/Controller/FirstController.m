//
//  FirstController.m
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "FirstController.h"
#import "Student.h"
#import "Person.h"
#import "Car.h"
#import "CarFactory.h"
@interface FirstController ()

/** 学生*/
@property(nonatomic, strong)Student *student;
@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    //测试Properties
    [self testProperties];
    */
    
    /*
    //测试KVC和KVO
    [self testKVC];
    */
    
    /*
    //runtime应用
    [self runtimeMethod];
     */
    
    /*
    //内存管理
    [self memoryMan];
    */
    
    [self factoryModel];
}

#pragma mark -- 属性
- (void)testProperties{
    Student *stu = [Student new];
    
//    [stu setName:@"liming"];
    stu.name = @"property";
    NSLog(@"propertiestest---%@",stu.name);
}
#pragma mark -- KVC和KVO
- (void)testKVC{
    Student *stu = [Student new];
    //通过键值对来为对象属性赋值，主要为私有属性赋值
    [stu setValue:@"KVC" forKey:@"name"];
    //通过键值对取得对象属性的值
    NSString *name = [stu valueForKey:@"name"];
    NSLog(@"KVCtest---%@",name);
    
    //如果对象A的属性是对象B,要为对象B的属性赋值可以通过键值对路径
    _student = [Student new];
    [self setValue:@"KVCPath" forKeyPath:@"student.name"];
    //通过键值对路径获取对象B属性的值
    NSString *pathName = [self valueForKeyPath:@"student.name"];
    NSLog(@"KVCPathTest---%@",pathName);
    
    //可以通过字典进行赋值，将字典转换成模型
    NSDictionary *dic = @{
                          @"name":@"luna",
                          @"city":@"Beijing",
                          };
    Person *p = [Person new];
    [p setValuesForKeysWithDictionary:dic];
    NSLog(@"KVCDicTest---name:%@,city:%@",p.name,p.city);
    
    //KVO监听
    [_student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    _student.name = @"KVO";
    
}

//KVO监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"KVO---keyPath:%@,object:%@,change:%@",keyPath,object,change);
}

#pragma mark -- runtime应用
- (void)runtimeMethod{
    /*
     [self associateObject];
     */
    
    /*
     [self encodeAndDecode];
     */
    
    /*
     [self modelWithDic];
     */
    
    [self methodSwizzling];
    
    
    
}
//对象关联
- (void)associateObject{
    NSObject *objc =[NSObject new];
    objc.name = @"object";
    NSLog(@"associateObject---%@",objc.name);
}
//解归档
- (void)encodeAndDecode{
    Person *per = [Person new];
    per.name = @"小黄";
    per.age = 26;
    per.city = @"wuhan";
    NSString *personPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Person.archiver"];
    [NSKeyedArchiver archiveRootObject:per toFile:personPath];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:personPath]) {
        Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:personPath];
        NSLog(@"Person--name:%@,age:%ld,city:%@",person.name,person.age,person.city);
    }else{
        NSLog(@"归档失败");
    }
}
 //字典转模型
- (void)modelWithDic{
    NSDictionary *dic = @{@"name":@"小黄",@"city":@"wuhan",@"age":@"26"};
    Person *person = [Person modelWithDict:dic];
    NSLog(@"Person--name:%@,age:%ld,city:%@",person.name,person.age,person.city);
}
//方法加载
- (void)methodSwizzling{
    Person *per = [Person new];
    [per work];
    [per performSelector:@selector(eat)];
}

#pragma mark -- MRC和ARC
- (void)memoryMan{
    /*
     [self testMRC];
     */
    
   
    [self testARC];
}
//MRC使用
- (void)testMRC{
    Student *stu = [[Student alloc] init];
}
//ARC使用
- (void)testARC{
    id __strong obj = [[NSObject alloc] init];
    NSLog(@"obj引用计数--%@",[obj valueForKey:@"retainCount"]);
    id __strong newObj = obj;
    NSLog(@"obj引用计数--%@",[obj valueForKey:@"retainCount"]);
    
    id __weak obj1 = [[NSObject alloc] init];
    NSLog(@"obj1引用计数--%@",[obj1 valueForKey:@"retainCount"]);
}

//工厂模式
- (void)factoryModel{
    CarFactory *factory = [[CarFactory alloc] carWithFactoryType:BenzCarFactory];
    Car *car = [factory creatCar];
    [car carName];
}
- (void)dealloc{
    [_student removeObserver:self forKeyPath:@"name"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
