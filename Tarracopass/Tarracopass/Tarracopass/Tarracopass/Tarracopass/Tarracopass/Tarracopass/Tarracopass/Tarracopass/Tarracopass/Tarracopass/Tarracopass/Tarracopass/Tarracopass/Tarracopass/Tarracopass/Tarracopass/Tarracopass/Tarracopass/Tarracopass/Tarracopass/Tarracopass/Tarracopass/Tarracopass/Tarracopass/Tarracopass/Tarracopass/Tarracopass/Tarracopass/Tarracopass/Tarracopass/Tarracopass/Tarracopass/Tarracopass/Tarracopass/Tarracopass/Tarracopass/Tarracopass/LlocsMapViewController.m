//
//  LlocsMapViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 28/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "LlocsMapViewController.h"

@interface LlocsMapViewController ()

@end

@implementation LlocsMapViewController

@synthesize llocsLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithTitle:@"Porta-m'hi" style:UIBarButtonItemStylePlain target:self action:@selector(showActionSheet:)];
    
    self.navigationItem.rightBarButtonItem = shareItem;
    
    NSDictionary *item = llocsLocation;
    
    self.title = [item objectForKey:@"name"];
    
    float latitude = [[item objectForKey:@"latitude"] floatValue];
    float longitude = [[item objectForKey:@"longitude"] floatValue];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude = longitude;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(zoomLocation, 400, 400);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = latitude;
    annotationCoord.longitude = longitude;
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = [item objectForKey:@"name"];
    [_mapView addAnnotation:annotationPoint];
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

-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  
                                  delegate:self
                                  cancelButtonTitle:@"Millor no..."
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Mapes", @"Google Maps", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSDictionary *item = llocsLocation;
    float latitude = [[item objectForKey:@"latitude"] floatValue];
    float longitude = [[item objectForKey:@"longitude"] floatValue];
    
    if (buttonIndex == 0) {
        NSString * url = [NSString stringWithFormat:@"http://maps.apple.com/?q=%f,%f", latitude, longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    } else if (buttonIndex == 1) {
        NSString * url = [NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f&zoom=18&directionsmode=walking", latitude, longitude];
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            [[UIApplication sharedApplication] openURL:
             [NSURL URLWithString: url]];
        } else {
            NSLog(@"Google Maps app is not installed");
            //left as an exercise for the reader: open the Google Maps mobile website instead!
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                             message:@"Google Maps no està instalat."
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (IBAction)centerMapOnUserButtonClicked:(id)sender {
    if (self.mapView.userTrackingMode) {
        NSDictionary *item = llocsLocation;
        
        self.title = [item objectForKey:@"name"];
        
        float latitude = [[item objectForKey:@"latitude"] floatValue];
        float longitude = [[item objectForKey:@"longitude"] floatValue];
        
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = latitude;
        zoomLocation.longitude = longitude;
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(zoomLocation, 400, 400);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
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

@end