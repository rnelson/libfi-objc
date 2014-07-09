//
//  FIInspection.h
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodInspections.h"

@class FIFirm;
@class FIInspector;

@interface FIInspection : NSObject

@property (nonatomic) int databaseId;
@property (nonatomic) int firmId;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic) int inspectionType;
@property (nonatomic) int businessType;
@property (nonatomic) int criticalViolations;
@property (nonatomic) int noncriticalViolations;
@property (nonatomic) BOOL followup;

+(FIInspection *) parseSingleInspection:(FIApiResponse *)responseObject;
+(NSArray *) parseMultipleInspections:(FIApiResponse *)responseObject;

+(FIInspection *) loadById:(int)databaseId;
+(NSArray *) loadAllForFirm:(FIFirm *)firm;
+(NSArray *) loadAllForFirmByFirmId:(int)firmId;

-(FIFirm *) firm;

@end
