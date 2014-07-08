//
//  FICounty.h
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodInspections.h"

@class FIArea;

@interface FICounty : NSObject {
	int areaId;
}

@property (nonatomic) int databaseId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) int year;

+(FICounty *) parseSingleCounty:(FIApiResponse *)responseObject;
+(NSArray *) parseMultipleCounties:(FIApiResponse *)responseObject;

+(NSArray *) loadAll;
+(FICounty *) loadById:(int)databaseId;
+(NSArray *) loadByYear:(int)year;
+(NSArray *) loadByInspectorId:(int)inspectorId;

-(FIArea *) area;

@end
