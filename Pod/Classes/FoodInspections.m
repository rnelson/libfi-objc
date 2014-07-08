//
//  FoodInspections.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FoodInspections.h"

@implementation FoodInspections


+(NSString *) kBaseURL {
	static NSString *kBaseURL = nil;
	
	if (nil == kBaseURL) {
		kBaseURL = @"http://foodinspections.opennebraska.io/api/v1";
	}
	
	return kBaseURL;
}

+(FIApiClient *) client {
	static FIApiClient *client = nil;
	
	if (nil == client) {
		client = [[FIApiClient alloc] initWithBaseURL:[FoodInspections kBaseURL]];
	}
	
	return client;
}

@end
