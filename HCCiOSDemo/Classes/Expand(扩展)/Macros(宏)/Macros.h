//
//  Macros.h
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define kStatusBarHeight      [UIApplication sharedApplication].statusBarFrame.size.height //状态栏高度
#define Height_NavBar    (kStatusBarHeight + 44.0f)//导航栏+ 状态栏高度 88/ 64
#define Height_TabBar    (kStatusBarHeight == 44.0f ?83.0f : 49.0f)//底部tabbar栏高度  83 / 49
#define SAFE_TOP         (kStatusBarHeight - 20.0f)//顶部安全区域高度 44
#define SAFE_BOTTOM      [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom//底部安全区域高度

#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height//屏幕高度
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width//屏幕宽度
#endif /* Macros_h */
