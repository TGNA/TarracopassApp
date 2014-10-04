//
//  LlocsTableViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 28/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "RESideMenu.h"

@interface LlocsTableViewController : UITableViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *lloc;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
