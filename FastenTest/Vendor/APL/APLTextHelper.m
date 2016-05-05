//
//  APLTextHelper.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "APLTextHelper.h"

@implementation NSNumber (Pluralize)

- (NSString *)pluralizedStringWithOne:(NSString *)one few:(NSString *)few many:(NSString *)many
{
    NSInteger value = self.integerValue;
    
    NSMutableString *ret = [NSMutableString stringWithFormat:@"%ld ", (long)value];
    if (value % 10 == 1 && value != 11) {
        [ret appendString:one];
    }
    else if (value % 10 >= 2 && value % 10 <= 4 && (value % 100 < 12 || value % 100 > 14)) {
        [ret appendString:few];
    }
    else {
        [ret appendString:many];
    }
    return ret.copy;
}

@end

@implementation APLTextHelper

+ (NSString *)wordWithCount:(NSNumber *)count one:(NSString *)oneWord two:(NSString *)twoWord five:(NSString *)fiveWord
{
	NSInteger c = [count integerValue]%100;
	NSString *result = @"";
	if (c < 20) {
		if (c%10 == 0) {
			result = fiveWord;
		} else {
			if (c > 10) {
				result = fiveWord;
			} else {
				if (c == 1) {
					result = oneWord;
				} else if (c < 5) {
					result = twoWord;
				} else {
					result = fiveWord;
				}
			}
		}
	} else {
		c = c%10;
		if (c == 1) {
			result = oneWord;
		} else if (c == 0) {
			result = fiveWord;
		} else if (c < 5) {
			result = twoWord;
		} else {
			result = fiveWord;
		}
	}
	return result;
}

+ (NSString *)wordWithSex:(NSInteger)sex male:(NSString *)male female:(NSString *)female
{
	NSString *result = male;
	if (sex == 2) {
		result = female;
	}
	return result;
}

+ (NSString *)secondsWithCount:(int)count
{
	return [self wordWithCount:[NSNumber numberWithInt:count]
						   one:NSLocalizedString(@"секунда", @"секунда")
						   two:NSLocalizedString(@"секунды", @"секунды")
						  five:NSLocalizedString(@"секунд", @"секунд")];
}

+ (NSString *)minutesWithCount:(int)count
{
	return [self wordWithCount:[NSNumber numberWithInt:count]
						   one:NSLocalizedString(@"минута", @"минута")
						   two:NSLocalizedString(@"минуты", @"минуты")
						  five:NSLocalizedString(@"минут", @"минут")];
}

+ (NSString *)hoursWithCount:(int)count
{
	return [self wordWithCount:[NSNumber numberWithInt:count]
						   one:NSLocalizedString(@"час", @"час")
						   two:NSLocalizedString(@"часа", @"часа")
						  five:NSLocalizedString(@"часов", @"часов")];
}

+ (NSString *)daysWithCount:(int)count
{
    return [self wordWithCount:[NSNumber numberWithInt:count]
                           one:NSLocalizedString(@"день", @"день")
                           two:NSLocalizedString(@"дня", @"дня")
                          five:NSLocalizedString(@"дней", @"дней")];
}

