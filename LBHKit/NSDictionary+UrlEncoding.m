//
//  NSDictionary+UrlEncoding.m
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 4/27/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import "NSDictionary+UrlEncoding.h"

// helper function: get the string form of any object
static NSString *toString(id object) {
	return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
	NSString *string = toString(object);
	return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (UrlEncoding)

-(NSString*) urlEncodedString {
	NSMutableArray *parts = [NSMutableArray array];
	for (id key in self) {
		id value = [self objectForKey: key];
		if (value) {
			NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
			[parts addObject: part];
		}
		
	}
	return [parts componentsJoinedByString: @"&"];
}

@end
