//
//  EventsListerViewController.m
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventsListerViewController.h"
#import "Event.h"
#import "EventListingCell.h"
#import "APIRequest.h"
#import "APIRequestGeo.h"
#import "NetworkQueue.h"
#import "CustomMBProgressHUD.h"
#import "LocationViewController.h"
#import "EventDetailViewController.h"
#import "LocationManager.h"

@implementation EventsListerViewController

@synthesize eventArray = _eventArray;
@synthesize CLManager = _CLManager;

- (void)didReceiveMemoryWarning
{
    DLog(@"mem warning");
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - 
#pragma mark UITableViewDatasource / UITableViewDelegate methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_eventArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Event *event = (Event*)[_eventArray objectAtIndex:indexPath.row];
    EventListingCell* cell = [EventListingCell cellForTableView:tableView];
	[cell setupWithEvent:event];
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [CustomMBProgressHUD showWithMessage:@"One Sec" detailMessage:@"Loading Gorgeous Detail View"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Event* e = (Event*)[_eventArray objectAtIndex:indexPath.row];
    EventDetailViewController* detailViewController = [[EventDetailViewController alloc] initWithEvent:e];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75;
}


#pragma mark - LocationViewControllerDelegate Methods

-(void) startLocationSearch:(NSString*)location{
    [self getEventsForLocation:location];
}

#pragma mark - Event Methods
-(void) getEventsForLocation:(NSString*)location {
    DLog(@"location %@", location);
    [CustomMBProgressHUD showWithMessage:[NSString stringWithFormat:@"Loading events", location] detailMessage:nil];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSString stringWithFormat:@"select * from upcoming.events where location=%@", location] forKey:@"q"];
    __block APIRequest* req = [[APIRequest alloc] initWithParams:dict];
    [req setCompletionBlock:^(void) {
        NSMutableArray* eventList = [Event parseAPIData:req.responseDictionary];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.yahoo.eventslister" object:eventList];
        [CustomMBProgressHUD hide];
        
    }];
    [req setFailedBlock:^(void) {
        [CustomMBProgressHUD hide];
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"Terrible Things Have happened!" 
                              message:@"Hey sorry, but we couldn't do what you wanted.  Try a typical 5-digit zip code."
                              delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles:nil];
        [alert show];
        
    }];
    
    [[NetworkQueue sharedNetworkQueue] addOperationAndGo:req];
}

-(void)eventDataUpdate:(NSNotification*)notif {
    NSMutableArray* brandNewEventArray = (NSMutableArray*)[notif object];
    if ([brandNewEventArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"ZzzzZZZzzzzz" 
                              message:@"You're not going to believe this, but we couldn't find any events for you."
                              delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles:nil];
        [alert show];
    }
    if (self.navigationController.topViewController == self) {
        [_eventArray removeAllObjects];
        _eventArray = brandNewEventArray;
        [self.tableView reloadData];
        DLog(@"Found this many events %d", [_eventArray count]);
    }
}

-(void)showLocationPrompt:(id)sender {
    LocationViewController* modalViewController = [[LocationViewController alloc] init];
    [modalViewController setDelegate:self];
    [self presentModalViewController:modalViewController animated:YES];
}

-(void) showGeoError {
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Listen, Ninja" 
                          message:@"Seems like we couldn't get a location on you.  You might have to type it manually. Here's some default events."
                          delegate:nil 
                          cancelButtonTitle:@"OK" 
                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Location Methods

- (void)locationUpdate:(CLLocation *)location {
    [_CLManager.locMgr stopUpdatingLocation];
    [CustomMBProgressHUD showWithMessage:@"One Sec" detailMessage:@"Using magic to find you"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    DLog(@"%f", location.coordinate);
    [dict setValue:[NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude] forKey:@"latlng"];
    
    __block APIRequest* req = [[APIRequestGeo alloc] initWithParams:dict];
    [req setCompletionBlock:^(void) {
        NSString* location = [LocationManager parseAPIData:req.responseDictionary];
        [self getEventsForLocation:location];
        [CustomMBProgressHUD hide];
        
    }];
    [req setFailedBlock:^(void) {
        [CustomMBProgressHUD hide];
        [self showGeoError];
    }];
    
    [[NetworkQueue sharedNetworkQueue] addOperationAndGo:req];
}

- (void)locationError:(NSError *)error {
	DLog(@"error %@", error);
    [CustomMBProgressHUD hide];
    [self showGeoError];
    [self getEventsForLocation:kZipCodeDefault];
}





#pragma mark - View lifecycle

- (void)viewDidLoad
{
    _CLManager = [[LocationManager alloc] init];
    _CLManager.delegate = self;
    [_CLManager.locMgr startUpdatingLocation];
    
    self.navigationItem.title = @"Event List";
    
    UIBarButtonItem *locationButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:@"Find Events" 
                                       style:UIBarButtonItemStylePlain 
                                       target:self 
                                       action:@selector(showLocationPrompt:)];          
    self.navigationItem.rightBarButtonItem = locationButton;
    
    _eventArray = [[NSMutableArray alloc] init];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventDataUpdate:) name:@"com.yahoo.eventslister" object:nil];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"com.yahoo.eventslister" object:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
