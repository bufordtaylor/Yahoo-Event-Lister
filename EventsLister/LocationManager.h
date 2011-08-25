//
//  LocationManager.h
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate 
@required
- (void)locationUpdate:(CLLocation *)location; // Our location updates are sent here
- (void)locationError:(NSError *)error; // Any errors are sent here
@end

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locMgr;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locMgr;
@property (nonatomic, assign) id delegate;

+(NSString*) parseAPIData:(NSDictionary*)data;

@end
