//
//  MapController.m
//  HCCiOSDemo
//
//  Created by info on 2018/6/13.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "MapController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "HCCAnnotation.h"

#define path  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#define annoID @"annotation"

@interface MapController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property(nonatomic, strong)MKMapView *mapView;
@property(nonatomic, strong)CLLocationManager *locationManger;
@property(nonatomic, strong) CLGeocoder *geocoder;

@property(nonatomic, strong)UITextField *addressField;
@property(nonatomic, strong)UITextField *longitudeField;
@property(nonatomic, strong)UITextField *latitudeField;

@property(nonatomic, strong)NSMutableArray *annotations;
@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //判断定位功能是否可用
    if ([CLLocationManager locationServicesEnabled]) {
        //开始定位
        [self.locationManger startUpdatingLocation];
        //开始监听设备朝向
        [self.locationManger startUpdatingHeading];
        //区域监听
        [self startRegion];
        
    }else{
        NSLog(@"定位功能不可用");
    }
    
    self.annotations = [[NSMutableArray alloc] initWithCapacity:3];
    
    [self setupUI];
    
}


//区域监听
- (void)startRegion{
    //设置区域中心
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.894066, 116.428677);
    //设置区域半径
    CLLocationDistance radius = 100;
    //初始区域对象
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:radius identifier:@"公司"];
    //请求监听区域
    [self.locationManger requestStateForRegion:region];
}

#pragma mark -- UI布局
//页面布局
- (void)setupUI{
    
    NSMutableArray *array;
    
    array = [self setupTextField];
    
    [self setupButtons];
}

//创建经纬度输入框
- (NSMutableArray *)setupTextField{
    
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:2];
    NSArray *titles = @[@"经度",@"纬度"];
    for (int i = 0; i<titles.count; i++) {
        UITextField *textfield = [UITextField new];
        textfield.tag = 1000 + i;
        textfield.placeholder = titles[i];
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:textfield];
        [array addObject:textfield];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressField.mas_bottom).offset(10);
        make.height.equalTo(self.addressField);
    }];
    
    self.longitudeField = array[0];
    self.latitudeField = array[1];
    
    return array;
}

//创建按钮
- (void)setupButtons{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSArray *titles = @[@"地理编码",@"反编码",@"添加大头针",@"移除大头针"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton hcc_buttonWithTitle:titles[i] withColor:[UIColor greenColor]];
        button.tag = 50+i;
        [button addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [array addObject:button];
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.latitudeField.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark -- MKMapViewDelegate
//调用非常频繁,不断监测用户的当前位置;每次调用,都会把用户的最新位置(userLocation参数)传进来
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placekmark = [placemarks firstObject];
        userLocation.title = placekmark.name;
        userLocation.subtitle = placekmark.locality;
        
    }];
    //设置地图的中心地点
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    //设置地图的显示区域
    self.mapView.region = MKCoordinateRegionMake(self.mapView.centerCoordinate, MKCoordinateSpanMake(0.1, 0.1));
}
//地图的显示区域即将发生改变的时候调用
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}
//地图的显示区域已经发生改变的时候调用
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // 判断annotation的类型
    if (![annotation isKindOfClass:[MKPointAnnotation class]]) return nil;
    //创建一个系统大头针对象
    MKPinAnnotationView * annotationView= (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annoID];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annoID];
    }
    //设置显示的图片,MKPinAnnotationView子类下无作用
    annotationView.image = [UIImage imageNamed:@"annotation"];
    //设置大头针颜色
    annotationView.pinColor = MKPinAnnotationColorGreen;
    //大头针第一次显示时是否从天而降
    annotationView.animatesDrop = YES;
    //设置是否显示标注
    annotationView.canShowCallout = YES;
    //设置标注的偏移量
    annotationView.calloutOffset = CGPointMake(-1, 0);
    //设置大头针是否可拖动
    annotationView.draggable = NO;

    //创建了两个view
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    view1.backgroundColor=[UIColor redColor];
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    view2.backgroundColor=[UIColor blueColor];
    //设置左右辅助视图
    annotationView.leftCalloutAccessoryView=view1;
    annotationView.rightCalloutAccessoryView=view2;

    return annotationView;
}

//选中了标注的处理事件
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"选中了标注");
}
//取消了标注
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"取消了标注");
}

#pragma mark -- CLLocationManagerDelegate
//更新位置时调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"更新定位了");
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;//经纬度
    CGFloat altitude = location.altitude;//海拔
    CGFloat horizontalAccuracy = location.horizontalAccuracy; // 水平精度,如果值是复数代表无效
    CGFloat verticalAccuracy = location.verticalAccuracy; // 垂直精度,如果值是复数代表无效
    CGFloat course = location.course;//方向
    CGFloat speed = location.speed;//速度
    
    
}
//更新朝向时调用
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
}
//进入区域时调用
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"进入%@附近100米",region.identifier);
}
//离开区域时调用
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
   NSLog(@"离开%@附近100米",region.identifier);
}
//判断是否在某个区域时的状态
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    NSLog(@"%zd", state);
}
//授权状态改变时调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户未决定(请求授权之前的状态)");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"访问受限制");
            break;
        case kCLAuthorizationStatusDenied:  // 定位关闭时和对此APP授权为never时调用
            if([CLLocationManager locationServicesEnabled]){
                // 定位服务开启了
                NSLog(@"永不或者不允许Not Allow");
            } else {
                NSLog(@"定位服务关闭了");
                // 先允许定位，然后关闭掉定位服务，再开始定位startUpdatingLocation时系统会弹出设置定位服务打开弹框
            }
            break;
        case kCLAuthorizationStatusAuthorizedAlways://
            NSLog(@"始终：前后台");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse://
            NSLog(@"应用使用期间：前台");
            break;
        default:
            break;
    }
}

