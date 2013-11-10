//
//  DDAddSpaceObjectViewController.m
//  Out of this World
//
//  Created by DDD on 2013-11-05.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import "DDAddSpaceObjectViewController.h"

@interface DDAddSpaceObjectViewController ()

@end

@implementation DDAddSpaceObjectViewController

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
    
    // fill background with an image
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
    
    // rounded buttons
    CALayer *cancelBtnLayer = [self.cancelButton layer];
    [cancelBtnLayer setMasksToBounds:YES];
    [cancelBtnLayer setCornerRadius:5.0f];
    
    CALayer *addBtnLayer = [self.addButton layer];
    [addBtnLayer setMasksToBounds:YES];
    [addBtnLayer setCornerRadius:5.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
}

- (IBAction)addButtonPressed:(id)sender {
    // create a space object based on the collected info
    DDSpaceObject *spaceObject = [self makeSpaceObject];
    [self.delegate addSpaceObject:spaceObject];
}

#pragma mark - private / helper methods

-(DDSpaceObject *)makeSpaceObject {
    DDSpaceObject *spaceObject = [[DDSpaceObject alloc] init];
    spaceObject.name = self.nameTextField.text;
    spaceObject.nickname = self.nicknameTextField.text;
    spaceObject.diameter = [self.diameterTextField.text floatValue];
    spaceObject.temperature = [self.temperatureTextField.text floatValue];
    spaceObject.numberOfMoons = [self.numberOfMoonsTextField.text intValue];
    spaceObject.interestingFact  = self.interestingFactTextField.text;
    // add placeholder image for now
    spaceObject.image = [UIImage imageNamed:@"EinsteinRing.jpg"];
    return spaceObject;
}
@end
