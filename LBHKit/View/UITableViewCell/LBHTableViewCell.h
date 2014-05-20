//
//  LBHTableViewCell.h
//  LBHKit
//
//  Created by Kevin Hallmark on 10/29/13.
//  Copyright (c) 2013 Little Black Hat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LBHDetailViewController.h"

@interface LBHTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIView *content;

// Reuse identifier of this custom cell.
+ (NSString *)reuseIdentifier;

// Cell's default height.
+ (CGFloat)height;

// Init the table cell using a nib file.
- (id)init;

// Configures the subviews of the cell with the given object.
- (void)configureWithObject:(NSManagedObject *)object fieldDict:(NSDictionary *)fieldDict;


@property (strong, nonatomic) NSDictionary *fieldDict;
@property (strong, nonatomic) NSManagedObject *object;

@property (strong, nonatomic) LBHDetailViewController *delegate;
@end
