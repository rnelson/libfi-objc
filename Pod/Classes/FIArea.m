//
//  FIArea.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FIArea.h"

@implementation FIArea

@synthesize databaseId, year, name;

+(FIArea *) parseSingleArea:(FIApiResponse *)responseObject {
	FIArea *area = [[FIArea alloc] init];
	
	// Convert the JSON into a dictionary
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseObject data]
														 options:kNilOptions
														   error:&error];
	if (error) {
		return nil;
	}
	
	area.databaseId = [[json objectForKey:@"id"] intValue];
	area->inspectorId  = [[json objectForKey:@"inspector_id"] intValue];
	area.year = [[json objectForKey:@"year"] intValue];
	area.name = [json objectForKey:@"name"];
	
	return area;
}

+(NSArray *) parseMultipleAreas:(FIApiResponse *)responseObject {
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
		FIArea *area = [[FIArea alloc] init];
		
		area.databaseId = [[dict objectForKey:@"id"] intValue];
		area->inspectorId  = [[dict objectForKey:@"inspector_id"] intValue];
		area.year = [[dict objectForKey:@"year"] intValue];
		area.name = [dict objectForKey:@"name"];
		
		[ret addObject:area];
	}
	
	return ret;
}

-(FIInspector *) inspector {
	return [FIInspector loadById:self->inspectorId];
}

// /api/v1/areas
+(NSArray *) loadAll {
	NSString *path = @"/areas";
	return [FIArea parseMultipleAreas:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/areas/:databaseId
+(FIArea *) loadById:(int)databaseId {
	NSString *path = [NSString stringWithFormat:@"/areas/%d", databaseId];
	return [FIArea parseSingleArea:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/areas/:id/counties
-(NSArray *) counties {
	NSString *path = [NSString stringWithFormat:@"/areas/%d/counties", databaseId];
	return [FICounty parseMultipleCounties:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/areas/year/:year
+(NSArray *) loadByYear:(int)year {
	NSString *path = [NSString stringWithFormat:@"/areas/year/%d", year];
	return [FIArea parseMultipleAreas:[[FoodInspections client]requestWithPath:path]];
}

@end
