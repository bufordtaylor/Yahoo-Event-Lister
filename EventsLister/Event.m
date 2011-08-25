//
//  Event.m
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Event.h"
#import "GenLib.h"

@implementation Event

@synthesize title = _title;
@synthesize venue = _venue;
@synthesize startDate = _startDate;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

-(id) initWithDataDict:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _title = [data objectForKey:@"name"];
        _latitude = [[data objectForKey:@"latitude"] floatValue];
        _longitude = [[data objectForKey:@"longitude"] floatValue];
        _venue = [NSString stringWithFormat:@"%@, %@", [data objectForKey:@"venue_address"], [data objectForKey:@"venue_city"]];
        _startDate = [GenLib utcStringToNSDate:[data objectForKey:@"utc_start"]];
    }
    
    return self;
}


+(NSMutableArray*)parseAPIData:(NSDictionary*)data{
    NSMutableArray* eventArray = [[NSMutableArray alloc] init];
    NSMutableDictionary* queryLevel = [data objectForKey:@"query"];
    if(queryLevel){
        NSMutableDictionary* resultLevel = [queryLevel objectForKey:@"results"];
        if (resultLevel) {
            @try {
                for (NSDictionary* dict in [resultLevel objectForKey:@"event"]) {
                    Event* e = [[Event alloc] initWithDataDict:dict];
                    [eventArray addObject:e];
                }
            }
            @catch (NSException *exception) {
                DLog(@"Exception thrown: %@", exception);
            }
        }
    }
    return eventArray;
}

@end
