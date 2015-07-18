//
//  ConfiguracioTableViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 04/10/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "ConfiguracioTableViewController.h"
#import "CTFeedbackViewController.h"
#import "SVModalWebViewController.h"
#import "FCNavigationViewController.h"
#import "UIViewController+DBPrivacyHelper.h"

@interface ConfiguracioTableViewController ()

@end

@implementation ConfiguracioTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Configuració";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    // Set the background color of our header/footer.
    header.contentView.backgroundColor = [UIColor blackColor];
    
    // You can also do this to set the background color of our header/footer,
    //    but the gradients/other effects will be retained.
    // view.tintColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tutorial:(id)sender {
    [self showPrivacyHelperForType:DBPrivacyTypeLocation controller:^(DBPrivateHelperController *vc) {} didPresent:^{} didDismiss:^{} useDefaultSettingPane:YES];
}

- (IBAction)oscar:(id)sender {
}

- (IBAction)tarracopass:(id)sender {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"http://tarracopass.com"];
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (IBAction)feedback:(id)sender {
    CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
    feedbackViewController.toRecipients = @[@"oscarblanco.projectes@gmail.com"];
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
