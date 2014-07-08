//
//  Inspector.h
//  libfi
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodInspections.h"

@class FIArea;
@class FICounty;

@interface FIInspector : NSObject

@property (nonatomic) int databaseId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *state;

+(FIInspector *) parseSingleInspection:(FIApiResponse *)responseObject;
+(NSArray *) parseMultipleInspections:(FIApiResponse *)responseObject;

+(NSArray *) loadAll;
+(FIInspector *) loadById:(int)databaseId;

-(NSArray *) counties;

@end
