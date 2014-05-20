//
//  LBHPhoneCell.m
//  LBHKit
//
//  Created by Kevin Hallmark on 10/29/13.
//  Copyright (c) 2013 Little Black Hat. All rights reserved.
//

#import "LBHPhoneCell.h"

@implementation LBHPhoneCell

// Cell's default height.
+ (CGFloat)height {
	
	return 352 /* Either return a fixed value or get it from the nib file. */;
}

- (id)init
{
	self = [super init];
	if (self) {
		self.numberEntry.text = @"";
		self.phoneValue = @"";
		
		[self.contentView setUserInteractionEnabled: NO];
	}
	
	return self;
}

- (void)configureWithObject:(NSManagedObject *)object fieldDict:(NSDictionary *)fieldDict {
	[super configureWithObject:object fieldDict:fieldDict];
	
	//NSString *value = [object valueForKey:[fieldDict objectForKey:@"id"]];
	
	self.fieldName = [fieldDict objectForKey:@"id"];
	self.numberEntry.text = @"";//value;
}

- (IBAction)buttonPressedDown:(id)sender {
	[sender setBackgroundColor:[UIColor phonePadHighlightColor]];
}

- (IBAction)clearBackgroundColor:(id)sender {
	[sender setBackgroundColor:[UIColor whiteColor]];
}

- (IBAction)numericButtonPressed:(UIButton *)sender {

	NSMutableString *newText = self.phoneValue.mutableCopy;
	
	[newText appendString:sender.titleLabel.text];
	
	[self.delegate.data setValue:newText forKey:self.fieldName];
	
	self.phoneValue = newText;
	
	self.numberEntry.text = [self formatPhone:newText];
	
	[self flashButton:sender];
}

- (IBAction)clearButtonPressed:(id)sender {
	self.numberEntry.text = self.phoneValue = @"";
	
	[self flashButton:sender];
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
	NSString *newText = [self.phoneValue substringToIndex:self.phoneValue.length-1];
	
	self.phoneValue = newText;
	
	self.numberEntry.text = [self formatPhone:newText];
	
	[self flashButton:sender];
}

- (NSString *)formatPhone:(NSString *)phone {
	
	NSInteger length = phone.length;
	
	NSMutableString *newPhone = [NSMutableString string];
	
	for (int i = 0; i < length; ++i)
	{
		if (i == 0) {
			[newPhone appendString:@"("];
		}
		
		if (i == 6) {
			[newPhone appendString:@"-"];
		}
		
		[newPhone appendString:[phone substringWithRange:NSMakeRange(i, 1)]];
		
		if (i == 2) {
			[newPhone appendString:@") "];
		}
	}

	return newPhone;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	return YES;
}

- (IBAction)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
		NSLog(@"Long Press");
    }
}

- (void) flashButton:(UIButton *)button {
	double delayInSeconds = 0.1;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[button setBackgroundColor:[UIColor whiteColor]];
	});
}

@end
