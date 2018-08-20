//
//  SaveDataController.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/15.
//  Copyright © 2018年 hao. All rights reserved.
//
#define username @"username"
#define userpassword @"userpassword"
#define path  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#import "SaveDataController.h"
#import "Person.h"
#import "SQLiteDataBase.h"

@interface SaveDataController ()

@property(nonatomic, strong)SQLiteDataBase *personDB;
@property(nonatomic, strong)UIView *textView;
@property(nonatomic, strong)UITextField *nameField;
@property(nonatomic, strong)UITextField *cityField;
@property(nonatomic, strong)UITextField *ageField;
@end

@implementation SaveDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",path);
    
    //初始化数据库
    self.personDB = [[SQLiteDataBase alloc] initWithType:DataBaseWithNative];

    [self setupUI];
}

#pragma mark -- UI布局
//UI布局
- (void)setupUI{
    
    NSMutableArray *array;
    array = [self creatSimpleButton];
    
    array = [self creatSQLiteButton:array];
    
    [self creatTextField];
}

//创建覆盖存取按钮
- (NSMutableArray *)creatSimpleButton{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"偏好设置",@"plist",@"归档解归档"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 50+i;
        [button addTarget:self action:@selector(savaDataWithType:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_NavBar+10);;
        make.height.mas_equalTo(30);
    }];
    return array;
}


//创建SQLite按钮
- (NSMutableArray *)creatSQLiteButton:(NSMutableArray *)arr{
    UIButton *btn = arr [0];
    UILabel *titleLabel = [UILabel hcc_labelWithTitle:@"SQLite" withColor:[UIColor orangeColor]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(10);
    }];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:6];
    NSArray *titles = @[@"增",@"删",@"改",@"查",@"打开",@"关闭"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 60+i;
        [button addTarget:self action:@selector(buttonWithSQLite:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    return array;
}
//创建person属性输入框
- (void )creatTextField{
    
    self.textView = [UIView new];
    self.textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SAFE_BOTTOM-20);
        make.height.mas_equalTo(30);
    }];
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"姓名",@"城市",@"年龄"];
    for (int i = 0; i<titles.count; i++) {
        UITextField *textfield = [UITextField new];
        textfield.tag = 1000 + i;
        textfield.placeholder = titles[i];
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [self.textView addSubview:textfield];
        [array addObject:textfield];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.height.equalTo(self.textView);
    }];
    self.nameField = array[0];
    self.cityField = array[1];
    self.ageField = array[2];
}

#pragma mark -- 按钮方法
- (void)savaDataWithType:(UIButton *)button{
    switch (button.tag) {
        case 50:
            [self dataWithUserDefaults];
            break;
        case 51:
            [self dataWithPlist];
            break;
        case 52:
            [self dataWithKeyedArchiver];
            break;
        default:
            break;
    }
}

- (void)buttonWithSQLite:(UIButton *)button{
    switch (button.tag) {
        case 60:
            [self SQLiteWithAdd];
            break;
        case 61:
            [self SQLiteWithDelete];
            break;
        case 62:
            [self SQLiteWithUpdate];
            break;
        case 63:
            [self SQLiteWithSelect];
            break;
        case 64:
            [self SQLiteWithOpen];
            break;
        case 65:
            [self SQLiteWithClose];
            break;
        default:
            break;
    }
}

#pragma mark -- NSUserDefaults
//偏好设置
- (void)dataWithUserDefaults{
    //获得NSUserDefaults文件
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //保存内容
    [userDefaults setValue:@"sunsan" forKey:username];
    [userDefaults setValue:@"abcd1234" forKey:userpassword];
    //读取内容
    NSString * name = [userDefaults valueForKey:username];
    NSString * password = [userDefaults valueForKey:userpassword];
    
    NSLog(@"username:%@----userpassword:%@",name,password);
    
}

#pragma mark -- plist存储
//plist文件存储
- (void)dataWithPlist{
    NSArray *array =@[@{@"name":@"林五",@"sex":@"男"},@{@"name":@"苏三",@"sex":@"女"}];
    //设置文件名
    NSString *fileName = [path stringByAppendingPathComponent:@"students.plist"];
    //写入文件
    [array writeToFile:fileName atomically:YES];
    //读取
    NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
    
    NSLog(@"students.plist----%@",result);
}

#pragma mark -- 归档解归档
- (void)dataWithKeyedArchiver{
    Person *per = [Person new];
    per.name = @"王明";
    per.age = 26;
    per.city = @"北京";
    //设置文件名
    NSString *fileName = [path stringByAppendingPathComponent:@"person.archiver"];
    //进行归档
    [NSKeyedArchiver archiveRootObject:per toFile:fileName];
    //进行解归档
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    NSLog(@"Person----name:%@,age:%ld,city:%@",person.name,person.age,person.city);
}

#pragma mark -- SQLite
- (void)SQLiteWithAdd{
    Person *per = [Person new];
    per.name = self.nameField.text;
    per.age = self.ageField.text.integerValue;
    per.city = self.cityField.text;
    [self.personDB createTable];
    [self.personDB addPerson:per];
}

- (void)SQLiteWithDelete{
    Person *per = [Person new];
    per.name = self.nameField.text;
    per.age = self.ageField.text.integerValue;
    per.city = self.cityField.text;
    [self.personDB deletePerson:per];
}

- (void)SQLiteWithUpdate{
    Person *per = [Person new];
    per.name = self.nameField.text;
    per.age = self.ageField.text.integerValue;
    per.city = self.cityField.text;
    [self.personDB updatePerson:per];
}

- (void)SQLiteWithSelect{
    NSMutableArray *array = [self.personDB selectAllPerson];
    if (array.count != 0) {
        for (Person *per in array) {
            NSLog(@"Person----name:%@,age:%ld,city:%@",per.name,per.age,per.city);
        }
    }else{
        NSLog(@"没有查到数据");
    }
    
}

- (void)SQLiteWithOpen{
    [self.personDB open];
}

- (void)SQLiteWithClose{
    [self.personDB close];
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
