//
//  NetworkQueue.h
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASINetworkQueue.h"

@interface NetworkQueue : ASINetworkQueue


+ (NetworkQueue *)sharedNetworkQueue;
- (void)addOperationAndGo:(NSOperation *)op;

@property (nonatomic, readonly, assign) BOOL lastRequestDidFail;
@end
