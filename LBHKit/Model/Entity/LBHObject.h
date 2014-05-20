//
//  SM_Object.h
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 4/4/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface LBHObject : NSManagedObject
{
	BOOL needSync;
	BOOL dirty;
}

@property (nonatomic) BOOL needSync;
@property (nonatomic) BOOL dirty;

@end
