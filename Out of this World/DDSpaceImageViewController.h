//
//  DDSpaceImageViewController.h
//  Out of this World
//
//  Created by DDD on 2013-10-29.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSpaceObject.h"

@interface DDSpaceImageViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

// QUESTION: Does this one not need the IBOutlet because we're creating it via code rather than the Storyboard/InterfaceBuilder?
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) DDSpaceObject *objectToDisplay;

@end
