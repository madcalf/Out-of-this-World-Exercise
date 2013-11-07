//
//  DDAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by DDD on 2013-11-05.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSpaceObject.h"

@protocol DDAddSpaceObjectViewControllerDelegate <NSObject>

@required
-(void)addSpaceObject:(DDSpaceObject *)aSpaceObject;
-(void)didCancel;

@end

@interface DDAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id<DDAddSpaceObjectViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

// ---- these refs are only for trying to make round buttons
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
// ------

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;
@end
