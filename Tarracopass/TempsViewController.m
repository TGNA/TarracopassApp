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
    
    self.title = @"Temps";
    
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
    
    UIBarButtonItem *update = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateWeather)];
    
    self.navigationItem.leftBarButtonItem = barButton;
    self.navigationItem.rightBarButtonItem = update;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateWeather];
}

- (void)updateWeather
{
    [SVProgressHUD showWithStatus:@"Carregant..."];
    
    
    CZWundergroundRequest *request = [CZWundergroundRequest newConditionsRequest];
    request.location = [CZWeatherLocation locationFromCity:@"Tarragona" country:@"ES"];
    request.key = @"0d6f728ec35c45cb";
    [request sendWithCompletion:^(CZWeatherData *data, NSError *error) {
        CZWeatherCurrentCondition *condition = data.current;
        
        // Current Conditions
        _currentTemperatureLabel.text = [NSString stringWithFormat:@" %.1f°C", condition.temperature.c];
        _currentTemperatureLabel.adjustsFontSizeToFitWidth = YES;
        
        _temperatureLabel.text = [NSString stringWithFormat:@"%.1f°C", condition.temperature.c];
        _temperatureLabel.adjustsFontSizeToFitWidth = YES;
        
        _currentConditionLabel.text = [NSString stringWithFormat:@"%c", condition.climacon];
//        _currentConditionLabel.font = [UIFont fontWithName:CZClimacons size:200];
        _currentConditionLabel.adjustsFontSizeToFitWidth = YES;
        
        _currentDescriptionLabel.text = [condition.summary capitalizedString];
        _currentDescriptionLabel.adjustsFontSizeToFitWidth = YES;
        
        _currentHumidityLabel.text = [NSString stringWithFormat:@"%.0f%%", condition.humidity];
        _currentHumidityLabel.adjustsFontSizeToFitWidth = YES;
        
        
        // Updated
        NSString *updated = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
        _updatedLabel.text = [NSString stringWithFormat:@"Updated at %@", updated];
        _updatedLabel.adjustsFontSizeToFitWidth = YES;
        
        CGFloat fahrenheit = MIN(MAX(0, condition.temperature.f), 99);
        NSString *gradientImageName = [NSString stringWithFormat:@"gradient%d.png", (int)floor(fahrenheit / 10.0)];
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:gradientImageName] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
        
    }];
    
    [SVProgressHUD dismiss];
}

@end
