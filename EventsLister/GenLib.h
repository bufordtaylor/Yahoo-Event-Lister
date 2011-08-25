/**
 Static general functions relating to times and dates
 */

#import <Foundation/Foundation.h>

@interface GenLib : NSObject {

}

+(NSString*) timeRangeStringFrom:(NSDate*)d1 to:(NSDate*)d2;
+(NSString*) dateString:(NSDate*)d;
+(BOOL) needToShowEndDateWithStart:(NSDate*)start end:(NSDate*)end;
+(NSString*) dateAndTimeString:(NSDate*)d;
+(NSDate*)utcStringToNSDate:(NSString*)utcstring;

@end
