//
//  DDSpaceDataViewController.m
//  Out of this World
//
//  Created by DDD on 2013-11-02.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import "DDSpaceDataViewController.h"

@interface DDSpaceDataViewController ()

@end

@implementation DDSpaceDataViewController

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
    NSLog(@"[DDSpaceDataViewController viewDidLoad]");
	// Do any additional setup after loading the view.
    
    // note self.view sits behind the tableView. The view property is inherited form UIViewController.
    self.view.backgroundColor = [UIColor blackColor];
    // tableView is the UITableView property we defined in the header
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // note both the delegate and datasource assignment need to be present in order to see anything in the tableview. Commented below cuz we've also set it in the storyboard as per the video. Just wanted to see if either way would work.
    //    self.tableView.delegate = self;
    //    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"[DDSpaceDataViewController cellForRowAtIndexPath] indexPath: %@", indexPath);
    
    // why does this need to be static?
    static NSString *CellIdentifier = @"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //    cell.textLabel.text = @"some data...";
    //    cell.detailTextLabel.text = @"some details...";
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Nickname:";
            cell.detailTextLabel.text = self.spaceObject.nickname;
            break;
        case 1:
            cell.textLabel.text = @"Diameter (km):";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.diameter];
            break;
        case 2:
            cell.textLabel.text = @"Gravity:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.gravity];
            break;
        case 3:
            cell.textLabel.text = @"Year Length:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.yearLength];
            break;
        case 4:
            cell.textLabel.text = @"Day Length:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.dayLength];
            break;
        case 5:
            cell.textLabel.text = @"Temperature:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", self.spaceObject.temperature];
            break;
        case 6:
            cell.textLabel.text = @"Number of Moons:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%i", self.spaceObject.numberOfMoons];
            break;
        case 7:
            cell.textLabel.text = @"Interesting Fact:";
            cell.detailTextLabel.text = self.spaceObject.interestingFact;
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"[DDSpaceDataViewController numberOfRowsInSection] section: %@", section);
    return 8;
}

#pragma mark - UITableViewDelegate

//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"DDSpaceDataViewController accessoryButtonTappedForRowWithIndexPath] section: %@", indexPath.row);
//    
//}

@end
