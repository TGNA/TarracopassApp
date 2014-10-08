//
//  LlocsDetailTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 28/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "LlocsDetailTableViewController.h"
#import "LlocsMapViewController.h"
#import "LlocsTimeTableViewController.h"
#import "MZFormSheetController.h"
#import "FTCoreTextView.h"
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"

@interface LlocsDetailTableViewController () <FTCoreTextViewDelegate>

@end

@implementation LlocsDetailTableViewController

@synthesize llocsName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *item = llocsName;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareActionSheet:)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    
    UILabel *priceItem = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollViewText.frame.size.width -80, 10, 80, 40) ];
    priceItem.text = [item objectForKey:@"price"];
    [priceItem setTextColor:[UIColor colorWithRed:0.91 green:0.55 blue:0.22 alpha:1]];
    [priceItem setFont:[UIFont fontWithName:@"OpenSans-Light" size:20.0f]];
    [priceItem setTextAlignment: NSTextAlignmentLeft];
    [self.scrollViewText addSubview:priceItem];
    
    UILabel *pricetitleItem = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollViewText.frame.size.width - priceItem.frame.size.width - 80 - 5, 10, 80, 40) ];
    pricetitleItem.text = @"Preu: ";
    [pricetitleItem setTextColor:[UIColor colorWithRed:0.91 green:0.55 blue:0.22 alpha:1]];
    [pricetitleItem setFont:[UIFont fontWithName:@"OpenSans-Light" size:20.0f]];
    [pricetitleItem setTextAlignment: NSTextAlignmentRight];
    [self.scrollViewText addSubview:pricetitleItem];
    
    UIButton *hourItem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [hourItem addTarget:self action:@selector(timetables:) forControlEvents:UIControlEventTouchUpInside];
    [hourItem setTitle:@"Horaris" forState:UIControlStateNormal];
    hourItem.titleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:20.0f];
    hourItem.frame = CGRectMake(10, 10, 80, 40);
    [self.scrollViewText addSubview:hourItem];
    
    //UIBarButtonItem *audioItem = [[UIBarButtonItem alloc] initWithTitle:@"Audioguia" style:UIBarButtonItemStylePlain target:nil action:@selector(audioguia)];
    
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
    
    self.title = [item objectForKey:@"name"];
    
    float latitude = [[item objectForKey:@"latitude"] floatValue];
    float longitude = [[item objectForKey:@"longitude"] floatValue];
    
    CLLocation *monument = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocationDistance distancenumber = [userlocation distanceFromLocation:monument];
    
    NSString *distance = [formatter stringFromDistance:distancenumber];
    
    [self setHeaderImage:[UIImage imageNamed:[item objectForKey:@"image"]]];
    [self setTitleText:distance];
    [self setSubtitleText:[item objectForKey:@"direction"]];
    [self setLabelBackgroundGradientColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f]];
    
    CGFloat headerHeight = [self headerHeight];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, headerHeight - 55, 44, 44)];
    UIImage *btnImage = [UIImage imageNamed:@"map"];
    [button setImage:btnImage forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:20]];
    [button addTarget:self action:@selector(map:) forControlEvents:UIControlEventTouchUpInside];
    [self addHeaderOverlayView:button];
    
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 55, headerHeight - 55, 50, 50)];
    UIImage *btnImage1 = [UIImage imageNamed:@"photos"];
    [imageButton setImage:btnImage1 forState:UIControlStateNormal];
    [imageButton.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:20]];
    [imageButton addTarget:self action:@selector(photos:) forControlEvents:UIControlEventTouchUpInside];
    [self addHeaderOverlayView:imageButton];
    
    UINavigationBar *myNav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [myNav setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [UINavigationBar appearance].translucent = YES;
    [self.view addSubview:myNav];
    
    UIBarButtonItem *shareItemNav = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareActionSheet:)];
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:[item objectForKey:@"name"]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navigItem.leftBarButtonItem = backItem;
    navigItem.rightBarButtonItem = shareItemNav;
    myNav.items = [NSArray arrayWithObjects: navigItem,nil];
    
    [self.navigationController setNavigationBarHidden:YES];
}
-(void) viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}
-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareActionSheet:(id)sender {
    
    NSDictionary *item = llocsName;
    
    NSURL *shareURL = [NSURL URLWithString:[item objectForKey:@"short_url"]];
    
    NSArray *items   = [NSArray arrayWithObjects:
                        [item objectForKey:@"share_text"],
                        shareURL,
                        nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    [activityViewController setValue:[item objectForKey:@"share_text"] forKey:@"subject"];
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)photos:(id)sender {
    
    NSDictionary *item = llocsName;
    
    // URLs array
    NSArray *photosURL = [item objectForKey:@"url_image"];
    
    NSLog(@"%@", photosURL);
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    int i;
    for (i = 0; i < [photosURL count]; i++) {
        FSBasicImage *image = [[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [photosURL objectAtIndex:i ]]]];
        [array addObject:image];
    }
    
    NSLog(@"%@", array);
    
    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:array];
    
    self.imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    
    _imageViewController.delegate = self;
    
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imageViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    
}

