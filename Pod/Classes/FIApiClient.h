//
//  FIApiClient.h
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FIApiResponse.h"

@interface FIApiClient : NSObject

typedef void (^ApiSuccessBlock)(id);
typedef void (^ApiFailureBlock)(NSError *);

-(id) initWithBaseURL:(NSString *)theBaseURL;
-(FIApiResponse *) requestWithURL:(NSString *)url;
-(FIApiResponse *) requestWithPath:(NSString *)path;

@property (nonatomic, copy) NSString *baseURL;

@end
