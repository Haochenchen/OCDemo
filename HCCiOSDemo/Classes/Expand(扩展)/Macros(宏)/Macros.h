//
//  Macros.h
//  HCCiOSDemo
//
//  Created by info on 2018/4/26.
//  Copyright © 2018年 hao. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define IS_IPHONE_X      ([[UIScreen mainScreen] bounds].size.height == 812.0f) ? YES : NO //是否是iPhone X
#define Height_NavBar    (IS_IPHONE_X==YES)?88.0f : 64.0f//导航栏+ 电池栏高度 88/ 64
#define Height_TabBar    (IS_IPHONE_X==YES)?83.0f : 49.0f//底部tabbar栏高度  83 / 49
#define SAFE_TOP         (IS_IPHONE_X==YES)?44.0f : 0.0f//顶部安全区域高度 44
#define SAFE_BOTTOM      (IS_IPHONE_X==YES)?34.0f : 0.0f//底部部安全区域高度 34

#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height//屏幕高度
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width//屏幕宽度
#endif /* Macros_h */
