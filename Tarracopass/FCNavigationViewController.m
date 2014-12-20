//
//  FCNavigationViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 20/12/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "FCNavigationViewController.h"
#import "AgendaCulturalViewController.h"
#import "MonumentsTableViewController.h"
#import "LlocsTableViewController.h"
#import "TempsViewController.h"
#import "TransportViewController.h"
#import "ConfiguracioTableViewController.h"

@interface FCNavigationViewController ()

@end

@implementation FCNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureVerticalMenu];
    self.verticalMenu.delegate = self;
    
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.verticalMenu.liveBlurBackgroundStyle = self.navigationBar.barStyle;
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FCVerticalMenu Configuration
- (void)configureVerticalMenu
{
    FCVerticalMenuItem *item1 = [[FCVerticalMenuItem alloc] initWithTitle:@"Monuments"
                                                             andIconImage:[UIImage imageNamed:@"monument"]];
    
    FCVerticalMenuItem *item2 = [[FCVerticalMenuItem alloc] initWithTitle:@"Llocs d'interés"
                                                             andIconImage:[UIImage imageNamed:@"interest"]];
    
    FCVerticalMenuItem *item3 = [[FCVerticalMenuItem alloc] initWithTitle:@"Agenda Cultural"
                                                             andIconImage:[UIImage imageNamed:@"calendar"]];
    
    FCVerticalMenuItem *item4 = [[FCVerticalMenuItem alloc] initWithTitle:@"Transport"
                                                             andIconImage:[UIImage imageNamed:@"bus"]];
    
    FCVerticalMenuItem *item5 = [[FCVerticalMenuItem alloc] initWithTitle:@"Temps"
                                                             andIconImage:[UIImage imageNamed:@"weather"]];
    
    FCVerticalMenuItem *item6 = [[FCVerticalMenuItem alloc] initWithTitle:@"Configuració"
                                                             andIconImage:[UIImage imageNamed:@"configuracio"]];
    
    item1.actionBlock = ^{
        MonumentsTableViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MonumentsTableViewController"];
        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];
    };
    item2.actionBlock = ^{
        LlocsTableViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LlocsTableViewController"];
        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];
    };
    item3.actionBlock = ^{
        AgendaCulturalViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AgendaCulturalViewController"];
        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];
    };
    item4.actionBlock = ^{
        TransportViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TransportViewController"];
        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];
    };
    item5.actionBlock = ^{
        TempsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TempsViewController"];
        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];
    };
    item6.actionBlock = ^{
        ConfiguracioTableViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ConfiguracioTableViewController"];
        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];
    };
    
    _verticalMenu = [[FCVerticalMenu alloc] initWithItems:@[item1, item2, item3, item4, item5, item6]];
    item6.font = [UIFont fontWithName:@"OpenSans-Light" size:14.0];
    _verticalMenu.appearsBehindNavigationBar = YES;
    
}

-(IBAction)openVerticalMenu:(id)sender
{
    if (_verticalMenu.isOpen)
        return [_verticalMenu dismissWithCompletionBlock:nil];
    
    [_verticalMenu showFromNavigationBar:self.navigationBar inView:self.view];
}


#pragma mark - FCVerticalMenu Delegate Methods

-(void)menuWillOpen:(FCVerticalMenu *)menu
{
    NSLog(@"menuWillOpen hook");
}

-(void)menuDidOpen:(FCVerticalMenu *)menu
{
    NSLog(@"menuDidOpen hook");
}

-(void)menuWillClose:(FCVerticalMenu *)menu
{
    NSLog(@"menuWillClose hook");
}

-(void)menuDidClose:(FCVerticalMenu *)menu
{
    NSLog(@"menuDidClose hook");
}

@end