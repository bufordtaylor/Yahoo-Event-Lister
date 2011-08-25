
//
//  NSString+APIResponseFormatType.m
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+APIResponseFormatType.h"

@implementation NSString (NSString_APIResponseFormatType)
+ (NSString *)reponseFormatStringForType:(APIResponseFormatType)type {
    NSString *retString = nil;
    
    switch (type) {
        case APIResponseFormatTypeJSON:
            retString = kAPIResponseFormatStringJSON;
            break;
            
        case APIResponseFormatTypeXMLPlist:
            retString = kAPIResponseFormatStringXMLPlist;
            break;
            
        case APIResponseFormatTypeBinaryPlist:
            retString = kAPIResponseFormatStringBinaryPlist;
            break;
            
        default:
            break;
    }
    
    return retString;
}

+ (APIResponseFormatType)reponseFormatTypeForString:(NSString *)string {
    APIResponseFormatType retType = -1;
    
    if ([string isEqualToString:kAPIResponseFormatStringJSON]) {
        retType = APIResponseFormatTypeJSON;
    }
    else if ([string isEqualToString:kAPIResponseFormatStringXMLPlist]) {
        retType = APIResponseFormatTypeXMLPlist;
    }
    else if ([string isEqualToString:kAPIResponseFormatStringBinaryPlist]) {
        retType = APIResponseFormatTypeBinaryPlist;
    }
    
    return retType;
}

@end
