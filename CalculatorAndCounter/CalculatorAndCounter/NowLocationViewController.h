//
//  NowLocationViewController.h
//  ToolBox
//
//  Created by Junji on 2014/06/15.
//  Copyright (c) 2014年 IdeaNote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NowLocationViewController : UIViewController

<MKMapViewDelegate,CLLocationManagerDelegate>

{
    MKMapView    *mapView;
    CLLocationManager *location;
    
}

#pragma mark - プロパティ設定
@property (weak , nonatomic) IBOutlet UILabel *latLabel;
@property (weak , nonatomic) IBOutlet UILabel *lngLabel;

@end
