//
//  AppDelegate.m
//  HCCiOSDemo
//
//  Created by info on 2018/4/25.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    Class rootClass = NSClassFromString(@"HCCTabBarController");
    UIViewController *rootVC = [[rootClass alloc] init];
    self.window.rootViewController = rootVC;
    

    if (@available(iOS 10.0, *)) {
    //iOS10之后的注册方法
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    }else{
        //iOS8~iOS10的注册方法
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    //注册远端消息通知获取device token
    [application registerForRemoteNotifications];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"my device token---%@",deviceTokenStr);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    //收到推送的内容
    UNNotificationContent *content = notification.request.content;
    // 推送消息的标题
    NSString *title = content.title;
    // 推送消息的副标题
    NSString *subtitle = content.subtitle;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]){
        
    }else if ([notification.request.trigger isKindOfClass:[UNTimeIntervalNotificationTrigger class]]) {
        NSLog(@"%@",title);
    }else if ([notification.request.trigger isKindOfClass:[UNCalendarNotificationTrigger class]]){
        NSLog(@"%@",subtitle);
    }
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    //收到推送的内容
    UNNotificationContent *content = response.notification.request.content;
    // 推送消息的标题
    NSString *title = content.title;
    // 推送消息的副标题
    NSString *subtitle = content.subtitle;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]){
        
    }else if ([response.notification.request.trigger isKindOfClass:[UNTimeIntervalNotificationTrigger class]]) {
        NSLog(@"%@",title);
    }else if ([response.notification.request.trigger isKindOfClass:[UNCalendarNotificationTrigger class]]){
        NSLog(@"%@",subtitle);
    }
    completionHandler();
}



@end
