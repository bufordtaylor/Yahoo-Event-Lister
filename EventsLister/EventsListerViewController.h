//
//  EventsListerViewController.h
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"
#import "LocationManager.h"

@interface EventsListerViewController :UITableViewController <LocationViewControllerDelegate, LocationManagerDelegate> {
    NSMutableArray* eventArray;
    LocationManager *CLManager;
}

@property (nonatomic, retain) NSMutableArray* eventArray;
@property (nonatomic, retain) LocationManager* CLManager;

-(void) getEventsForLocation:(NSString*)location;


@end
