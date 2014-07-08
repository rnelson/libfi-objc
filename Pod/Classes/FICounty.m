//
//  FICounty.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FICounty.h"

@implementation FICounty

@synthesize databaseId, name, year;

+(FICounty *) parseSingleCounty:(FIApiResponse *)responseObject {
	FICounty *county = [[FICounty alloc] init];
	
	// Convert the JSON into a dictionary
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseObject data]
														 options:kNilOptions
														   error:&error];
	if (error) {
		return nil;
	}
	
	county.databaseId = [[json objectForKey:@"id"] intValue];
	county.name = [json objectForKey:@"name"];
	county->areaId = [[json objectForKey:@"area_id"] intValue];
	county.year = [[json objectForKey:@"year"] intValue];
	
	return county;
}

+(NSArray *) parseMultipleCounties:(FIApiResponse *)responseObject {
	NSMutableArray *ret = [[NSMutableArray alloc] init];
	
	// Convert the JSON into a dictionary
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseObject data]
														 options:kNilOptions
														   error:&error];
	if (error) {
		return nil;
	}
	
	for (NSDictionary *dict in json) {
		FICounty *county = [[FICounty alloc] init];
		
		county.databaseId = [[dict objectForKey:@"id"] intValue];
		county.name = [dict objectForKey:@"name"];
		county->areaId = [[dict objectForKey:@"area_id"] intValue];
		county.year = [[dict objectForKey:@"year"] intValue];
		
		[ret addObject:county];
		
	}
	
	return ret;
}

-(FIArea *) area {
	return [FIArea loadById:self->areaId];
}

// /api/v1/counties
+(NSArray *) loadAll {
	NSString *path = @"/counties";
	return [FICounty parseMultipleCounties:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/counties/:databaseId
+(FICounty *) loadById:(int)databaseId {
	NSString *path = [NSString stringWithFormat:@"/counties/%d", databaseId];
	return [FICounty parseSingleCounty:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/counties/year/:year
+(NSArray *) loadByYear:(int)year {
	NSString *path = [NSString stringWithFormat:@"/counties/year/%d", year];
	return [FICounty parseMultipleCounties:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/counties/inspector/:inspectorId
+(NSArray *) loadByInspectorId:(int)inspectorId {
	NSString *path = [NSString stringWithFormat:@"/counties/inspector/%d", inspectorId];
	return [FICounty parseMultipleCounties:[[FoodInspections client]requestWithPath:path]];
}

@end
