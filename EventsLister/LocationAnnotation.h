//
//  LocationAnnotation.h
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface LocationAnnotation : NSObject <MKAnnotation> {
    NSString* name;
    CLLocationCoordinate2D coordinate;
}

@property (copy) NSString* name;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name coordinate:(CLLocationCoordinate2D)coordinate;

@end
