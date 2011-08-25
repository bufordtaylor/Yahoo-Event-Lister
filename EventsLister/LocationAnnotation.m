//
//  LocationAnnotation.m
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationAnnotation.h"

@implementation LocationAnnotation
@synthesize name = _name;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)named coordinate:(CLLocationCoordinate2D)coordinated {
    if ((self = [super init])) {
        _name = named;
        _coordinate = coordinated;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

@end
