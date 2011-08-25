//
//  APIRequest.m
//  EventsLister
//
//  Created by Buford Taylor on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "APIRequest.h"
#import "NSDictionary-URLEncoding.h"
#import "NSString+APIResponseFormatType.h"
#import "JSON.h"

@interface APIRequest ()

@end

@implementation APIRequest

@synthesize responseDictionary = _responseDictionary;

- (void)dealloc {
    [super dealloc];
}

- (id)initWithParams:(NSDictionary *)params {
   
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@", kAPIScheme, kAPIRoot];    
    
    NSMutableDictionary *mutableParams = [[params mutableCopy] autorelease];
    [mutableParams setValue:kAPIResponseFormatStringJSON forKey:@"format"];
    
    NSString *paramString = [mutableParams URLEncodedString];
    NSURL *theURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", urlString, paramString]];
    
    if ((self = [super initWithURL:theURL])) {
        self.timeOutSeconds = kAPITimeOutSecods;
    }
    
    DLog(@"Created request wth URL: %@", [self url]);
    
    return self;
}

- (void)requestFinished {
    if (![self isSuccess]) {
        NSString *aUserInfo = [NSString stringWithFormat:@"The request failed: %@ (%d)", [self responseStatusMessage], [self responseStatusCode]];
        [super failWithError:[NSError errorWithDomain:NetworkRequestErrorDomain 
                                                 code:APIGenericUnsuccessfulRequestErrorType 
                                             userInfo:[NSDictionary dictionaryWithObjectsAndKeys:aUserInfo, NSLocalizedDescriptionKey,nil]]];
        
    } else {
        self.responseDictionary = [self deserializedResponseDataForResponseString:kAPIResponseFormatStringJSON];
        [super requestFinished];
    }
}


- (void)failWithError:(NSError *)theError {
    NSError *newError = theError;
    
    DLog(@"Request failed: %@", theError);
    
    if ([theError code] == ASIRequestCancelledErrorType) {
        DLog(@"Request was cancelled");
    }
    
    
    [super failWithError:newError];
}

- (BOOL)isSuccess {
    
    switch ([self responseStatusCode]) {
            // Don't count 404 as failure.
        case 400:
        case 401:            
        case 500:
        case 501:            
        case 502:                        
            return NO;
            break;
            
        default:
            break;
    }
    
    return YES;
}

- (id)deserializedResponseDataForResponseString:(NSString *)responseFormatString {
    APIResponseFormatType type = [NSString reponseFormatTypeForString:responseFormatString];
    NSError *anError = nil;
    BOOL didFail = NO;
    NSString *errorMessage = nil;
    id deserializedData = nil;
    
    switch (type) {
        case APIResponseFormatTypeJSON:
            deserializedData = [self.responseString JSONValue];
            
            break;
            
        case APIResponseFormatTypeBinaryPlist:
        case APIResponseFormatTypeXMLPlist:
            
            if (![self responseData]) {
                DLog(@"responseData is not defined");
                return nil;
            }
            else {
                deserializedData = [NSPropertyListSerialization propertyListWithData:[self responseData]
                                                                             options:0
                                                                              format:NULL 
                                                                               error:&anError];
            }            
            break;
            
        default:
            break;
    }
    
    if (anError) {
        didFail = YES;
        DLog(@"Could not deserialize plist: %@", [anError localizedDescription]);
        errorMessage = [NSString stringWithFormat:@"There was a problem talking to the server: %@", [anError localizedDescription]];
    }
    
    if (didFail) {
        [self failWithError:[NSError errorWithDomain:NetworkRequestErrorDomain 
                                                code:APIGenericUnsuccessfulRequestErrorType 
                                            userInfo:[NSDictionary dictionaryWithObjectsAndKeys:errorMessage, NSLocalizedDescriptionKey,nil]]];
        
        return nil;
    }
    else {    
        return deserializedData;
    }
}

@end
