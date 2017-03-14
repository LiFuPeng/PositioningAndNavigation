//
//  ViewController.m
//  PositioningAndNavigation
//
//  Created by 蜗牛 on 2017/3/6.
//  Copyright © 2017年 关于蜗牛：一枚九零后码农  蜗牛-----QQ:3197857495-----李富棚  个人微信：woniu1308822159  微信公众号：woniuxueios  简书：蜗牛学IOS  地址：http://www.jianshu.com/users/a664a9fcb096/latest_articles  简书专题：蜗牛学IOS  地址：http://www.jianshu.com/collection/bfcf49bf5d27    GitHub:https://github.com/LiFuPeng     开源中国：https://my.oschina.net/SnailLi  蜗牛. All rights reserved.
//

#import "ViewController.h"

#import <MapKit/MapKit.h> //地图框架
#import <CoreLocation/CoreLocation.h> //定位和编码框架

@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager; //定位管理器

@property (nonatomic, strong) CLGeocoder *geocoder; //创建一个地理编码器，来实现编码和反编码
@property (nonatomic , strong) MKMapView * PYMapView;
@end

@implementation ViewController

- (CLLocationManager *)locationManager

{
    
    if (!_locationManager) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        
    }
    
    return _locationManager;
    
}

- (CLGeocoder *)geocoder

{
    
    if (!_geocoder) {
       
        self.geocoder = [[CLGeocoder alloc] init];
        
    }
    
    return _geocoder;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocationUpdate];
   
    self.PYMapView.mapType = MKMapTypeStandard;//选择显示地图的样式
   
    self.PYMapView.delegate = self;//指定代理
    
    /*
     10.
     *[self.PYMapView setShowsUserLocation:YES];//显示用户位置的小圆点
     
     */
}

#pragma mark --- 开始定位

- (void)startLocationUpdate

{
   
    //判断用户在设置里面是否打开定位服务
   
    if (![CLLocationManager locationServicesEnabled]) {
       
        NSLog(@"请在设置里面打开定位服务");
       
    }
   
    else{
      
        
        
        //获取用户对应用的授权
     
        if ([ CLLocationManager authorizationStatus]== kCLAuthorizationStatusNotDetermined) {
            NSLog(@"请求授权");
        
            [self.locationManager requestAlwaysAuthorization];
            
        }
        
        else{
           
            //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
           
            self.PYMapView.userTrackingMode = MKUserTrackingModeFollow;//即可以在显示地图的时候定位到用户的位置
           
            self.locationManager.delegate = self;
           
            //设置定位的经纬度精度
            
            _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            
            //设置定位频率，每隔多少米定位一次
           
            CLLocationDistance distance = 10.0;
           
            _locationManager.distanceFilter = distance;
            
            //开始定位
           
            [self.locationManager startUpdatingLocation];
            
        }
       
    }
    
}

#pragma mark --- CLLocationDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations

{
   
    /*
     51.
     *locations  数组里面存储CLLoction对象， 一个对象代表一个地址
     52.
     *
     53.
     *location 中存储  经度 coordinate.longitude、纬度 coordinate.latitude、航向 location.course、速度 location.speed、海拔 location.altitude
     54.
     */
    
    CLLocation *location = locations.firstObject;
   
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
   
//    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
   
    [self.locationManager stopUpdatingLocation];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
