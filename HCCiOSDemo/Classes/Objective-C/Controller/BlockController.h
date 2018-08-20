//
//  BlockController.h
//  HCCiOSDemo
//
//  Created by info on 2018/5/18.
//  Copyright © 2018年 hao. All rights reserved.
//
typedef int(^ADD)(int,int);
#import "HCCBaseController.h"

@interface BlockController : HCCBaseController
@property(nonatomic, copy)ADD addBlock;
@end
