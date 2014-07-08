//
//  FIInspector.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FIInspector.h"

@implementation FIInspector

@synthesize databaseId, name, location, contact, state;

+(FIInspector *) parseSingleInspection:(FIApiResponse *)responseObject {
	FIInspector *inspector = [[FIInspector alloc] init];
	
	// Convert the JSON into a dictionary
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseObject data]
														 options:kNilOptions
														   error:&error];
	if (error) {
		return nil;
	}
	
	inspector.databaseId = [[json objectForKey:@"id"] intValue];
	inspector.name = [json objectForKey:@"name"];
	inspector.location = [json objectForKey:@"location"];
	inspector.contact = [json objectForKey:@"contact"];
	inspector.state = [json objectForKey:@"state"];
	
	return inspector;
}

+(NSArray *) parseMultipleInspections:(FIApiResponse *)responseObject {
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
		FIInspector *inspector = [[FIInspector alloc] init];
		
		inspector.databaseId = [[dict objectForKey:@"id"] intValue];
		inspector.name = [dict objectForKey:@"name"];
		inspector.location = [dict objectForKey:@"location"];
		inspector.contact = [dict objectForKey:@"contact"];
		inspector.state = [dict objectForKey:@"state"];
		
		[ret addObject:inspector];
	}
	
	return ret;
}

// /api/v1/inspectors
+(NSArray *) loadAll {
	NSString *path = @"/inspectors";
	return [FIInspector parseMultipleInspections:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/inspector/:databaseId
+(FIInspector *) loadById:(int)databaseId {
	NSString *path = [NSString stringWithFormat:@"/inspectors/%d", databaseId];
	return [FIInspector parseSingleInspection:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/inspectors/:databaseId/counties
-(NSArray *) counties {
	return [FICounty loadByInspectorId:self.databaseId];
}

@end
