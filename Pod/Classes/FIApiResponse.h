//
//  FIApiResponse.h
//
//  Created by Ross Nelson on 7/8/14.
//  Copyright (c) 2014 Food Inspections. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FIApiResponse : NSObject

@property (nonatomic, copy) NSData *data;
@property (nonatomic, copy) NSError *error;

@end
