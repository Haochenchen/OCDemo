//
//  NotificationController.m
//  HCCiOSDemo
//
//  Created by info on 2018/6/11.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "NotificationController.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
@interface NotificationController ()
@end

@implementation NotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}


- (void)setupUI{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"时间间隔推送",@"定时推送",@"地点推送"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 50+i;
        [button addTarget:self action:@selector(buttonWithType:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(Height_NavBar+10);
        make.height.mas_equalTo(30);
    }];
}

- (void)buttonWithType:(UIButton *)button{
    switch (button.tag) {
        case 50:
            [self timeNotification];
            break;
        case 51:
            [self calendarNotification];
            break;
        case 52:
            [self localNotification];
            break;
        default:
            break;
    }
}

- (void)timeNotification{
    if (@available(iOS 10.0, *)) {
    // 1、创建通知内容，注：这里得用可变类型的UNMutableNotificationContent，否则内容的属性是只读的
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    // 标题
    content.title = @"时间推送";
    // 次标题
    content.subtitle = @"15秒后推送";
    // 内容
    content.body = @"时间间隔推送消息测试";
    
    // app显示通知数量的角标
    content.badge = [NSNumber numberWithInteger:1];
    
    // 通知的提示声音，这里用的默认的声音
    content.sound = [UNNotificationSound defaultSound];
    
    // 2、创建通知触发
    //UNTimeIntervalNotificationTrigger : 在一定时间后触发，如果设置重复的话，timeInterval不能小于60
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:15 repeats:NO];
    
    // 3、创建通知请求
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"timeInterval" content:content trigger:trigger];
    
    // 4、将请求加入通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"已成功加推送%@",notificationRequest.identifier);
        }
    }];
}
}


- (void)calendarNotification{
    
    if (@available(iOS 10.0, *)) {
    // 1、创建通知内容，注：这里得用可变类型的UNMutableNotificationContent，否则内容的属性是只读的
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    // 标题
    content.title = @"定时推送";
    // 次标题
    content.subtitle = @"16点";
    // 内容
    content.body = @"每周三的下午4点推送消息";
    
    // app显示通知数量的角标
    content.badge = [NSNumber numberWithInteger:1];
    
    // 通知的提示声音，这里用的默认的声音
    content.sound = [UNNotificationSound defaultSound];
    
    // 2、创建通知触发
    //每周三的16点触发
    NSDateComponents * components = [[NSDateComponents alloc] init];
    components.weekday = 4;
    components.hour = 16;
    //UNCalendarNotificationTrigger : 在某天某时触发，可重复
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    
    // 3、创建通知请求
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"calendar" content:content trigger:trigger];
    
    // 4、将请求加入通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"已成功加推送%@",notificationRequest.identifier);
        }
    }];
    }
}

- (void)localNotification{
    if (@available(iOS 10.0, *)) {
        // 1、创建通知内容，注：这里得用可变类型的UNMutableNotificationContent，否则内容的属性是只读的
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        // 标题
        content.title = @"地点切换推送";
        // 次标题
        content.subtitle = @"雍贵中心";
        // 内容
        content.body = @"到达公司附近，可以打卡了";
        
        // app显示通知数量的角标
        content.badge = [NSNumber numberWithInteger:1];
        
        // 通知的提示声音，这里用的默认的声音
        content.sound = [UNNotificationSound defaultSound];
        
        // 2、创建通知触发
        //首先要导入#import <CoreLocation/CoreLocation.h>
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.89412, 116.42864);
        CLRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:500 identifier:@"公司"];
        //UNLocationNotificationTrigger : 地理位置的一种通知，当用户进入或离开一个地理区域来通知
        UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];
        
        // 3、创建通知请求
        UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"location" content:content trigger:trigger];
        
        // 4、将请求加入通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"已成功加推送%@",notificationRequest.identifier);
            }
        }];
    }
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