+ (NSString *)createdDateStrWithDate:(NSDate *)date
{
	NSString *result = @"";
//	NSTimeInterval serverDelta = [APLStateController serverDelta];
	NSDate *nowDate = [NSDate date];
//	nowDate = [nowDate dateByAddingTimeInterval:serverDelta];
	
	NSTimeInterval createdAtInterval = [nowDate timeIntervalSinceDate:date];
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *createComps = [gregorian components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
	NSInteger createDay = [createComps day];
	NSInteger createMonth = [createComps month];
	NSInteger createYear = [createComps year];
	NSDateComponents *nowComps = [gregorian components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:nowDate];
	NSInteger nowDay = [nowComps day];
	NSInteger nowMonth = [nowComps month];
	NSInteger nowYear = [nowComps year];
	
	NSInteger day = nowDay - createDay;
	NSInteger month = nowMonth - createMonth;
	NSInteger year = nowYear - createYear;
	
	
	if (createdAtInterval < 3) {
		result = NSLocalizedString(@"только что", @"только что");
	} else if (createdAtInterval < 60) {
		result = [NSString stringWithFormat:@"%d %@ %@", (int)createdAtInterval, [self secondsWithCount:(int)createdAtInterval], NSLocalizedString(@"назад", @"назад")];
	} else if (createdAtInterval < 60*60) {
		int minutes = ((int)createdAtInterval)/60;
		result = [NSString stringWithFormat:@"%d %@ %@", minutes, [self minutesWithCount:minutes], NSLocalizedString(@"назад", @"назад")];
	} else if (day < 1 && month == 0 && year == 0) {
		int hours = ((int)createdAtInterval)/(60*60);
		int mins = 0;
		mins = (int)((createdAtInterval - hours*60*60)/60);
		if (mins > 0) {
			result = [NSString stringWithFormat:@"%d %@ %d %@ %@",
					  hours,
					  [self hoursWithCount:hours],
					  mins,
					  [self minutesWithCount:mins],
					  NSLocalizedString(@"назад", @"назад")];
		} else {
			result = [NSString stringWithFormat:@"%d %@ %@",
					  hours,
					  [self hoursWithCount:hours],
					  NSLocalizedString(@"назад", @"назад")];
		}
	} else if (day < 2 && month == 0 && year == 0) {
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		NSString *format = [NSString stringWithFormat:@"%@ %@ HH:mm", NSLocalizedString(@"вчера", @"вчера"), NSLocalizedString(@"в", @"в")];
		[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
		[dateFormatter setDateFormat:format];
		result = [dateFormatter stringFromDate:date];
	} else if (year < 1) {
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		NSString *format = [NSString stringWithFormat:@"d MMMM %@ HH:mm", NSLocalizedString(@"в", @"в")];
		[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
		[dateFormatter setDateFormat:format];
		result = [dateFormatter stringFromDate:date];
	} else {
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		NSString *format = [NSString stringWithFormat:@"d MMMM yyyy %@ HH:mm", NSLocalizedString(@"в", @"в")];
		[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
		[dateFormatter setDateFormat:format];
		result = [dateFormatter stringFromDate:date];
	}
	
	return result;
}

+ (NSString *)createdDateShortStrWithDate:(NSDate *)date
{
	NSString *result = @"";
	//	NSTimeInterval serverDelta = [APLStateController serverDelta];
	NSDate *nowDate = [NSDate date];
	//	nowDate = [nowDate dateByAddingTimeInterval:serverDelta];
	
	NSTimeInterval createdAtInterval = [nowDate timeIntervalSinceDate:date];
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *createComps = [gregorian components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
	NSInteger createDay = [createComps day];
	NSInteger createMonth = [createComps month];
	NSInteger createYear = [createComps year];
	NSDateComponents *nowComps = [gregorian components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:nowDate];
	NSInteger nowDay = [nowComps day];
	NSInteger nowMonth = [nowComps month];
	NSInteger nowYear = [nowComps year];
	
	NSInteger day = nowDay - createDay;
	NSInteger month = nowMonth - createMonth;
	NSInteger year = nowYear - createYear;
	
	if (createdAtInterval < 60) {
		result = [NSString stringWithFormat:@"%d%@", (int)createdAtInterval, NSLocalizedString(@"с", @"секунды")];
	} else if (createdAtInterval < 60*60) {
		int minutes = ((int)createdAtInterval)/60;
		result = [NSString stringWithFormat:@"%d%@", minutes, NSLocalizedString(@"м", @"минуты")];
	} else if (day < 1 && month == 0 && year == 0) {
		int hours = ((int)createdAtInterval)/(60*60);
		result = [NSString stringWithFormat:@"%d%@",
				  hours,
				  NSLocalizedString(@"ч", @"часы")];
	} else if (day < 2 && month == 0 && year == 0) {
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		NSString *format = [NSString stringWithFormat:@"%@", NSLocalizedString(@"вчера", @"вчера")];
		[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
		[dateFormatter setDateFormat:format];
		result = [dateFormatter stringFromDate:date];
	} else if (year < 1) {
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		NSString *format = [NSString stringWithFormat:@"d MMM"];		
		[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
		[dateFormatter setDateFormat:format];
		result = [dateFormatter stringFromDate:date];
	} else {
		NSDateFormatter *dateFormatter = [NSDateFormatter new];
		NSString *format = [NSString stringWithFormat:@"dd.MM.yy"];
		[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
		[dateFormatter setDateFormat:format];
		result = [dateFormatter stringFromDate:date];
	}
	return result;
}

@end
