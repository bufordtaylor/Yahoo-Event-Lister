//
//  EventDetailViewController.m
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Event.h"
#import "GenLib.h"
#import "CustomMBProgressHUD.h"
#import "LocationAnnotation.h"

#define METERS_PER_MILE 1609.344

@implementation EventDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithEvent:(Event*) e {
    if ([super init]) {
        event = e;
        // Custom initialization
    }
    return self;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    name.text = event.title;
    venue.text = event.venue;
    date.text = [GenLib dateAndTimeString:event.startDate];
    CLLocationCoordinate2D location;
    location.longitude = event.longitude;
    location.latitude = event.latitude;
    
    LocationAnnotation* locAnno = [[LocationAnnotation alloc] initWithName:event.title coordinate:location];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
    [mapView addAnnotation:locAnno];

    
    [CustomMBProgressHUD hide];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
