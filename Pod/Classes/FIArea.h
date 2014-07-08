//
//  FIArea.h
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodInspections.h"

@interface FIArea : NSObject {
	int inspectorId;
}

@property (nonatomic) int databaseId;
@property (nonatomic) int year;
@property (nonatomic, copy) NSString *name;

+(FIArea *) parseSingleArea:(FIApiResponse *)responseObject;
+(NSArray *) parseMultipleAreas:(FIApiResponse *)responseObject;

+(NSArray *) loadAll;
+(FIArea *) loadById:(int)databaseId;
+(NSArray *) loadByYear:(int)year;

-(FIInspector *) inspector;
-(NSArray *) counties;

@end
