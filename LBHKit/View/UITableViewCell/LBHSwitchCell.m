//
//  SM_SwitchCell.m
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 5/6/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import "LBHSwitchCell.h"

@implementation LBHSwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
