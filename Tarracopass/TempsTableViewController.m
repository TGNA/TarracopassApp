//
//  TempsTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 24/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "TempsTableViewController.h"
#import "SVProgressHUD.h"

@interface TempsTableViewController ()

@property (nonatomic, strong) NSString *response;

@end

@implementation TempsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getWeather];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getWeather)];
    
    self.navigationItem.rightBarButtonItem = shareItem;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30; //helps for testing scrolling on iPad
}

- (CGFloat)horizontalOffset{
    return 190.0f;
}

-(void) getWeather{
    
    [SVProgressHUD showWithStatus:@"Carregant..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://api.wunderground.com/api/0d6f728ec35c45cb/conditions/q/ES/Tarragona.json"]];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:requestHandler options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"dictionary: %@", dictionary);
    
    NSString *weather = [[dictionary objectForKey:@"current_observation"] objectForKey:@"weather"];
    NSString *observation_time = [[dictionary objectForKey:@"current_observation"] objectForKey:@"observation_time"];
    
    [self setHeaderImage:[UIImage imageNamed:@"image.jpg"]];
    [self setTitleText:[NSString stringWithFormat:@"%@", weather]];
    [self setSubtitleText:[NSString stringWithFormat:@"%@", observation_time]];
    [self setLabelBackgroundGradientColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f]];
    
    CGFloat headerHeight = [self headerHeight];
    
    NSString *temp_c = [[dictionary objectForKey:@"current_observation"] objectForKey:@"temp_c"];
    
    UILabel *button = [[UILabel alloc] initWithFrame:CGRectMake(5, headerHeight - 140, 180, 200)];
    [button setText: [NSString stringWithFormat:@"%@", temp_c]];
    [button setFont:[UIFont fontWithName:@"OpenSans-Light" size:70.0]];
    [button setTextColor:[UIColor whiteColor]];
    [self addHeaderOverlayView:button];
    
    CGSize textSize = [[button text] sizeWithAttributes:@{NSFontAttributeName:[button font]}];
    
    UILabel *button1 = [[UILabel alloc] initWithFrame:CGRectMake(textSize.width + 5, headerHeight - 150, 80, 200)];
    [button1 setText:@"°C"];
    [button1 setFont:[UIFont fontWithName:@"OpenSans-Light" size:40.0]];
    [button1 setTextColor:[UIColor whiteColor]];
    [self addHeaderOverlayView:button1];
    
    [SVProgressHUD dismiss];
}

@end
