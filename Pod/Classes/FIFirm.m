//
//  FIFirm.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FIFirm.h"

@implementation FIFirm

@synthesize databaseId, firmId, name, parentName, address, totalCritical, totalNoncritical, coordinate, inspections;

-(id) init {
	self = [super init];
	self.coordinate = [[FICoordinate alloc] init];
	return self;
}

+(FIFirm *) parseSingleFirm:(FIApiResponse *)responseObject {
	FIFirm *firm = [[FIFirm alloc] init];
	
	// Convert the JSON into a dictionary
	NSError *error;
	NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[responseObject data]
														 options:kNilOptions
														   error:&error];
	if (error) {
		return nil;
	}

	firm.databaseId = [[json objectForKey:@"id"] intValue];
	firm.firmId = [[json objectForKey:@"firm_id"] intValue];
	firm.name = [json objectForKey:@"name"];
	firm.parentName = [json objectForKey:@"parent_name"];
	firm.address = [json objectForKey:@"address"];
	firm.totalCritical = [[json objectForKey:@"total_critical"] intValue];
	firm.totalNoncritical = [[json objectForKey:@"total_noncritical"] intValue];
	firm.coordinate.latitude = [[json objectForKey:@"lat"] doubleValue];
	firm.coordinate.longitude = [[json objectForKey:@"lng"] doubleValue];
	firm.inspections = [FIInspection loadAllForFirmByFirmId:firm.firmId];
	
	return firm;
}

+(NSArray *) parseMultipleFirms:(FIApiResponse *)responseObject {
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
		FIFirm *firm = [[FIFirm alloc] init];
		
		firm.databaseId = [[dict objectForKey:@"id"] intValue];
		firm.firmId = [[dict objectForKey:@"firm_id"] intValue];
		firm.name = [dict objectForKey:@"name"];
		firm.parentName = [dict objectForKey:@"parent_name"];
		firm.address = [dict objectForKey:@"address"];
		firm.totalCritical = [[dict objectForKey:@"total_critical"] intValue];
		firm.totalNoncritical = [[dict objectForKey:@"total_noncritical"] intValue];
		firm.coordinate.latitude = [[dict objectForKey:@"lat"] doubleValue];
		firm.coordinate.longitude = [[dict objectForKey:@"lng"] doubleValue];
		firm.inspections = [FIInspection loadAllForFirmByFirmId:firm.firmId];
		
		[ret addObject:firm];
	}
	
	return ret;
}

// /api/v1/firms
+(NSArray *) loadAll {
	NSString *path = @"/firms";
	return [FIFirm parseMultipleFirms:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/firms/:databaseId
+(FIFirm *) loadById:(int)databaseId {
	NSString *path  = [NSString stringWithFormat:@"/firms/%d", databaseId];
	return [FIFirm parseSingleFirm:[[FoodInspections client] requestWithPath:path]];
}

// /api/v1/firms/name/:name
+(NSArray *) loadByName:(NSString *)name {
	NSString *path = [NSString stringWithFormat:@"/firms/name/%@", name];
	return [FIFirm parseMultipleFirms:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/firms/in/:latitude/:longitude/:radius
+(NSArray *) loadByLatitude:(double)latitude withLongitude:(double)longitude andRadius:(int)radius {
	NSString *path = [NSString stringWithFormat:@"/firms/in/%f/%f/%d", latitude, longitude, radius];
	return [FIFirm parseMultipleFirms:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/firms/bbox/:box
+(NSArray *) loadByBoundingBox:(NSString *)box {
	NSString *path = [NSString stringWithFormat:@"/firms/bbox/%@", box];
	return [FIFirm parseMultipleFirms:[[FoodInspections client]requestWithPath:path]];
}

// /api/v1/firms/bbox/:top,:left,:bottom,:right
+(NSArray *) loadWithinTop:(double)top andBottom:(double)bottom andLeft:(double)left andRight:(double)right {
	NSString *box = [NSString stringWithFormat:@"%f,%f,%f,%f", top, bottom, left, right];
	return [self loadByBoundingBox:box];
}

+(NSArray *) loadWithinMapView:(MKMapView *)mapView {
	CGPoint nePoint, swPoint;
	CLLocationCoordinate2D neCoord, swCoord;
	
	// Find the lat/long of the map bounds
	nePoint = CGPointMake(mapView.bounds.origin.x + mapView.bounds.size.width, mapView.bounds.origin.y);
	swPoint = CGPointMake((mapView.bounds.origin.x), (mapView.bounds.origin.y + mapView.bounds.size.height));
	neCoord = [mapView convertPoint:nePoint toCoordinateFromView:mapView];
	swCoord = [mapView convertPoint:swPoint toCoordinateFromView:mapView];
	
	return [FIFirm loadWithinTop:neCoord.latitude andBottom:swCoord.latitude andLeft:swCoord.longitude andRight:neCoord.longitude];
}

@end
