//
//  Event.h
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject {
    NSString* title;
    NSDate* startDate;
    NSString* venue;
    float latitude;
    float longitude;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* venue;
@property (nonatomic, retain) NSDate* startDate;
@property float latitude;
@property float longitude;

-(id) initWithDataDict:(NSDictionary*)data;
+(NSMutableArray*)parseAPIData:(NSDictionary*)data;


@end
