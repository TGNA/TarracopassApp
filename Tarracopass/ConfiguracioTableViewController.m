//
//  ContacteTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 04/10/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "ContacteTableViewController.h"
#import "CTFeedbackViewController.h"
#import "SVModalWebViewController.h"
#import "RESideMenu.h"

@interface ContacteTableViewController ()

@end

@implementation ContacteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Contacte";
    
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

- (IBAction)oscar:(id)sender {
}

- (IBAction)tarracopass:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"http://tarracopass.com"];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (IBAction)feedback:(id)sender {
    CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
    feedbackViewController.toRecipients = @[@"contacte@tarracopass.com"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)facebook:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"https://www.facebook.com/pages/Tarracopass/485213361557435"];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (IBAction)twitter:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"http://twitter.com/Tarracopass"];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

@end
