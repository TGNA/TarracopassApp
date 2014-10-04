//
//  LlocsMapViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 28/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LlocsMapViewController : UIViewController <UIActionSheetDelegate, MKMapViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSDictionary *llocsLocation;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
