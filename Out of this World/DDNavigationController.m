//
//  DDNavigationController.m
//  Out of this World
//
//  Created by DDD on 2013-11-03.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import "DDNavigationController.h"

@interface DDNavigationController ()

@end

@implementation DDNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // JUST WANT TO SEE WHAT THE NavigationToolbar is, where it shows up... Can delete this subclass any time. It only exists cuz it's the only way i could figure out to access the UINavigationController to set this property. To apply it, just change the Custom Class of the Navigation Controller to use this subclass instead of UINavigationController
    [self setToolbarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
