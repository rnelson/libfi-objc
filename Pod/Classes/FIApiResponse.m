//
//  FIApiResponse.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FIApiResponse.h"

@implementation FIApiResponse

@synthesize data, error;

-(id) init {
	self = [super init];
	
	self.data = nil;
	self.error = nil;
	
	return self;
}

@end
