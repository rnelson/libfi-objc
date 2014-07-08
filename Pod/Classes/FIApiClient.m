//
//  FIApiClient.m
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import "FIApiClient.h"

@implementation FIApiClient

@synthesize baseURL;

-(id) initWithBaseURL:(NSString *)theBaseURL {
	self = [super init];
	self.baseURL = theBaseURL;
	return self;
}

// url ~= http://foodinspections/api/v1/firms/:id
-(FIApiResponse *) requestWithURL:(NSString *)url {
	FIApiResponse *ret = [[FIApiResponse alloc] init];
	NSError *error;
	NSURL *theURL = [NSURL URLWithString:url];
	
	// Set up a request, specifying that "text/html" is an acceptable response since
	// that's what the API currently sends back
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theURL];
	[request setHTTPMethod:@"GET"];
	[request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
	
	// Make a synchronous request; any async magic is the responsibility of the caller
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
	
	// Depending on if it generated an error or not, fill in the appropriate property
	if (!responseData) {
		ret.error = error;
	}
	else {
		ret.data = responseData;
	}
	
	return ret;
}

// path ~= /firms/:id
-(FIApiResponse *) requestWithPath:(NSString *)path {
	NSString *url = [NSString stringWithFormat:@"%@/%@", baseURL, path];
	return [self requestWithURL:url];
}

@end
