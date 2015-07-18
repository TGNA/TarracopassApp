//
//  TutorialViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 21/12/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99
                                                alpha:1];
    
    UIBarButtonItem *closebutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(tancar:)];
    self.navigationItem.leftBarButtonItem =closebutton;
    
    _tutorial.layer.borderWidth = 1.0f;
    _tutorial.layer.borderColor = [UIColor colorWithRed:0.17 green:0.76 blue:0.42 alpha:1].CGColor;
    _tutorial.layer.cornerRadius = 2;
    _tutorial.tintColor = [UIColor colorWithRed:0.17 green:0.76 blue:0.42 alpha:1];
    
    _comencar.tintColor = [UIColor colorWithRed:0.17 green:0.76 blue:0.42 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tancar:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)tutorial:(id)sender {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Tarracopass";
    page1.titleFont = [UIFont fontWithName:@"OpenSans-Light" size:24];
    page1.desc = @"L'aplicació per conèixer Tarragona.\nContinua per començar.";
    page1.descFont = [UIFont fontWithName:@"OpenSans-Light" size:14];
    page1.descPositionY = 120;
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppIcon"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Per començar";
    page2.titleFont = [UIFont fontWithName:@"OpenSans-Light" size:24];
    page2.desc = @"Necessitem que ens autoritzis algun permís.";
    page2.descFont = [UIFont fontWithName:@"OpenSans-Light" size:14];
    page2.descPositionY = 120;
    page2.bgImage = [UIImage imageNamed:@"bg3"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 4";
    page3.desc = @"";
    page3.bgImage = [UIImage imageNamed:@"bg4"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.navigationController.view.bounds andPages:@[page1,page2,page3]];
    [intro setDelegate:self];
    
    [intro showInView:self.navigationController.view animateDuration:0.3];
}

- (IBAction)locationPermission:(id)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways) {
        [_locationPermission setTitle:@"Permès" forState:UIControlStateNormal];
        _locationPermission.tintColor = [UIColor greenColor];
    }else {
        [_locationPermission setTitle:@"Autoritzar" forState:UIControlStateNormal];
        _locationPermission.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        [self.locationManager requestWhenInUseAuthorization];
    }
}

@end
