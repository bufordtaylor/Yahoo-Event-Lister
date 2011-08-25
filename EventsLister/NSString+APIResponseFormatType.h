//
//  NSString+APIResponseFormatType.h
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_APIResponseFormatType)
+ (NSString *)reponseFormatStringForType:(APIResponseFormatType)type;
+ (APIResponseFormatType)reponseFormatTypeForString:(NSString *)type;

@end
