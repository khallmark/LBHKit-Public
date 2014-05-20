//
//  SVAppDelegate.h
//  Ripple
//
//  Created by Kevin Hallmark on 10/2/13.
//  Copyright (c) 2013 Store Vantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface LBHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSDictionary *fields;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (LBHAppDelegate *)current;

- (NSArray *) fieldsForScreen:(NSString *)screenName;
- (NSArray *) sectionsForScreen:(NSString *)screenName;

@end
