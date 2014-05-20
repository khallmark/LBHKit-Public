//
//  LBHPhoneCell.h
//  LBHKit
//
//  Created by Kevin Hallmark on 10/29/13.
//  Copyright (c) 2013 Little Black Hat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBHTableViewCell.h"

@interface LBHPhoneCell : LBHTableViewCell <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *numberEntry;

@property (strong, nonatomic) IBOutlet UIButton *button1;

- (IBAction)numericButtonPressed:(UIButton *)sender;
- (IBAction)clearButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;

- (IBAction)buttonPressedDown:(id)sender;


- (IBAction)clearBackgroundColor:(id)sender;
- (IBAction)longPress:(UILongPressGestureRecognizer*)gesture;


@property (strong, nonatomic) NSString *fieldName;
@property (strong, nonatomic) NSString *phoneValue;
@end
