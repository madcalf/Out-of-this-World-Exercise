//
//  DDSpaceImageViewController.m
//  Out of this World
//
//  Created by DDD on 2013-10-29.
//  Copyright (c) 2013 DDD. All rights reserved.
//

#import "DDSpaceImageViewController.h"

@interface DDSpaceImageViewController ()

@end

@implementation DDSpaceImageViewController

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

    // see if we correctly assigned an object during the segue
    NSLog(@"objectToDisplay: %@", self.objectToDisplay);
    
    // create the ImageView with an image assigned to it.
    // Note we're creating this one purely in code, not via Storyboard
    // so it won't be visible until we add it to a view
    self.imageView = [[UIImageView alloc] initWithImage: self.objectToDisplay.image];
    // set the scrollView size to match our image size so they can scroll the whole image
    self.scrollView.contentSize = self.imageView.frame.size;
    
    // add our imageView to our scrollView
    [self.scrollView addSubview:self.imageView];
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.minimumZoomScale = .1;
    // center the image in the view
    self.imageView.center = self.scrollView.center;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UIScrollViewDelegate methods
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

// this gets called while zooming, whenever the zoom changes.
-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
  //  NSLog(@"SpaceImgageViewController.scrollViewDidZoom()");
    // keep the image centered. Later change this to center if image is smaller than the scrollView
    self.imageView.center = self.scrollView.center;
}

// this gets called when zooming stops
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"Zoom is done! scaled view: %@,  scale: %f", view, scale );
}

@end
