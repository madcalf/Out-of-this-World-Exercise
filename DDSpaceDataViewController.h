//
//  DDSpaceDataViewController.h
//  Out of this World
//
//  Created by DDD on 2013-11-02.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSpaceObject.h"

@interface DDSpaceDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property DDSpaceObject *spaceObject;
@end
