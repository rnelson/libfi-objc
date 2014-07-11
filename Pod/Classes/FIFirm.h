//
//  FIFirm.h
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FoodInspections.h"
#import "FICoordinate.h"
#import "FIInspection.h"

@interface FIFirm : NSObject

@property (nonatomic) int databaseId;
@property (nonatomic) int firmId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *parentName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic) int totalCritical;
@property (nonatomic) int totalNoncritical;
@property (nonatomic) FICoordinate *coordinate;

+(FIFirm *) parseSingleFirm:(FIApiResponse *)responseObject;
+(NSArray *) parseMultipleFirms:(FIApiResponse *)responseObject;

+(NSArray *) loadAll;
+(FIFirm *) loadById:(int)databaseId;
+(NSArray *) loadByName:(NSString *)name;
+(NSArray *) loadByLatitude:(double)latitude withLongitude:(double)longitude andRadius:(int)radius;
+(NSArray *) loadByBoundingBox:(NSString *)box;
+(NSArray *) loadWithinTop:(double)top andBottom:(double)bottom andLeft:(double)left andRight:(double)right;
+(NSArray *) loadWithinMapView:(MKMapView *)mapView;

-(NSArray *) inspections;

@end
