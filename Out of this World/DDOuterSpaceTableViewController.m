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
#import "DDSpaceImageViewController.h"
#import "DDSpaceDataViewController.h"
#import "DDAddSpaceObjectViewController.h"

@interface DDOuterSpaceTableViewController ()

@end

@implementation DDOuterSpaceTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects"

#pragma mark - getters/setters (Lazy Instantiation)

// note the use of underscores here rather than the self.propertyname
// these get created automatically when you declare the property in the .h?
-(NSMutableArray *)planets {
    if (!_planets) {
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

-(NSMutableArray *)addedSpaceObjects {
    if (!_addedSpaceObjects) {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
}

#pragma mark - initialzer

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // loop thru planets and make space objects from them
    [self defaultSpaceObjectsFromData];
    
    // get added planets from NSUserDefaults
    [self loadSavedSpaceObjects];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"TableViewController.prepareForSegue");
    // currenty expecting this to be a UITableCellView, but need to make sure before we send any specific methods to it.
    
    // make sure the sender is a UITableViewCell, before using it in any TableViewCell specific way
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSLog(@"SEGUE IS FROM TABLE VIEW CELL");
        
        // test if the target/destination of the segue is a DDSpaceImageView
        // note segue.destinationController is of type ID, so we need to make sure it's the class we want then create a new variable of the correct type to point to it?
        if ([segue.destinationViewController isKindOfClass:[DDSpaceImageViewController class]]) {
            DDSpaceImageViewController *destinationController = segue.destinationViewController;
            
            // get the indexPath of this cell that was the sender of the message
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            
            // make sure we're in the right section if multple sections!
            // get the appropriate object based on the section we're in
            DDSpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            } else if (path.section == 1) {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            // get the spaceObject at the same index
            NSLog(@"selectedObject: %@", selectedObject);
            destinationController.objectToDisplay = selectedObject;
            NSLog(@"destination.objectToDisplay: %@", destinationController.objectToDisplay);
            
        }
    } else if ([sender isKindOfClass:[NSIndexPath class]]) {
        NSLog(@"SEGUE IS FROM ACCESSORY TRIGGER");
        
        // check the receiver. It should be a DDSpaceDataViewController
        if ([segue.destinationViewController isKindOfClass: [DDSpaceDataViewController class]]){
            DDSpaceDataViewController *spaceDataController = segue.destinationViewController;
            NSIndexPath *path = sender;     // need to type this to an NSIndexPath
            
            // need to make sure we target the objects in the correct section
            DDSpaceObject *selectedObject;
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            } else if (path.section == 1) {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            spaceDataController.spaceObject = selectedObject;
        }
    }
    
    // if we're going to the addSpaceObject view, make this class the delegate of that view, so it can receive messages from that view.
    if ([segue.destinationViewController isKindOfClass:[DDAddSpaceObjectViewController class]]) {
        DDAddSpaceObjectViewController *addObjectController = segue.destinationViewController;
        addObjectController.delegate = self;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([self.addedSpaceObjects count]) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 1) {
        return [self.addedSpaceObjects count];
    } else {
        return [self.planets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    //    cell.textLabel.text = @"whoa... my first table view!";
    //    cell.textLabel.text = [NSString stringWithFormat:@"Section: %i   Row: %i", indexPath.section, indexPath.row];
    
    if (indexPath.section == 0) {
        //        NSLog(@"--[DDMainViewController cellForRowAtIndexPath] RETURNING ORIG SPACE OBJECT");
 
        // populate the current cell of our table
        DDSpaceObject *object = self.planets[indexPath.row];
        NSLog(@"[cellForRowAtPath]   planetObject: %@", object.name);
        cell.textLabel.text = object.name;
        cell.detailTextLabel.text = object.nickname;
        cell.imageView.image = object.image;
    } else {
        // return the addedSpaceObject for this row
        // assuming these are also of type DDSpaceObject...
        DDSpaceObject *newObject = self.addedSpaceObjects[indexPath.row];
        //        NSLog(@"--[DDMainViewController cellForRowAtIndexPath] RETURNING ADDED SPACE OBJECT: %@, %@, %f", newObject.name, newObject.nickname, newObject.diameter );
        cell.textLabel.text = newObject.name;
        cell.detailTextLabel.text = newObject.nickname;
        cell.imageView.image = newObject.image;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:.5 alpha:1];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // only the rows in section 1 should be editable
    if (indexPath.section == 1) return YES;
    else return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n [Main commitEditingStyle]");
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source. Does this need to happen before the actual row in the tableView is deleted?
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        
        // update the NSUserDefaults stored array to reflect the current contents
        // note you need to overwrite the whole stored array. Don't just save each object individually via [self saveSpaceObject] cuz it won't remove the one we just deleted...
        NSMutableArray *convertedSpaceObjects = [[NSMutableArray alloc]init];
        for (DDSpaceObject *spaceObject in self.addedSpaceObjects) {
            [convertedSpaceObjects addObject:[self spaceObjectAsDictionary:spaceObject]];
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:convertedSpaceObjects forKey:ADDED_SPACE_OBJECTS_KEY];
        [defaults synchronize];
        
        //(This line was part of the boilerplate. Deletes the row from the table)
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"DDSpaceDataViewController: Accessory button tapped at row: %i", indexPath.row);
    // trigger the segue manually. How do we do it via storyboard?
    // interesting that sender can be anything. Doesn't have to refer to the actual object sending the message (e.g. the TableViewCell)
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
    
}


#pragma mark - DDAddSpaceObjectViewController Delegate

-(void)didCancel {
    NSLog(@"[MainViewController didCancel]");
    // dismiss this view
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // not necessary here. just want to see evidence of reload without having to create new object
    [self.tableView reloadData];

}

-(void)addSpaceObject:(DDSpaceObject *)aSpaceObject {
    NSLog(@"[MainTableViewController addSpaceObject: %@]", aSpaceObject);
    // add the new space object to our array
    [self.addedSpaceObjects addObject:aSpaceObject];
    
    // save our new object to NSUserDefaults so we can keep it upon quitting
    [self saveSpaceObject:aSpaceObject];
    
    // This method dismisses the view controller presented by this object (self), which in this case is the AddObjectViewController.
    // since self presented it, self is responsible for getting rid of it.
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
}

#pragma mark - helper methods

-(void)defaultSpaceObjectsFromData {
    // creates the default spaceObjects from our data file
    NSArray *allPlanets = [AstronomicalData allKnownPlanets];
    for (NSDictionary *planetData in allPlanets) {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        DDSpaceObject *planetObject = [[DDSpaceObject alloc] initWithData:planetData image:[UIImage imageNamed:imageName]];
        
        [self.planets addObject:planetObject];
        NSLog(@"planet object: %@", planetObject);
    }
}

-(void)loadSavedSpaceObjects {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *storedArray = [defaults objectForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *spaceObjectDict in storedArray) {
        // make spaceObject from of the dictionary
        DDSpaceObject *addedObject = [self spaceObjectFromDictionary:spaceObjectDict];
        [self.addedSpaceObjects addObject:addedObject];
    }
}

-(void)saveSpaceObject:(DDSpaceObject *)aSpaceObject {
    // store the added object in NSDefaults so we can recall it even when the app is closed.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Get the array for our key if it already exists (or an empty array if not?)
    // Make it mutable so we can add to it. Objects returned from NSUserDefaults are not mutable, no matter how they were stored.
    // We get an array of spaceObjects which are Dictionaries
    NSMutableArray *storedArray = [[defaults arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if (!storedArray) {
        storedArray = [[NSMutableArray alloc]init];
    }
    
    // add this object to the stored array after converting it to an NSDictionary
    NSDictionary *convertedSpaceObject = [self spaceObjectAsDictionary:aSpaceObject];
    [storedArray addObject:convertedSpaceObject];
    
    // set our new array to NSUserDefaults. Guessing this overwrites the previous one...
    [defaults setObject:storedArray forKey:ADDED_SPACE_OBJECTS_KEY];
    // syncs what's in memory and what's on disk. Used here to force a write of data. Note this also gets called automatically at intervals.
    [defaults synchronize];
}

- (DDSpaceObject *)spaceObjectFromDictionary:(NSDictionary *)aDictionary {
    UIImage *img = [UIImage imageWithData: aDictionary[PLANET_IMAGE]];
    return [[DDSpaceObject alloc] initWithData:aDictionary image:img];

//    UIImage *img = [UIImage imageWithData: spaceObjectDict[PLANET_IMAGE]];
//    DDSpaceObject *addedObject = [[DDSpaceObject alloc] initWithData:spaceObjectDict image:img];
}

- (NSDictionary *)spaceObjectAsDictionary:(DDSpaceObject *)aSpaceObject {
    // convert SpaceObject into a NSDictionary which is suitable for a property list
    NSMutableDictionary *dict = [@{} mutableCopy]; // [[NSMutableDictionary alloc]init];
    dict[PLANET_NAME] = aSpaceObject.name;
    dict[PLANET_GRAVITY] = @(aSpaceObject.gravity);
    dict[PLANET_DIAMETER] = @(aSpaceObject.diameter);
    dict[PLANET_YEAR_LENGTH] = @(aSpaceObject.yearLength);
    dict[PLANET_DAY_LENGTH] = @(aSpaceObject.dayLength);
    dict[PLANET_TEMPERATURE] = @(aSpaceObject.temperature);
    dict[PLANET_NUMBER_OF_MOONS] = @(aSpaceObject.numberOfMoons);
    dict[PLANET_INTERESTING_FACT] = aSpaceObject.interestingFact;
    dict[PLANET_NICKNAME] = aSpaceObject.nickname;
    
    // Make sure this object has an image before trying to save it. Otherwise we get errors trying to assign it to the dictionary
    if (aSpaceObject.image != nil) {
        // Note this is a C function. That's why it uses parentheses instead of objective-c method brackets.
        NSData *imageData = UIImagePNGRepresentation(aSpaceObject.image);
        dict[PLANET_IMAGE] = imageData;
    }
    
    // Not sure if i need to return immutable version of the dictionary since it's a subclass of NSDictionary.
    //    return [dict copy];
    return dict;
}


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
