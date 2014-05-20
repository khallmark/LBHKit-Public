//
//  SM_SwitchCell.h
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 5/6/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBHSwitch.h"

@interface LBHSwitchCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet LBHSwitch *switchView;

@property (nonatomic, strong) NSString *fieldName;


@end
