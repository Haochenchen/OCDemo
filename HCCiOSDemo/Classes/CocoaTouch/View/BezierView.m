//
//  BezierView.m
//  HCCiOSDemo
//
//  Created by info on 2018/6/27.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "BezierView.h"

@implementation BezierView

/*
//画矩形
- (void)drawRect:(CGRect)rect {
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    //创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(60, 60, 70, 70)];
    //设置线条宽度
    path.lineWidth = 5.0;
    //端点样式
    path.lineCapStyle  = kCGLineCapRound;
    //拐角样式
    path.lineJoinStyle = kCGLineCapRound;
//    //根据坐标填充颜色
//    [path fill];
    //根据坐标连线
    [path stroke];
}
*/

/*
//画圆形或者椭圆
- (void)drawRect:(CGRect)rect{
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    //创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(60, 60, 70, 70)];
    //根据坐标连线
    [path stroke];
}
*/

/*
//画扇形
- (void)drawRect:(CGRect)rect{
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    //创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(100, 100)];
    //设置路径
    [path addArcWithCenter:CGPointMake(100, 100)
                    radius:66.f
                startAngle:0
                  endAngle:M_PI_2*3
                 clockwise:YES];
    //闭合路径
    [path closePath];
    //填充颜色
    [path fill];
}
*/

/*
//画不规则图形
-(void)drawRect:(CGRect)rect{
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    //创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起始点
    [path moveToPoint:CGPointMake(20, 20)];
    //添加直线
    [path addLineToPoint:CGPointMake(20, 150)];
    [path addLineToPoint:CGPointMake(100, 130)];
    [path addLineToPoint:CGPointMake(150, 60)];
    //闭合路径
    [path closePath];
    //根据坐标连线
    [path stroke];
}
*/

/*
//画弧
- (void)drawRect:(CGRect)rect{
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    //创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置路径
    [path addArcWithCenter:CGPointMake(100, 100)
                    radius:66.f
                startAngle:0
                  endAngle:M_PI_2
                 clockwise:YES];
    
    //根据坐标连线
    [path stroke];
}
*/

//画贝塞尔曲线
- (void)drawRect:(CGRect)rect{
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    //创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起始点
    [path moveToPoint:CGPointMake(0, 100)];
    //设置路径
//    [path addQuadCurveToPoint:CGPointMake(200, 100) controlPoint:CGPointMake(100, 0)];
    //三阶贝塞尔曲线
    [path addCurveToPoint:CGPointMake(200, 100) controlPoint1:CGPointMake(50, 50) controlPoint2:CGPointMake(150, 150)];
    //根据坐标连线
    [path stroke];
    
}


@end
