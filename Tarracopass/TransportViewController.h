//
//  TransportViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 27/09/13.
//  Copyright (c) 2013 Tarracopass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TransportPoint.h"

#define kGOOGLE_API_KEY @"AIzaSyA7_PAzQhNRrObqxu5IplYPXPebD7l3ngw"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface TransportViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    
    CLLocationCoordinate2D currentCentre;
    int currenDist;
    BOOL firstLaunch;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end
