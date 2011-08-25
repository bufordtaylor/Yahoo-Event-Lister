#import "GenLib.h"

@implementation GenLib

// returns a string like
// 5:30 PM to 7:30 PM
// If an event doesn't end within 24 hours of the start, we add the end date to the end:
// 5:30 PM to May 21, 6:00 PM
+(NSString*) timeRangeStringFrom:(NSDate*)d1 to:(NSDate*)d2 {
    
	NSDateFormatter* timeFmt = [[[NSDateFormatter alloc] init] autorelease];
    [timeFmt setDateFormat:@"h:mm a"];
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];    
    [timeFmt setLocale:locale];
    [timeFmt setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
     
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MMM d"];	
    [dateFormatter setLocale:locale];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
	NSString* endDateStr = @"";
	if ([self needToShowEndDateWithStart:d1 end:d2]) {		
		endDateStr = [[dateFormatter stringFromDate:d2] stringByAppendingString:@", "];
	}
    
    NSString *retString = [[NSString alloc ]initWithFormat:@"%@ to %@%@",
                           [timeFmt stringFromDate:d1],
                           endDateStr, [timeFmt stringFromDate:d2]];
	
	return [retString autorelease];
}

+(BOOL) needToShowEndDateWithStart:(NSDate*)start end:(NSDate*)end {
	NSTimeInterval secsDiff = [end timeIntervalSinceDate:start];
	return (secsDiff >= (60 * 60 * 24));
}

+(NSDate*)utcStringToNSDate:(NSString*)utcstring {
    NSLocale* usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    
    NSDate* date = [dateFormatter dateFromString:utcstring];
    [dateFormatter release];
    [usLocale release];
    return date;
}

// e.g.,
// Tue, Aug 4, 2009
+(NSString *)dateString:(NSDate *)d {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"EEE, MMM d, yyyy"];
	return [dateFormatter stringFromDate:d];
}

// e.g.,
// Sat, May 20, 2011 12:00 PM
+(NSString *)dateAndTimeString:(NSDate *)d {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];    
	[dateFormatter setDateFormat:@"EEE, MMM d, yyyy – h:mm a"];
    NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease];    
    [dateFormatter setLocale:locale];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
	return [dateFormatter stringFromDate:d];
}

@end
