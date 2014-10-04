//
//  TempsViewController.h
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 24/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "CZWeatherKit.h"

@interface TempsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentConditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastDayOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastIconOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastDayTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastIconTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastDayThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastIconThreeLabel;

@end