- (void)imageViewerViewController:(FSImageViewerViewController *)imageViewerViewController didMoveToImageAtIndex:(NSInteger)index {
    NSLog(@"FSImageViewerViewController: %@ didMoveToImageAtIndex: %li",imageViewerViewController, (long)index);
}

- (IBAction)map:(id)sender {
    
    [self performSegueWithIdentifier: @"LlocsMapShow" sender: self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"LlocsMapShow"])
    {
        LlocsMapViewController *destViewController = [segue destinationViewController];
        destViewController.llocsLocation = llocsName;
    }
}

- (CGFloat)horizontalOffset{
    return 50.0f;
}

- (UIScrollView*)contentView{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect bounds = self.view.bounds;
    
    //  Create scroll view containing allowing to scroll the FTCoreText view
    self.scrollViewText = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollViewText.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollViewText.scrollEnabled = NO;
    
    //  Create FTCoreTextView. Everything will be rendered within this view
    self.coreTextViewContent = [[FTCoreTextView alloc] initWithFrame:CGRectInset(bounds, 20.0f, 10.0f)];
    self.coreTextViewContent.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    //  Add custom styles to the FTCoreTextView
    [self.coreTextViewContent addStyles:[self coreTextStyle]];
    
    //  Set the custom-formatted text to the FTCoreTextView
    self.coreTextViewContent.text = [self textForViewContent];
    
    self.coreTextViewContent.delegate = self;
    
    [self.scrollViewText addSubview:self.coreTextViewContent];
    
    return _scrollViewText;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //  We need to recalculate fit height on every layout because
    //  when the device orientation changes, the FTCoreText's width changes
    
    //  Make the FTCoreTextView to automatically adjust it's height
    //  so it fits all its rendered text using the actual width
    [self.coreTextViewContent fitToSuggestedHeight];
    
    //  Adjust the scroll view's content size so it can scroll all
    //  the FTCoreTextView's content
    [self.scrollViewText setContentSize:CGSizeMake(CGRectGetWidth(self.scrollViewText.bounds), CGRectGetMaxY(self.coreTextViewContent.frame)-44.0f)];
}
#pragma mark Load Static Content

- (NSString *)textForViewContent
{
    NSDictionary *item = llocsName;
    
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithString:[item objectForKey:@"text"]] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
}

