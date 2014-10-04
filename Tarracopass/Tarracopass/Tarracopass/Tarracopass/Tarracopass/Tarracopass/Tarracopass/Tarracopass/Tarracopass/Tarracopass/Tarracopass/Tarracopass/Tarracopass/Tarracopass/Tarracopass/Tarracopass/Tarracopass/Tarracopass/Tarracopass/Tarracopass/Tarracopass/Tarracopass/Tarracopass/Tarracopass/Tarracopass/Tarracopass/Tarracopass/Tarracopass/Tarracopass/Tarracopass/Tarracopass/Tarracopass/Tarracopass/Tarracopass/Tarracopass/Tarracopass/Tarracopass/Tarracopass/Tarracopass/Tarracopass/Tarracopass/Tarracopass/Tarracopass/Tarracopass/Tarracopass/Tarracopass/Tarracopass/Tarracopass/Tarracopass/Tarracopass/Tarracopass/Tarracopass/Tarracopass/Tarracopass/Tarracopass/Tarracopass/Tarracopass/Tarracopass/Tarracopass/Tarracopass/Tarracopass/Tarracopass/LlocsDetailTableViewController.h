//
//  LlocsDetailTableViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 28/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPBFloatingTextViewController.h"
#import <Social/Social.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "FSImageViewerViewController.h"

@class FTCoreTextView;
@interface LlocsDetailTableViewController : JPBFloatingTextViewController <UINavigationControllerDelegate, UIActionSheetDelegate,MKMapViewDelegate, CLLocationManagerDelegate, FSImageViewerViewControllerDelegate>

@property (nonatomic, strong) NSDictionary *llocsName;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) UIScrollView *scrollViewText;
@property (nonatomic, strong) FTCoreTextView *coreTextViewContent;
@property(strong, nonatomic) FSImageViewerViewController *imageViewController;

@end
