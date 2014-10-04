//
//  MonumentAudioViewController.m
//  Tarracopass
//
//  Created by Oscar Blanco Castan on 26/09/14.
//  Copyright (c) 2014 Oscar Blanco Castan. All rights reserved.
//

#import "MonumentAudioViewController.h"
#import "MZFormSheetController.h"

@interface MonumentAudioViewController ()
@end

@implementation MonumentAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)cancel:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {}];
}
@end
