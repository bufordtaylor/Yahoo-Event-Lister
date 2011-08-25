//
//  APIRequestGeo.m
//  EventsLister
//
//  Created by Buford Taylor on 7/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "APIRequestGeo.h"
#import "NSDictionary-URLEncoding.h"

@implementation APIRequestGeo

//?latlng=37.45820,-122.422

- (id)initWithParams:(NSDictionary *)params {
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@", kAPIScheme, kAPIRootGeo];    
    
    NSMutableDictionary *mutableParams = [[params mutableCopy] autorelease];
    
    NSString *paramString = [mutableParams URLEncodedString];
    NSURL *theURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@&sensor=false", urlString, paramString]];
    
    if ((self = [super initWithURL:theURL])) {
        self.timeOutSeconds = kAPITimeOutSecods;
    }
    
    DLog(@"Created request wth URL: %@", [self url]);
    
    return self;
}
@end
