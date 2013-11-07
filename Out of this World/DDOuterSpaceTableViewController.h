//
//  DDOuterSpaceTableViewController.h
//  Out of this World
//
//  Created by DDD on 2013-10-26.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDAddSpaceObjectViewController.h"

@interface DDOuterSpaceTableViewController : UITableViewController <DDAddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;
@end
