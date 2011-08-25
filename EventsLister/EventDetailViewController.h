//
//  EventDetailViewController.h
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Event.h"
#import <MapKit/MapKit.h>

@interface EventDetailViewController : UIViewController <MKMapViewDelegate> {
    IBOutlet UILabel* name;
    IBOutlet UILabel* venue;
    IBOutlet UILabel* date;
    IBOutlet MKMapView *mapView;
    Event* event;
}

-(id)initWithEvent:(Event*) e;


@end
