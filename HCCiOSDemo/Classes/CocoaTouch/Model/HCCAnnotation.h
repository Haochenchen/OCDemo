//
//  HCCAnnotation.h
//  HCCiOSDemo
//
//  Created by info on 2018/6/19.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface HCCAnnotation : NSObject<MKAnnotation>
/** 坐标位置 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;

@end
