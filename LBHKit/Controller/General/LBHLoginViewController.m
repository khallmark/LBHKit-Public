//
//  SVLoginViewController.m
//  Ripple
//
//  Created by Kevin Hallmark on 10/18/13.
//  Copyright (c) 2013 Store Vantage. All rights reserved.
//

#import "LBHLoginViewController.h"
#import "LBHAppDelegate.h"
#import "LBHTextFieldCell.h"
#import "LBHButtonCell.h"

@interface LBHLoginViewController ()

@property (nonatomic, strong) NSArray *fields;
@property (nonatomic, strong) UITextField *activeField;

@end

@implementation LBHLoginViewController


@synthesize fields;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	LBHAppDelegate *appDelegate = [LBHAppDelegate current];
	
	self.fields = [appDelegate fieldsForScreen:@"login"];
	
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	// register for keyboard notifications
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification
											   object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification
												  object:nil];
}

#pragma mark -
#pragma mark Base View Methods
#pragma mark -


- (IBAction)login:(id)sender {}





#pragma mark -
#pragma mark UITableViewDataSource Methods
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.fields count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[self.fields objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//Where we configure the cell in each row
	
	NSDictionary *fieldDict = [[self.fields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	NSString *identifier = [fieldDict objectForKey:@"cell_identifier"];
	
	
	if ([identifier isEqual: @"textCell"]) {
		LBHTextFieldCell *cell;
		
		cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) {
			cell = [[LBHTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		}
		// Configure the cell... setting the text of our cell's label
		cell.textField.placeholder = [fieldDict objectForKey:@"name"];
		cell.textField.tag = [self tagForEditFieldAtIndexPath:indexPath];
		cell.textField.delegate = self;
		
		if ([[fieldDict objectForKey:@"id"] isEqualToString:@"username"]) {
			self.usernameField = cell.textField;
			cell.textField.secureTextEntry = NO;
		} else if ([[fieldDict objectForKey:@"id"] isEqualToString:@"password"]) {
			self.passwordField = cell.textField;
			cell.textField.secureTextEntry = YES;
			
		}
		
		return cell;
	} else if ([identifier isEqual: @"buttonCell"]) {
		LBHButtonCell *cell;
		
		cell = [tableView dequeueReusableCellWithIdentifier:identifier];
		if (cell == nil) {
			cell = [[LBHButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
		}
		
		[cell.button setTitle:[fieldDict objectForKey:@"name"] forState: UIControlStateNormal];
		
		return cell;
	}
	
	return nil;
}



#pragma mark -
#pragma mark UITableViewDelegate Methods
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark -
#pragma mark UITextField Delegate Methods
#pragma mark -



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	
	LBHTextFieldCell *currentCell = (LBHTextFieldCell *) textField.superview.superview;
	NSIndexPath *currentIndexPath = [self.entryTableView indexPathForCell:currentCell];
	
	NSIndexPath *nextIndexPath = [self nextIndexPath:currentIndexPath];
	int tag = [self tagForEditFieldAtIndexPath:nextIndexPath];
	
	//[self.entryTableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	
	[[self.view viewWithTag:tag] becomeFirstResponder];
	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	BOOL isLastTextField = (textField.tag > [[self.fields objectAtIndex:0] count]);
	
	if (isLastTextField) {
		textField.returnKeyType = UIReturnKeyDone;
	} else {
		textField.returnKeyType = UIReturnKeyNext;
	}
	
	self.activeField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
	self.activeField = nil;
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWillShow:(NSNotification*)aNotification
{
	NSDictionary* info = [aNotification userInfo];
	CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
	UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
	self.scrollView.contentInset = contentInsets;
	self.scrollView.scrollIndicatorInsets = contentInsets;
	
	// If active text field is hidden by keyboard, scroll it so it's visible
	// Your application might not need or want this behavior.
	CGRect aRect = self.view.frame;
	aRect.size.height -= kbSize.height;
	//if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
		CGPoint scrollPoint = CGPointMake(0.0, kbSize.height-self.activeField.superview.frame.origin.y-40);
		[self.scrollView setContentOffset:scrollPoint animated:YES];
	//}
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
	self.scrollView.contentInset = contentInsets;
	self.scrollView.scrollIndicatorInsets = contentInsets;
}




- (int) tagForEditFieldAtIndexPath:(NSIndexPath *) indexPath {
	int tag = 1; // start from 1 to avoid duplicates at 0
	
	for (int i=0; i<indexPath.section; i++) {
		int tmp = [self tableView:self.entryTableView numberOfRowsInSection:i];
		tag += tmp;
	}
	
	tag += indexPath.row;
	
	return tag;
}

- (NSIndexPath *) nextIndexPath:(NSIndexPath *) indexPath {
	int numOfSections = [self numberOfSectionsInTableView:self.entryTableView];
	int nextSection = ((indexPath.section + 1) % numOfSections);
	
	if ((indexPath.row +1) == [self tableView:self.entryTableView numberOfRowsInSection:indexPath.section]) {
		return [NSIndexPath indexPathForRow:0 inSection:nextSection];
	} else {
		return [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
	}
}



@end
