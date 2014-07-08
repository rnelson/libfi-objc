//
//  FIInspection.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FIInspection.h"

@implementation FIInspection

@synthesize databaseId, firmId, date, inspectionType, businessType, criticalViolations, noncriticalViolations, followup;

-(id) init {
	self = [super init];
	self.date = nil;
	return self;
}

+(FIInspection *) parseSingleInspection:(FIApiResponse *)responseObject {
	FIInspection *inspection = [[FIInspection alloc] init];
	
	// Set up a date formatter to read in the dates
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	
	// Convert the JSON into a dictionary
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseObject data]
														 options:kNilOptions
														   error:&error];
	if (error) {
		return nil;
	}
	
	inspection.databaseId = [[json objectForKey:@"id"] intValue];
	inspection.firmId = [[json objectForKey:@"firm_id"] intValue];
	inspection.date = [dateFormatter dateFromString:[json objectForKey:@"inspection_date"]];
	inspection.inspectionType = [[json objectForKey:@"inspection_type"] intValue];
	inspection.businessType = [[json objectForKey:@"business_type"] intValue];
	inspection.criticalViolations = [[json objectForKey:@"critical_violations"] intValue];
	inspection.noncriticalViolations = [[json objectForKey:@"noncritical_violations"] intValue];
	inspection.followup = [[json objectForKey:@"followup"] intValue] == 1 ? YES : NO;
	
	return inspection;
}

+(NSArray *) parseMultipleInspections:(FIApiResponse *)responseObject {
	NSMutableArray *ret = [[NSMutableArray alloc] init];
	
	// Set up a date formatter to read in the dates
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	
	// Convert the JSON into a dictionary
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseObject data]
														 options:kNilOptions
														   error:&error];
	if (error) {
		NSLog(@"%@", error); // /api/v1/inspections breaks, leaving this to show that
		return nil;
	}
	
	for (NSDictionary *dict in json) {
		FIInspection *inspection = [[FIInspection alloc] init];
		
		inspection.databaseId = [[dict objectForKey:@"id"] intValue];
		inspection.firmId = [[dict objectForKey:@"firm_id"] intValue];
		inspection.date = [dateFormatter dateFromString:[dict objectForKey:@"inspection_date"]];
		inspection.inspectionType = [[dict objectForKey:@"inspection_type"] intValue];
		inspection.businessType = [[dict objectForKey:@"business_type"] intValue];
		inspection.criticalViolations = [[dict objectForKey:@"critical_violations"] intValue];
		inspection.noncriticalViolations = [[dict objectForKey:@"noncritical_violations"] intValue];
		inspection.followup = [[dict objectForKey:@"followup"] intValue] == 1 ? YES : NO;
		
		[ret addObject:inspection];
	}
	
	return ret;
}

-(FIFirm *) firm {
	return [FIFirm loadById:self.firmId];
}

// /api/v1/inspections
//+(NSArray *) loadAll {
//	NSString *path = @"/inspections";
//	return [FIInspection parseMultipleInspections:[[FoodInspections client]requestWithPath:path]];
//}

// /api/v1/inspections/:databaseId
+(FIInspection *) loadById:(int)databaseId {
	NSString *path = [NSString stringWithFormat:@"/inspections/%d", databaseId];
	return [FIInspection parseSingleInspection:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/inspections/for/:firm.databaseId
+(NSArray *) loadAllForFirm:(FIFirm *)firm {
	return [FIInspection loadAllForFirmByFirmId:firm.firmId];
}

// /api/v1/inspections/for/:firmId
+(NSArray *) loadAllForFirmByFirmId:(int)firmId {
	NSString *path = [NSString stringWithFormat:@"/inspections/for/%d", firmId];
	return [FIInspection parseMultipleInspections:[[FoodInspections client]requestWithPath:path]];
}

@end
