//
//  LBHTableViewCell.m
//  LBHKit
//
//  Created by Kevin Hallmark on 10/29/13.
//  Copyright (c) 2013 Little Black Hat. All rights reserved.
//

#import "LBHTableViewCell.h"

@implementation LBHTableViewCell

#pragma mark -
#pragma mark Class methods


// Return the reuse identifier of this custom cell.
+ (NSString *)reuseIdentifier {
	
	return NSStringFromClass([self class]);
}


// Return the name of the nib file to use to init the content view.
+ (NSString *)nibName {
	
	return NSStringFromClass([self class]);
	// Or you can even use this:
	//return [self reuseIdentifier]];
}


// Cell's default height.
+ (CGFloat)height {
	
	return 43 /* Either return a fixed value or get it from the nib file. */;
}


#pragma mark -
#pragma mark Configuring the cell


// Init the table cell using a nib file.
- (id)init {
	
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	NSString *identifier = NSStringFromClass([self class]);
	
	if ((self = [super initWithStyle:style reuseIdentifier:identifier])) {
		
		NSString *nibName = [[self class] nibName];
		if (nibName) {
			
			NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"LBHKit" withExtension:@"framework"]];

			//NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.LittleBlackHat.LBHKit"];
			
			[bundle loadNibNamed:nibName
						   owner:self
						 options:nil];
						
			NSAssert(self.content != nil, @"NIB file loaded but content property not set.");
						
			[self addSubview:self.content];
		}
	}
	return self;
}

// Configures the subviews of the cell with the given object.
- (void)configureWithObject:(NSManagedObject *)object fieldDict:(NSDictionary *)fieldDict {
	self.fieldDict = fieldDict;
	self.object = object;
	
	
//	self.textLabel.text = @"My Title";
//	self.detailTextLabel.text = @"My detail text";
	// self.imageView.image = [object myGreatImageToDisplay];
}

@end
