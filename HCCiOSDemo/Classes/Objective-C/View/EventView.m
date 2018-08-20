//
//  EventView.m
//  HCCiOSDemo
//
//  Created by info on 2018/5/21.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "EventView.h"

@implementation EventView

- (instancetype)init{
    if (self = [super init]) {
        UIButton *button = [UIButton hcc_buttonWithTitle:@"button" withColor:[UIColor greenColor]];
        button.backgroundColor = [UIColor magentaColor];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.equalTo(self).multipliedBy(0.5);
        }];
    }
    return self;
}

#pragma mark -- 触摸方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸开始--touches:%@,event:%@",touches,event);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"开始移动--touches:%@,event:%@",touches,event);
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸结束--touches:%@,event:%@",touches,event);
}
//只有在程序强制退出或者来电时才会调用
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"触摸取消--touches:%@,event:%@",touches,event);
}

//利用代理变量执行方法
- (void)buttonClick{
    if ([_delegate respondsToSelector:@selector(sendValue:)]) {
        [_delegate sendValue:@"点击了button"];
    }
}

@end
