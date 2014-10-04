//
//  MonumentsTableViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 19/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "RESideMenu.h"

@interface MonumentsTableViewController : UITableViewController <MKMapViewDelegate, CLLocationManagerDelegate> 

@property (strong, nonatomic) NSArray *monument;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
