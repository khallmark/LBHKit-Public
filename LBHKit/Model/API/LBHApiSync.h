//
//  SVApiSync.h
//  Ripple
//
//  Created by Kevin Hallmark on 10/21/13.
//  Copyright (c) 2013 Store Vantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBHApiClient.h"

@class LBHApiSync;

@protocol LBHApiSyncDelegate <NSObject>

//- (void) syncFinished:(LBHApiSync *)sync;
//- (void) sync:(LBHApiSync *)sync failedWithError:(NSError*)error;

@end

@interface LBHApiSync : NSObject <LBHApiClientDelegate>

@property (nonatomic, strong) LBHApiClient *client;
@property (nonatomic, strong) id <LBHApiSyncDelegate> delegate;

@end

