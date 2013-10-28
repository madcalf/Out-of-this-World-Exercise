//
//  DDOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by DDD on 2013-10-26.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import "DDOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "DDSpaceObject.h"

@interface DDOuterSpaceTableViewController ()

@end

@implementation DDOuterSpaceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.planets = [[NSMutableArray alloc] init];
    NSLog(@"planets empty: %@", self.planets);
    NSArray *allPlanets = [AstronomicalData allKnownPlanets];
    
    // loop thru planets and make space objects from them
    for (NSDictionary *planetData in allPlanets) {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        DDSpaceObject *planetObject = [[DDSpaceObject alloc] initWithData:planetData image:[UIImage imageNamed:imageName]];

        [self.planets addObject:planetObject];
        NSLog(@"planet object: %@", planetObject);
    }
    
    NSLog(@"planet objects: %@", self.planets);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.planets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //    cell.textLabel.text = @"whoa... my first table view!";
    //    cell.textLabel.text = [NSString stringWithFormat:@"Section: %i   Row: %i", indexPath.section, indexPath.row];
    
    DDSpaceObject *planetObject = self.planets[indexPath.row];
    NSLog(@"planetObject: %@", planetObject.name);
    cell.textLabel.text = planetObject.name;
    cell.detailTextLabel.text = planetObject.nickname;
    cell.imageView.image = planetObject.image;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:.5 alpha:1];
//    cell.detailTextLabel.textColor = [UIColor grayColor];

//    if (indexPath.section == 0) {
//        cell.backgroundColor = [UIColor cyanColor];
//    } else if (indexPath.section == 1) {
//        cell.backgroundColor = [UIColor greenColor];
//    } else {
//        cell.backgroundColor = [UIColor cyanColor];
//    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
