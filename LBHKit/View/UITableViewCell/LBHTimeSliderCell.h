//
//  LBHTimeSliderCell.h
//  LBHKit
//
//  Created by Kevin Hallmark on 10/31/13.
//  Copyright (c) 2013 Little Black Hat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBHTableViewCell.h"
#import "LBHDetailViewController.h"

@interface LBHTimeSliderCell : LBHTableViewCell <UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UISlider *timeSlider;
@property (strong, nonatomic) IBOutlet LBHTextField *numericField;
@property (strong, nonatomic) IBOutlet UILabel *minutesLabel;

- (IBAction) sliderValueChanged:(id)sender;

@end
