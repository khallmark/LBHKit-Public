//
//  LBHTimeSliderCell.m
//  LBHKit
//
//  Created by Kevin Hallmark on 10/31/13.
//  Copyright (c) 2013 Little Black Hat. All rights reserved.
//

#import "LBHTimeSliderCell.h"
#import "LBHTextFieldCell.h"

@implementation LBHTimeSliderCell

// Cell's default height.
+ (CGFloat)height {
	
	return 45 /* Either return a fixed value or get it from the nib file. */;
}

- (IBAction) sliderValueChanged:(UISlider *)slider {
	[slider setValue:((int)((slider.value + 2.5) / 5) * 5) animated:NO];
	
	
	self.numericField.text = [NSString stringWithFormat:@"%g", slider.value];
	
	[self.delegate.data setValue:[NSNumber numberWithFloat:slider.value*60] forKey:self.numericField.fieldName];
}

- (void)configureWithObject:(NSManagedObject *)object fieldDict:(NSDictionary *)fieldDict {
	[super configureWithObject:object fieldDict:fieldDict];
	self.numericField.fieldName = [fieldDict objectForKey:@"id"];
	
	if (object) {
		NSNumber *value = [object valueForKey:[fieldDict objectForKey:@"id"]];
		
		self.numericField.text = [value stringValue];
		self.timeSlider.value = [value floatValue];
	}
	
}

- (void)setDelegate:(LBHDetailViewController *)delegate {
	[super setDelegate:delegate];
	
	//self.numericField.delegate = self;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self.delegate textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(LBHTextField *)textfield {
	self.timeSlider.value = [[textfield text] floatValue];
	
	[self.delegate textFieldDidEndEditing:textfield];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	return [self.delegate textFieldShouldReturn:textField];
	
}
@end
