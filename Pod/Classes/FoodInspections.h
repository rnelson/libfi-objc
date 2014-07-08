//
//  FoodInspections.h
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIApiClient.h"
#import "FIFirm.h"
#import "FIInspection.h"
#import "FIInspector.h"
#import "FICounty.h"
#import "FIArea.h"

@interface FoodInspections : NSObject

+(NSString *) kBaseURL;
+(FIApiClient *) client;

@end