#pragma mark -- 按钮方法

- (void)buttonActions:(UIButton *)button{
    switch (button.tag) {
        case 50:
            [self getCoordinateByAddress];
            break;
        case 51:
            [self getAddress];
            break;
        case 52:
            [self addAnnotation];
            break;
        case 53:
            [self removeAnnotation];
            break;
        default:
            break;
    }
}

//地理编码
-(void)getCoordinateByAddress{
    [self.geocoder geocodeAddressString:self.addressField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        
        //以下为CLPlacemark中包含的信息
        CLLocation *location = placemark.location;//位置
        CLRegion *region = placemark.region;//区域
        NSTimeZone * timezone = placemark.timeZone;//时区
        NSDictionary *addressDic = placemark.addressDictionary;//详细地址信息字典
        
        NSString *name = placemark.name;//地名
        NSString *thoroughfare = placemark.thoroughfare;//街道
        NSString *subThoroughfare = placemark.subThoroughfare; //街道相关信息，例如门牌等
        NSString *locality = placemark.locality; // 城市
        NSString *subLocality = placemark.subLocality; // 城市相关信息，例如标志性建筑
        NSString *administrativeArea = placemark.administrativeArea; // 州
        NSString *subAdministrativeArea = placemark.subAdministrativeArea; //其他行政区域信息
        NSString *postalCode = placemark.postalCode; //邮编
        NSString *ISOcountryCode = placemark.ISOcountryCode; //国家编码
        NSString *country = placemark.country; //国家
        NSString *inlandWater = placemark.inlandWater; //水源、湖泊
        NSString *ocean = placemark.ocean; // 海洋
        NSArray *areasOfInterest = placemark.areasOfInterest; //关联的或利益相关的地标
        
        [self showTheMessage:placemark];
    }];
}

//反地理编码
-(void)getAddress{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.latitudeField.text.doubleValue
              longitude:self.longitudeField.text.doubleValue];
    [self.geocoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            CLPlacemark *placemark = [placemarks firstObject];
                            
                            [self showTheMessage:placemark];
                        }];
    
}


- (void)addAnnotation{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.latitudeField.text.doubleValue
               longitude:self.longitudeField.text.doubleValue];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = @"大头针";
    annotation.subtitle = @"look here!";
    annotation.coordinate = location.coordinate;
    [self.mapView addAnnotation:annotation];
    
    [self.annotations addObject:annotation];
}

- (void)removeAnnotation{
    
    [self.mapView removeAnnotations:self.annotations];
}

//输入框显示详细地理信息
- (void)showTheMessage:(CLPlacemark *)placemark{
    self.addressField.text = placemark.name;
    self.longitudeField.text =[NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
    self.latitudeField.text =[NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
}

#pragma mark -- lazyload
//地图视图
- (MKMapView *)mapView{
    if (!_mapView) {
        //初始化地图视图
        _mapView = [[MKMapView alloc] init];
        //设置代理
        _mapView.delegate = self;
        //设置地图显示类型
        _mapView.mapType = MKMapTypeStandard;
        //设置用户定位追踪方式
        _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
        //设置是否可缩放
        _mapView.zoomEnabled = YES;
        //设置是否可滚动
        _mapView.scrollEnabled = YES;
        //设置是否可旋转
        _mapView.rotateEnabled = YES;
        //iOS9之后
        if(@available(iOS 9.0, *)){
        //设置是否显示指南针
        _mapView.showsCompass = YES;
        //设置是否显示比例尺
        _mapView.showsScale = YES;
        //设置是否显示交通
        _mapView.showsTraffic = YES;
        //设置是否显示建筑
        _mapView.showsBuildings = YES;
        }
        //设置是否显示用户位置
        _mapView.showsUserLocation = YES;
        
        [self.view addSubview:_mapView];
        [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(Height_NavBar);
            make.height.equalTo(self.view).multipliedBy(0.5);
        }];
    }
    return _mapView;
}

- (UITextField *)addressField{
    if (!_addressField) {
        _addressField = [[UITextField alloc] init];
        _addressField.placeholder = @"位置";
        _addressField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_addressField];
        [_addressField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mapView.mas_bottom).offset(10);
            make.centerX.equalTo(self.view);
            make.width.equalTo(self.view).offset(-20);
            make.height.mas_equalTo(30);
        }];
        
    }
    return _addressField;
}

//编码类
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

//定位管理类
- (CLLocationManager *)locationManger{
    if (!_locationManger) {
        //初始化CLLocationManager对象
        _locationManger = [[CLLocationManager alloc] init];
        //设置代理
        _locationManger.delegate = self;
        //设置定位精确度
        _locationManger.desiredAccuracy = kCLLocationAccuracyBest;
        //每隔多少米定位一次
        _locationManger.distanceFilter = 100;
        
        if (@available(iOS 8.0, *)) {
            // 请求前台定位授权
            [_locationManger requestWhenInUseAuthorization];
            if (@available(iOS 9.0, *)) {
                // iOS9.0+ 设置允许后台位置更新
                _locationManger.allowsBackgroundLocationUpdates = YES;
            }
        }
        
    }
    return _locationManger;
}

#pragma mark -- dealloc
- (void)dealloc{
    //停止定位
    [self.locationManger stopUpdatingLocation];
    //停止监听设备朝向
    [self.locationManger stopUpdatingHeading];
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
