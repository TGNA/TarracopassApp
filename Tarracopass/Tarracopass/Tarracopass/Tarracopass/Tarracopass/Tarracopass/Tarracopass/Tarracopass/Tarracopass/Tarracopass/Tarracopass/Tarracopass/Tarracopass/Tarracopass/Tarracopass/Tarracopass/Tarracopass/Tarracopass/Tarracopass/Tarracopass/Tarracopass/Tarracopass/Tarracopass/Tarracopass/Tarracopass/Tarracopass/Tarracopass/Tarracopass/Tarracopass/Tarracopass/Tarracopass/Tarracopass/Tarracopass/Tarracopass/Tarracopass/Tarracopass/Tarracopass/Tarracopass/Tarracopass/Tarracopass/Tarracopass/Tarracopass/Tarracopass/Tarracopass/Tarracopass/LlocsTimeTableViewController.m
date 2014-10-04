//
//  LlocsTimeTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 28/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "LlocsTimeTableViewController.h"
#import "MZFormSheetController.h"
#import "FTCoreTextView.h"

@interface LlocsTimeTableViewController () <FTCoreTextViewDelegate>
@end

@implementation LlocsTimeTableViewController

@synthesize llocsTime;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _navbar.topItem.title = @"Horaris";
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButton:)];
    _navbar.topItem.leftBarButtonItem = done;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    //  Create scroll view containing allowing to scroll the FTCoreText view
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //  Create FTCoreTextView. Everything will be rendered within this view
    self.coreTextViewHorari = [[FTCoreTextView alloc] initWithFrame:CGRectInset(bounds, 20.0f, 5)];
    self.coreTextViewHorari.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //  Add custom styles to the FTCoreTextView
    [self.coreTextViewHorari addStyles:[self coreTextStyle]];
    
    //  Set the custom-formatted text to the FTCoreTextView
    
    //  If you want to get notified about users taps on the links,
    //  implement FTCoreTextView's delegate methods
    //  See example implementation below
    self.coreTextViewHorari.delegate = self;
    
    
    _contentView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    
    
    [self.scrollView addSubview:self.coreTextViewHorari];
    [self.contentView addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setText{
    self.coreTextViewHorari.text = [self textForViewHorari];
    NSLog(@"%@", [self textForViewHorari]);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //  We need to recalculate fit height on every layout because
    //  when the device orientation changes, the FTCoreText's width changes
    
    //  Make the FTCoreTextView to automatically adjust it's height
    //  so it fits all its rendered text using the actual width
    [self.coreTextViewHorari fitToSuggestedHeight];
    
    //  Adjust the scroll view's content size so it can scroll all
    //  the FTCoreTextView's content
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds), CGRectGetMaxY(self.coreTextViewHorari.frame)+20.0f)];
    
    [self setText];
}

#pragma mark Load Static Content

- (NSString *)textForViewHorari
{
    NSDictionary *item = llocsTime;
    
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithString:[item objectForKey:@"horari"]] ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
}

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
    titleStyle.font = [UIFont fontWithName:@"OpenSans" size:20.f];
    titleStyle.color = [UIColor orangeColor];
    titleStyle.paragraphInset = UIEdgeInsetsMake(10.f, 0, 10.0f, 0);
    titleStyle.textAlignment = FTCoreTextAlignementLeft;
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
    subtitleStyle.font = [UIFont fontWithName:@"OpenSans-Bold" size:40.f];
    subtitleStyle.color = [UIColor brownColor];
    subtitleStyle.paragraphInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [result addObject:subtitleStyle];
    
    //  This will be list of items
    //  You can specify custom style for a bullet
    FTCoreTextStyle *bulletStyle = [defaultStyle copy];
    bulletStyle.name = FTCoreTextTagBullet;
    bulletStyle.bulletFont = [UIFont fontWithName:@"OpenSans" size:50.f];
    bulletStyle.bulletColor = [UIColor orangeColor];
    bulletStyle.bulletCharacter = @"•";
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


- (IBAction)doneButton:(id)sender {
    
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {}];
    
}

@end