//
//  TutorialViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 21/12/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import <CoreLocation/CoreLocation.h>

@interface TutorialViewController : UIViewController<EAIntroDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;
@property (weak, nonatomic) IBOutlet UIButton *locationPermission;
@property (weak, nonatomic) IBOutlet UIButton *comencar;
@property (weak, nonatomic) IBOutlet UIButton *tutorial;

@end
