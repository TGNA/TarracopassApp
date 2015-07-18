//
//  TransportViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 27/09/13.
//  Copyright (c) 2013 Tarracopass. All rights reserved.
//

#import "TransportViewController.h"
#import "TransportDetailViewController.h"
#import "SVProgressHUD.h"
#import "FCNavigationViewController.h"

@interface TransportViewController ()

@end

@implementation TransportViewController
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Transport";
    
    self.mapView.delegate = self;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];

    locationManager.delegate = self;
    
    if (locationManager.location != nil) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate, 300, 300);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        [self performSelector:@selector(bus)];
    }
    
    UIImage *iconMenu = [UIImage imageNamed:@"menu"];
    iconMenu = [iconMenu imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImage *background = iconMenu;
    UIImage *backgroundSelected = iconMenu;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self.navigationController action:@selector(openVerticalMenu:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [button setBackgroundImage:background forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundSelected forState:UIControlStateSelected];
    button.frame = CGRectMake(0 ,0, 33, 17);
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)centerMapOnUserButtonClicked:(id)sender {
    if (self.mapView.userTrackingMode) {
        [self.mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
    }else
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
}

- (IBAction)setMapType:(id)sender {
    if (self.mapView.mapType == MKMapTypeStandard)
        self.mapView.mapType = MKMapTypeSatellite;
    else if (self.mapView.mapType == MKMapTypeSatellite)
        self.mapView.mapType = MKMapTypeHybrid;
    else if (self.mapView.mapType == MKMapTypeHybrid)
        self.mapView.mapType = MKMapTypeStandard;
}

-(void) queryGooglePlaces: (NSString *) googleType
{
    
    
    // Build the url string we are going to sent to Google. NOTE: The kGOOGLE_API_KEY is a constant which should contain your own API key that you can obtain from Google. See this link for more info:
    // https://developers.google.com/maps/documentation/places/#Authentication
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=500&types=%@&sensor=true&key=%@", currentCentre.latitude, currentCentre.longitude, googleType, kGOOGLE_API_KEY];
    
    //Formulate the string as URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"];
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", places);
    
    //Plot the data in the places array onto the map with the plotPostions method.
    [self plotPositions:places];
    
    [SVProgressHUD dismiss];
}

- (void)plotPositions:(NSArray *)data
{
    //Remove any existing custom annotations but not the user location blue dot.
    for (id<MKAnnotation> annotation in mapView.annotations)
    {
        if ([annotation isKindOfClass:[TransportPoint class]])
        {
            [mapView removeAnnotation:annotation];
        }
    }
    
    
    //Loop through the array of places returned from the Google API.
    for (int i=0; i<[data count]; i++)
    {
        
        //Retrieve the NSDictionary object in each index of the array.
        NSDictionary* place = [data objectAtIndex:i];
        
        //There is a specific NSDictionary object that gives us location info.
        NSDictionary *geo = [place objectForKey:@"geometry"];
        
        
        //Get our name and address info for adding to a pin.
        NSString *name=[place objectForKey:@"name"];
        NSString *vicinity=[place objectForKey:@"formatted_address"];
        
        //Get the lat and long for the location.
        NSDictionary *loc = [geo objectForKey:@"location"];
        
        //Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord;
        
        //Set the lat and long.
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        
        //Create a new annotiation.
        TransportPoint *placeObject = [[TransportPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        
        
        [mapView addAnnotation:placeObject];
    }
}

-(void)bus {
    
    NSString *buttonTitle = @"bus_station";
    [self queryGooglePlaces:buttonTitle];
    
    [SVProgressHUD showWithStatus:@"Carregant..."];
    NSLog(@"==========================void==========================");

}

- (IBAction)bus:(id)sender {
    [self bus];
    NSLog(@"==========================action==========================");
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [SVProgressHUD dismiss];
    
}

#pragma mark - MKMapViewDelegate methods.


- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    
    //Zoom back to the user location after adding a new set of annotations.
    
    //Get the center point of the visible map.
    CLLocationCoordinate2D centre = [mv centerCoordinate];
    
    MKCoordinateRegion region;
    
    //If this is the first launch of the app then set the center point of the map to the user's location.
    if (firstLaunch) {
        region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,5000,5000);
        firstLaunch=NO;
    }else {
        //Set the center point to the visible region of the map and change the radius to match the search radius passed to the Google query string.
        region = MKCoordinateRegionMakeWithDistance(centre,currenDist,currenDist);
    }
    
    //Set the visible region of the map.
    [mv setRegion:region animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //Define our reuse indentifier.
    static NSString *identifier = @"MapPoint";
    
    
    if ([annotation isKindOfClass:[TransportPoint class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.rightCalloutAccessoryView = rightButton;
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    //Get the east and west points on the map so we calculate the distance (zoom level) of the current map view.
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    //Set our current distance instance variable.
    currenDist = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    
    //Set our current centre point on the map instance variable.
    currentCentre = self.mapView.centerCoordinate;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TransportDetailViewController *detailViewController = (TransportDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TransportDetailViewController"];
    
    float latitude = view.annotation.coordinate.latitude;
    float longitude = view.annotation.coordinate.longitude;
    NSString *stringLatitude = [NSString stringWithFormat:@"%.20f", latitude];
    NSString *stringLongitude = [NSString stringWithFormat:@"%.20f", longitude];
    
    NSDictionary *annotation = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: stringLatitude, stringLongitude, nil] forKeys:[NSArray arrayWithObjects: @"latitude", @"longitude", nil]];
    NSLog(@"%@", annotation);
    detailViewController.transportLocation = annotation;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
