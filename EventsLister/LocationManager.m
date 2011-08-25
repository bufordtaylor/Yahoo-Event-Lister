//
//  LocationManager.m
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

@synthesize locMgr = _locMgr;
@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _locMgr = [[CLLocationManager alloc] init];
		_locMgr.delegate = self; 
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if([self.delegate conformsToProtocol:@protocol(LocationManagerDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		[self.delegate locationUpdate:newLocation];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if([self.delegate conformsToProtocol:@protocol(LocationManagerDelegate)]) {  // Check if the class assigning itself as the delegate conforms to our protocol.  If not, the message will go nowhere.  Not good.
		[self.delegate locationError:error];
	}
}

+(NSString*) parseAPIData:(NSDictionary*)data {
    NSString* zip = kZipCodeDefault;  //might as well default to this
    
    NSMutableArray* resultsLevel = [data objectForKey:@"results"];
    if(resultsLevel){
        @try {
            NSDictionary* dict = [resultsLevel objectAtIndex:0];
            NSMutableArray* addressLevel = [dict objectForKey:@"address_components"];
            for (NSDictionary* innerDict in addressLevel) {
                NSArray* inceptionLevelArray = [innerDict objectForKey:@"types"];  //we must go deeper
                if ([[inceptionLevelArray objectAtIndex:0] isEqualToString:@"postal_code"]) {
                    zip = [innerDict objectForKey:@"long_name"];
                }
            }
        }
        @catch (NSException *exception) {
            DLog(@"Exception thrown: %@", exception);
        }
    }
    return zip;
    
}

@end
