//
//  TempsViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 24/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "TempsViewController.h"
#import "SVProgressHUD.h"

@interface TempsViewController ()

@end

@implementation TempsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateWeather)];
    
    self.navigationItem.rightBarButtonItem = shareItem;
    
    UIImage *iconMenu = [UIImage imageNamed:@"menu"];
    iconMenu = [iconMenu imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *background = iconMenu;
    UIImage *backgroundSelected = iconMenu;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [button setBackgroundImage:background forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundSelected forState:UIControlStateSelected];
    button.frame = CGRectMake(0 ,0, 33, 17);
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateWeather];
}

-(void)menu{
    [self.sideMenuViewController presentLeftMenuViewController];
}


- (void)updateWeather
{
    [SVProgressHUD showWithStatus:@"Carregant..."];
    
    CZWeatherRequest *request = [CZWeatherRequest requestWithType:CZCurrentConditionsRequestType];
    request.location = [CZWeatherLocation locationWithCity:@"Tarragona" state:@"ES"];
    request.service = [CZWundergroundService serviceWithKey:@"0d6f728ec35c45cb"];
    [request performRequestWithHandler:^(id data, NSError *error) {
        if (data) {
            CZWeatherCondition *current = (CZWeatherCondition *)data;
            
            // Current Conditions
            _currentTemperatureLabel.text = [NSString stringWithFormat:@"%.1f°C", current.temperature.c];
            _temperatureLabel.text = [NSString stringWithFormat:@"H %.1f°C  L %.1f°C", current.highTemperature.c , current.lowTemperature.c];
            
            _currentConditionLabel.font = [UIFont fontWithName:@"Climacons" size:40];
            _currentConditionLabel.text = [NSString stringWithFormat:@"%c", current.climaconCharacter];
            
            _currentDescriptionLabel.text = [current.summary capitalizedString];
            
            // Updated
            NSString *updated = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
            _updatedLabel.text = [NSString stringWithFormat:@"Updated at %@", updated];
            
            

        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
    [SVProgressHUD dismiss];
}

@end
