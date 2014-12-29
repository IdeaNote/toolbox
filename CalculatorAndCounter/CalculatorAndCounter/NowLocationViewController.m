//
//  NowLocationViewController.m
//  ToolBox
//
//  Created by Junji on 2014/06/15.
//  Copyright (c) 2014年 Junji Yamamoto. All rights reserved.
//

#import "NowLocationViewController.h"

@interface NowLocationViewController ()

@end

@implementation NowLocationViewController

#pragma mark - 読み込み
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //***** 画面サイズ取得設定
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,320,480)];
        mapView.showsUserLocation = YES;
        
        [self.view addSubview:mapView];
        
    } else {
        
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0,0,320,400)];
        mapView.showsUserLocation = YES;
        
        [self.view addSubview:mapView];
        
    }
    location = [[CLLocationManager alloc] init];
    
    [location setDelegate:self];
    [location setDesiredAccuracy:kCLLocationAccuracyBest];
    [location setDistanceFilter:kCLDistanceFilterNone];
    [location startUpdatingLocation];
    
}


#pragma mark - locationManagerの設定

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    MKCoordinateRegion region;
    
    //表示範囲を決める
    region.span.latitudeDelta = 0.001;
    region.span.longitudeDelta = 0.001;
    
    region.center.latitude = newLocation.coordinate.latitude;
    region.center.longitude = newLocation.coordinate.longitude;
    
    double latitude = region.center.latitude;
    double longitude = region.center.longitude;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *nowLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [geocoder reverseGeocodeLocation:nowLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark *placemark in placemarks) {
            
            self.latLabel.text = [NSString stringWithFormat:@"%@" , placemark.postalCode];
            
            self.lngLabel.text = [NSString stringWithFormat:@"%@" @"%@" @"%@", placemark.administrativeArea,placemark.locality, placemark.name];
            
            /*
            NSLog(@"addressDictionary : %@", [placemark.addressDictionary description]);
            NSLog(@"name : %@", placemark.name);
            NSLog(@"thoroughfare : %@", placemark.thoroughfare);
            NSLog(@"subThoroughfare : %@", placemark.subThoroughfare);
            NSLog(@"locality : %@", placemark.locality);
            NSLog(@"subLocality : %@", placemark.subLocality);
            NSLog(@"administrativeArea : %@", placemark.administrativeArea);
            NSLog(@"subAdministrativeArea : %@", placemark.subAdministrativeArea);
            NSLog(@"postalCode : %@", placemark.postalCode);
            NSLog(@"ISOcountryCode : %@", placemark.ISOcountryCode);
            NSLog(@"country : %@", placemark.country);
            NSLog(@"inlandWater : %@", placemark.inlandWater);
            NSLog(@"ocean : %@", placemark.ocean);
            NSLog(@"areasOfInterest : %@", placemark.areasOfInterest);
            */ 
             
        }
        
    }];
    
    [mapView setRegion:region animated:YES];
}

#pragma mark - メモリーワーニング
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
