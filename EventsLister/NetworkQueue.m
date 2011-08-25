//
//  NetworkQueue.m
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "SynthesizeSingleton.h"


@interface NetworkQueue()
@property (nonatomic, assign) BOOL lastRequestDidFail;
@end

@implementation NetworkQueue
SYNTHESIZE_SINGLETON_FOR_CLASS(NetworkQueue);

@synthesize lastRequestDidFail = _lastRequestDidFail;

- (void)addOperationAndGo:(NSOperation *)op {
    self.lastRequestDidFail = NO;
    [self addOperation:op];
    
    // We actually do want to cancel all operations on a failed connection, but since a canceled-request counts
    // as a failure, we'll override the requestFailed to handle that condition.
    [self setShouldCancelAllRequestsOnFailure:NO];
    
    [self go];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *theError = [request error];
    
    // If the failure wasn't a result of a cancellation, stop all pending operations
    if ([theError code] != ASIRequestCancelledErrorType) {
        self.lastRequestDidFail = YES;
        [self cancelAllOperations];
    }
    
    [super requestFailed:request];
}

@end
