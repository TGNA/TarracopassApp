//
//  MonumentsTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 19/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "MonumentsTableViewController.h"
#import "MonumentsDetailViewController.h"
#import "MZFormSheetController.h"
#import "DOPDropDownMenu.h"
#import "FCNavigationViewController.h"

@interface MonumentsTableViewController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate>
@property (nonatomic, copy) NSArray *prices;
@property (nonatomic, copy) NSArray *horari;
@property (nonatomic, copy) NSArray *epoca;
@property (nonatomic, copy) NSArray *originalArray;
@property (nonatomic, copy) NSArray *results;
@end

@implementation MonumentsTableViewController

@synthesize monument = _monument;

-(NSArray *)monument
{
    if (!_monument) {
        _monument = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Monuments" ofType:@"plist"]];
    }
    return _monument;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.results = [NSArray arrayWithArray:self.monument];
    self.originalArray = [NSArray arrayWithArray:self.monument];
    
    self.title = @"Monuments";
    self.prices = @[@"Tots els preus", @"Gratuit", @"Pagament"];
    self.horari = @[@"Tots el horaris", @"Obert", @"Tancat"];
    self.epoca = @[@"Alfabeticament", @"Distància", @"Tancat"];
    
    DOPDropDownMenu *filter = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    filter.dataSource = self;
    filter.delegate = self;
    [self.view addSubview:filter];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
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

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 1;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    return 3;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    switch (indexPath.column) {
        case 0: return self.prices[indexPath.row];
            break;
//        case 1: return self.horari[indexPath.row];
//            break;
        case 2: return self.epoca[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    NSLog(@"column:%li row:%li", (long)indexPath.column, (long)indexPath.row);
    NSLog(@"%@",[menu titleForRowAtIndexPath:indexPath]);
//    NSString *title = [menu titleForRowAtIndexPath:indexPath];
    
    static NSString *prediStr1 = @"name like '*'",
    *prediStr2 = @"name like '*'",
    *prediStr3 = @"name like '*'";
    switch (indexPath.column) {
        case 0:{
            if (indexPath.row == 0) {
                prediStr1 = @"name like '*'";
            } else if(indexPath.row == 1){
                prediStr1 = [NSString stringWithFormat:@"gratuit == YES"];
            } else{
                prediStr1 = [NSString stringWithFormat:@"gratuit == NO"];
            }
        }
            break;
//        case 1:{
//            if (indexPath.row == 0) {
//                prediStr2 = @"name like '*'";
//            } else if(indexPath.row == 1){
//                NSDate *currDate = [NSDate date];
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
//                NSString *dateString = [dateFormatter stringFromDate:currDate];
//                NSLog(@"%@",dateString);
//                prediStr2 = [NSString stringWithFormat:@"gratuit == YES"];
//            } else{
//                prediStr2 = [NSString stringWithFormat:@"gratuit == NO"];
//            }
//        }
//            break;
//        case 2:{
//            if (indexPath.row == 0) {
//                prediStr3 = @"name like '*'";
//            } else {
//                prediStr3 = [NSString stringWithFormat:@"name like '*'", title];
//            }
//        }
            
        default:
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ AND %@ AND %@",prediStr1, prediStr2, prediStr3]];
    NSLog(@"Predicate  ---- \n%@", predicate);
    self.results = [self.originalArray filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
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
    return [self.results count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *item = (NSDictionary *)[self.results objectAtIndex:indexPath.row];
    
    UILabel *namelabel, *distancelabel;
    
    namelabel = (UILabel *)[cell viewWithTag:1];
    namelabel.text = [item objectForKey:@"name"];
    namelabel.adjustsFontSizeToFitWidth = YES;
    
//    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse) {
    
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 10; //kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // The best you can get
        
        [locationManager startUpdatingLocation];
        
        CLLocation *userlocation = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude];
        MKDistanceFormatter *formatter = [[MKDistanceFormatter alloc] init];
        formatter.units = MKDistanceFormatterUnitsMetric;
        formatter.unitStyle = MKDistanceFormatterUnitStyleFull;
        
        float latitude = [[item objectForKey:@"latitude"] floatValue];
        float longitude = [[item objectForKey:@"longitude"] floatValue];
        
        CLLocation *monument = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        CLLocationDistance distancenumber = [userlocation distanceFromLocation:monument];
        
        NSString *distance = [formatter stringFromDistance:distancenumber];
        
        distancelabel = (UILabel *)[cell viewWithTag:2];
        distancelabel.text = distance;
        distancelabel.adjustsFontSizeToFitWidth = YES;

//    }

    UIImageView *imageView;
    
    imageView = (UIImageView*)[cell viewWithTag:4];
    imageView.image = [UIImage imageNamed:[NSString stringWithString:[item objectForKey:@"image_menu"]]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showMonumentDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MonumentsDetailViewController *destViewController = segue.destinationViewController;
        destViewController.monumentsName = [self.results objectAtIndex:indexPath.row];
    }
}

@end
