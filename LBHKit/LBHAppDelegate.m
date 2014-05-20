//
//  SVAppDelegate.m
//  Ripple
//
//  Created by Kevin Hallmark on 10/2/13.
//  Copyright (c) 2013 Store Vantage. All rights reserved.
//

#import "LBHAppDelegate.h"
#import "LBHLoginViewController.h"

@implementation LBHAppDelegate

@synthesize window = _window;
@synthesize fields = _fields;

@synthesize managedObjectContext = _managedObjectContext;

+ (LBHAppDelegate *)current {
	return (LBHAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"fields" ofType:@"plist"];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
	
	self.fields = dict;
		
	//[self performLoginIfRequired:self.window.rootViewController];
	
	
	return YES;
}

- (NSArray *)fieldsForScreen:(NSString *)screenName {
	NSDictionary *screen = [self.fields objectForKey:screenName];
	
	if (screen) {
		return [screen objectForKey:@"fields"];
	}
	
	return nil;
}

- (NSArray *) sectionsForScreen:(NSString *)screenName {
	NSDictionary *screen = [self.fields objectForKey:screenName];
	
	if (screen) {
		return [screen objectForKey:@"sections"];
	}
	
	return nil;
}
@end