- (IBAction)timetables:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"llocTimeTables"];
    
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    formSheet.portraitTopInset = self.view.frame.size.height - 400.0 - 20.0; // height of view, heigh of small view, statusbar
    formSheet.presentedFormSheetSize = CGSizeMake(self.view.frame.size.width, 400);
    formSheet.cornerRadius = 0;
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        // Passing data
        LlocsTimeTableViewController *destViewController = (LlocsTimeTableViewController *)presentedFSViewController;
        destViewController.llocsTime = llocsName;
        NSLog(@"Im called to send something");
    };
    
    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {}];
}
/*
 - (IBAction)audioguia{
 UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"monumentAudio"];
 
 MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
 formSheet.portraitTopInset = self.view.frame.size.height - 400.0 - 20.0; // height of view, heigh of small view, statusbar
 formSheet.presentedFormSheetSize = CGSizeMake(self.view.frame.size.width, 400);
 formSheet.cornerRadius = 0;
 formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
 formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
 // Passing data
 MonumentAudioViewController *destViewController = (MonumentAudioViewController *)presentedFSViewController;
 //destViewController.monumentsAudio = monumentsName;
 NSLog(@"Im called to send something");
 };
 
 [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {}];
 }*/

#pragma mark Styling

- (NSArray *)coreTextStyle
{
    NSMutableArray *result = [NSMutableArray array];
    
    //  This will be default style of the text not closed in any tag
    FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
    defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
    defaultStyle.font = [UIFont fontWithName:@"OpenSans" size:16.f];
    defaultStyle.textAlignment = FTCoreTextAlignementJustified;
    [result addObject:defaultStyle];
    
    //  Create style using convenience method
    FTCoreTextStyle *titleStyle = [FTCoreTextStyle styleWithName:@"title"];
    titleStyle.font = [UIFont fontWithName:@"OpenSans" size:40.f];
    titleStyle.paragraphInset = UIEdgeInsetsMake(20.f, 0, 25.f, 0);
    titleStyle.textAlignment = FTCoreTextAlignementCenter;
    [result addObject:titleStyle];
    
    //  Image will be centered
    FTCoreTextStyle *imageStyle = [FTCoreTextStyle new];
    imageStyle.name = FTCoreTextTagImage;
    imageStyle.textAlignment = FTCoreTextAlignementCenter;
    [result addObject:imageStyle];
    
    FTCoreTextStyle *firstLetterStyle = [FTCoreTextStyle new];
    firstLetterStyle.name = @"firstLetter";
    firstLetterStyle.font = [UIFont fontWithName:@"OpenSans-Bold" size:30.f];
    [result addObject:firstLetterStyle];
    
    //  This is the link style
    //  Notice that you can make copy of FTCoreTextStyle
    //  and just change any required properties
    FTCoreTextStyle *linkStyle = [defaultStyle copy];
    linkStyle.name = FTCoreTextTagLink;
    linkStyle.color = [UIColor orangeColor];
    [result addObject:linkStyle];
    
    FTCoreTextStyle *subtitleStyle = [FTCoreTextStyle styleWithName:@"subtitle"];
    subtitleStyle.font = [UIFont fontWithName:@"OpenSans-Bold" size:25.f];
    subtitleStyle.color = [UIColor brownColor];
    subtitleStyle.paragraphInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [result addObject:subtitleStyle];
    
    //  This will be list of items
    //  You can specify custom style for a bullet
    FTCoreTextStyle *bulletStyle = [defaultStyle copy];
    bulletStyle.name = FTCoreTextTagBullet;
    bulletStyle.bulletFont = [UIFont fontWithName:@"OpenSans" size:16.f];
    bulletStyle.bulletColor = [UIColor orangeColor];
    bulletStyle.bulletCharacter = @"❧";
    bulletStyle.paragraphInset = UIEdgeInsetsMake(0, 20.f, 0, 0);
    [result addObject:bulletStyle];
    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
    italicStyle.name = @"italic";
    italicStyle.underlined = YES;
    italicStyle.font = [UIFont fontWithName:@"OpenSans-Italic" size:16.f];
    [result addObject:italicStyle];
    
    FTCoreTextStyle *boldStyle = [defaultStyle copy];
    boldStyle.name = @"bold";
    boldStyle.font = [UIFont fontWithName:@"OpenSans-Bold" size:16.f];
    [result addObject:boldStyle];
    
    FTCoreTextStyle *coloredStyle = [defaultStyle copy];
    [coloredStyle setName:@"colored"];
    [coloredStyle setColor:[UIColor redColor]];
    [result addObject:coloredStyle];
    
    return  result;
}


@end