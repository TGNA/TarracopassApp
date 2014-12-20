//
//  TempsViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 24/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "TempsViewController.h"
#import "SVProgressHUD.h"
#import "FCNavigationViewController.h"

@interface TempsViewController ()

@end

@implementation TempsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateWeather)];
    
    self.navigationItem.rightBarButtonItem = shareItem;
    
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateWeather];
}

- (void)updateWeather
{
    [SVProgressHUD showWithStatus:@"Carregant..."];
    
    CZWeatherRequest *request = [CZWeatherRequest requestWithType:CZCurrentConditionsRequestType];
    request.location = [CZWeatherLocation locationWithCity:@"Tarragona" state:@"ES"];
    request.service = [CZWundergroundService serviceWithKey:@"0d6f728ec35c45cb"];
    request.language = @"SP";
    [request performRequestWithHandler:^(id data, NSError *error) {
        if (data) {
            CZWeatherCondition *current = (CZWeatherCondition *)data;
            
            // Current Conditions
            _currentTemperatureLabel.text = [NSString stringWithFormat:@" %.1f°C", current.temperature.c];
            _currentTemperatureLabel.adjustsFontSizeToFitWidth = YES;
            
            _temperatureLabel.text = [NSString stringWithFormat:@"H %.1f°C  L %.1f°C", current.highTemperature.c , current.lowTemperature.c];
            _temperatureLabel.adjustsFontSizeToFitWidth = YES;
            
            _currentConditionLabel.text = [NSString stringWithFormat:@"%c", current.climaconCharacter];
            _currentConditionLabel.font = [UIFont fontWithName:CLIMACONS_FONT size:200];
            _currentConditionLabel.adjustsFontSizeToFitWidth = YES;
            
            _currentDescriptionLabel.text = [current.summary capitalizedString];
            _currentDescriptionLabel.adjustsFontSizeToFitWidth = YES;
            
            _currentHumidityLabel.text = [NSString stringWithFormat:@"%.0f%%", current.humidity];
            _currentHumidityLabel.adjustsFontSizeToFitWidth = YES;
            
            
            // Updated
            NSString *updated = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
            _updatedLabel.text = [NSString stringWithFormat:@"Updated at %@", updated];
            _updatedLabel.adjustsFontSizeToFitWidth = YES;
            
            CGFloat fahrenheit = MIN(MAX(0, current.temperature.f), 99);
            NSString *gradientImageName = [NSString stringWithFormat:@"gradient%d.png", (int)floor(fahrenheit / 10.0)];
            UIGraphicsBeginImageContext(self.view.frame.size);
            [[UIImage imageNamed:gradientImageName] drawInRect:self.view.bounds];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            self.view.backgroundColor = [UIColor colorWithPatternImage:image];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
    [SVProgressHUD dismiss];
}

@end
