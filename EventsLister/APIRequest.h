//
//  APIRequest.h
//  EventsLister
//
//  Created by Buford Taylor on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface APIRequest : ASIHTTPRequest {
    
}

- (id)initWithParams:(NSDictionary *)params;
- (BOOL)isSuccess;
- (id)deserializedResponseDataForResponseString:(NSString *)responseFormatString;

@property (nonatomic, retain) NSDictionary *responseDictionary;

@end
