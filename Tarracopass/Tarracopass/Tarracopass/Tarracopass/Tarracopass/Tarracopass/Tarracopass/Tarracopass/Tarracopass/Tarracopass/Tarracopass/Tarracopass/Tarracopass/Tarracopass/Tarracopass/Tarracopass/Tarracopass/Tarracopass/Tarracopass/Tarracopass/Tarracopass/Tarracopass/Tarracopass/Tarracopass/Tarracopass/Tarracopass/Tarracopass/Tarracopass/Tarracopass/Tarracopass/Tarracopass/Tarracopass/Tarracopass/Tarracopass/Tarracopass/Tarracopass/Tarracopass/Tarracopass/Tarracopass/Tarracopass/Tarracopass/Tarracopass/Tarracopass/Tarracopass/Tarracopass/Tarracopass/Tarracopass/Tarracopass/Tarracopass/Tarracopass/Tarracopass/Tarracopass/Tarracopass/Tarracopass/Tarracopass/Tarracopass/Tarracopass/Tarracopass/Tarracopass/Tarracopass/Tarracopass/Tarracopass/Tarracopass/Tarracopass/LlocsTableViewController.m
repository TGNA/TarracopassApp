//
//  LlocsTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 28/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "LlocsTableViewController.h"
#import "LlocsDetailTableViewController.h"
#import "MZFormSheetController.h"

@interface LlocsTableViewController ()

@end

@implementation LlocsTableViewController

@synthesize lloc = _lloc;

-(NSArray *)lloc
{
    if (!_lloc) {
        _lloc = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Llocs" ofType:@"plist"]];
    }
    return _lloc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Llocs d'interès";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
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
-(void)menu{
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.lloc count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 10; //kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // The best you can get
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    CLLocation *userlocation = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
    MKDistanceFormatter *formatter = [[MKDistanceFormatter alloc] init];
    formatter.units = MKDistanceFormatterUnitsMetric;
    formatter.unitStyle = MKDistanceFormatterUnitStyleFull;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *item = (NSDictionary *)[self.lloc objectAtIndex:indexPath.row];
    
    float latitude = [[item objectForKey:@"latitude"] floatValue];
    float longitude = [[item objectForKey:@"longitude"] floatValue];
    
    CLLocation *monument = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocationDistance distancenumber = [userlocation distanceFromLocation:monument];
    
    NSString *distance = [formatter stringFromDistance:distancenumber];
    
    UILabel *namelabel, *distancelabel;
    
    namelabel = (UILabel *)[cell viewWithTag:1];
    namelabel.text = [item objectForKey:@"name"];
    namelabel.adjustsFontSizeToFitWidth = YES;
    
    distancelabel = (UILabel *)[cell viewWithTag:2];
    distancelabel.text = distance;
    distancelabel.adjustsFontSizeToFitWidth = YES;
    
    NSLog(@"User location: Latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    
    
    NSLog(@"ID: %ld Name: %@ Latitude: %f Longitude: %f Distance %@", (long)indexPath.row, [item objectForKey:@"name"], latitude, longitude, distance);
    
    
    UIImageView *imageView;
    
    imageView = (UIImageView*)[cell viewWithTag:4];
    imageView.image = [UIImage imageNamed:[NSString stringWithString:[item objectForKey:@"image_menu"]]];
    
    UIView *blurimage;
    
    blurimage = (UIView *)[cell viewWithTag:3];
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = blurimage.bounds;
    [blurimage addSubview:visualEffectView];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showLlocDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LlocsDetailTableViewController *destViewController = segue.destinationViewController;
        destViewController.llocsName = [_lloc objectAtIndex:indexPath.row];
        NSLog(@"llocsName: %@", [_lloc objectAtIndex:indexPath.row]);
    }
}

@end

