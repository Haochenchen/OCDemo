//
//  CustomLayer.m
//  HCCiOSDemo
//
//  Created by info on 2018/7/12.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer


- (void)drawInContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -100);
    
    UIImage *image = [UIImage imageNamed:@"annotation"];
    
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, 100, 100), image.CGImage);
    
    CGContextRestoreGState(ctx);  
}
@end
