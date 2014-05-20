//
//  SVApiClient.h
//  Ripple
//
//  Created by Kevin Hallmark on 10/21/13.
//  Copyright (c) 2013 Store Vantage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LBHApiClient;
@class LBHObject;

@protocol LBHApiClientDelegate <NSObject>

@required
- (void) clientFinished:(LBHApiClient *)client;
- (void) client:(LBHApiClient *)client failedWithError:(NSError*)error;

@end

@interface LBHApiClient : NSObject


@end



