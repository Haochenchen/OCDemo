//
//  EventView.h
//  HCCiOSDemo
//
//  Created by info on 2018/5/21.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理的创建
@protocol EventViewDelegate<NSObject>
@optional
//代理方法
- (void)sendValue:(NSString *)value;
@end


@interface EventView : UIView
//声明协议变量
@property(nonatomic, weak)id<EventViewDelegate> delegate;
@end
