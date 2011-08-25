//
//  Settings.h
//  EventsLister
//
//  Created by Buford Taylor on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

typedef enum APINetworkErrorType {
    APIGenericUnsuccessfulRequestErrorType = 100,
} APINetworkErrorType;

#define kAPIResponseFormatStringJSON @"json"
#define kAPIResponseFormatStringXMLPlist @"plist"
#define kAPIResponseFormatStringBinaryPlist @"bplist"

typedef enum {
    APIResponseFormatTypeJSON,
    APIResponseFormatTypeXMLPlist,
    APIResponseFormatTypeBinaryPlist
} APIResponseFormatType;

#define kAPIScheme @"http"
#define kAPIRoot @"query.yahooapis.com/v1/public/yql"

#define kAPIRootGeo @"maps.google.com/maps/api/geocode/json"

#define kAPITimeOutSecods 60

#define kZipCodeDefault @"94301"

