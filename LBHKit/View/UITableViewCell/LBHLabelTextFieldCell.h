//
//  SM_LabelTextFieldCell.h
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 4/6/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBHTableViewCell.h"

@class LBHTextField;

@interface LBHLabelTextFieldCell : LBHTableViewCell

@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet LBHTextField *textField;

@end
