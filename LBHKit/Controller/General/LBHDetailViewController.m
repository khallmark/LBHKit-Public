//
//  SM_CompaniesDetailViewController.m
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 3/24/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//
#import "LBHAppDelegate.h"
#import "LBHDetailViewController.h"
#import "LBHTableViewCell.h"
#import "LBHLabelTextFieldCell.h"
#import "LBHSwitchCell.h"
#import "LBHPhoneCell.h"
#import "LBHTimeSliderCell.h"


#define kPickerAnimationDuration 0.40

@implementation LBHDetailViewController


- (NSArray *) fields {
	if (!_fields) {
		_fields = [[LBHAppDelegate current] fieldsForScreen:self.sectionName];
	}
	
	return _fields;
}

- (NSArray *) sections {
	if (!_sections) {
		_sections = [[LBHAppDelegate current] sectionsForScreen:self.sectionName];
	}
	
	return _sections;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.data = [[NSMutableDictionary alloc] init];
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.dateFormatter = [[NSDateFormatter alloc] init];
	[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	//self.managedObjectContext = [LBHAppDelegate current].managedObjectContext;
	
	self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
	
	[self.managedObjectContext rollback];
	[self.delegate detailsViewControllerDidCancel:self];
}


- (IBAction)save:(id)sender {

	
	[self saveObject];
	
	
	[self.delegate detailsViewControllerDidSave:self];
}

- (void)saveObject {
	
}

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

/*
 * Asks the data source to return the titles for the sections for a table view.
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return self.sections;
}

/*
 * Asks the data source to return the index of the section having the given title and section title index.
 */
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
	return index;
}

/**
 * Asks the data source for the title of the header of the specified section of the table view.
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if (self.sections.count) {
		NSArray *sectionArray = [self.fields objectAtIndex:section];
		
		if (sectionArray.count) {
			return [self.sections objectAtIndex:section];
		}
	}
	
	
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *fieldDict = [[self.fields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

	NSString *identifier = [fieldDict objectForKey:@"cell_identifier"];

	CGFloat height;
	
	if ([identifier isEqualToString:@"phoneCell"]) {
		height = [LBHPhoneCell height];
	} else if ([identifier isEqualToString:@"timeSliderCell"]) {
		height = [LBHTimeSliderCell height];
	} else  {
		height = [LBHTableViewCell height];
	}
	
	return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//Where we configure the cell in each row
	
	NSDictionary *fieldDict = [[self.fields objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	UITableViewCell *cell = nil;
	
	
	
	NSString *identifier = [fieldDict objectForKey:@"cell_identifier"];
	
	if([identifier hasPrefix:@"custom"]) {
		cell = [self getCustomCellForFieldDict:fieldDict inTableView:tableView atIndexPath:indexPath];
	} else if ([identifier isEqualToString:@"phoneCell"]) {
		cell = [self getPhoneCellForFieldDict:fieldDict inTableView:tableView atIndexPath:indexPath];
	} else if ([identifier isEqualToString:@"timeSliderCell"]) {
		cell = [self getSliderCellForFieldDict:fieldDict inTableView:tableView atIndexPath:indexPath];
	} else if ([identifier isEqualToString:@"switchCell"]) {
		cell = [self getSwitchCellForFieldDict:fieldDict inTableView:tableView atIndexPath:indexPath];
	} else {
		cell = [self getLabelTextCellForFieldDict:fieldDict inTableView:tableView atIndexPath:indexPath];
	}
	
	return cell;
}


- (LBHTimeSliderCell *) getSliderCellForFieldDict:(NSDictionary *)fieldDict inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = [fieldDict objectForKey:@"cell_identifier"];
	
	LBHTimeSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if (cell == nil) {
		cell = [[LBHTimeSliderCell alloc] init];
		
		// Configure the cell.
		[cell configureWithObject:self.object fieldDict:fieldDict];
		cell.delegate = self;
		
		cell.numericField.tag = [self tagForEditFieldAtIndexPath:indexPath];
	}

	return cell;
}


- (LBHPhoneCell *) getPhoneCellForFieldDict:(NSDictionary *)fieldDict inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = [fieldDict objectForKey:@"cell_identifier"];
	
	LBHPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if (cell == nil) {
		cell = [[LBHPhoneCell alloc] init];
		
		// Configure the cell.
		[cell configureWithObject:self.object fieldDict:fieldDict];
		cell.delegate = self;
	}
	
	return cell;
}

- (LBHLabelTextFieldCell *) getCustomCellForFieldDict:(NSDictionary *)fieldDict inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (LBHLabelTextFieldCell *) getLabelTextCellForFieldDict:(NSDictionary *)fieldDict inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = [fieldDict objectForKey:@"cell_identifier"];
	
	
	
	LBHLabelTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelTextCell"];
	
	if (cell == nil) {
		cell = [[LBHLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"labelTextCell"];
	}
	
	id value = [self.object valueForKey:[fieldDict objectForKey:@"id"]];
	
	NSString *text = nil;
	if ([value isKindOfClass:[NSDate class]]) {
		text = [self.dateFormatter stringFromDate:value];
	} else if (![value isKindOfClass:[NSString class]]) {
		text = [value stringValue];
	} else {
		text = value;
	}
	
	
	cell.label.text = [fieldDict objectForKey:@"name"];
	
	NSString *editable = [fieldDict objectForKey:@"uneditable"];
	
	if (nil != editable && [editable isEqualToString:@"1"]) {
		cell.textField.enabled = NO;
	} else {
		cell.textField.enabled = YES;
	}
	
	cell.textField.fieldName = [fieldDict objectForKey:@"id"];
	cell.textField.text = text;
	cell.textField.tag = [self tagForEditFieldAtIndexPath:indexPath];
	
	
	if ([identifier isEqualToString:@"datePickerCell"]) {
		
		UIDatePicker *datePicker = [[UIDatePicker alloc] init];
		
		datePicker.datePickerMode = UIDatePickerModeDate;
		
		if (value) {
			datePicker.date = (NSDate *)value;
		} else {
			datePicker.date = [NSDate date];
		}
		
		[datePicker addTarget:self action:@selector(dateChangedAction:) forControlEvents:UIControlEventValueChanged];
		
		
		cell.textField.inputView = datePicker;
	} else if ([identifier isEqualToString:@"pickerCell"]) {
		
		LBHPickerView *pickerView = [[LBHPickerView alloc] init];
		
		pickerView.delegate = self;
		pickerView.dataSource = self;
		pickerView.showsSelectionIndicator = TRUE;
		
		pickerView.section = [fieldDict objectForKey:@"picker_type"];
		
//		NSArray *preferences = [self.preferences objectForKey:pickerView.section];
		
		cell.textField.text = @"";
//		
//		int i = 0;
//		for (SM_Preference *obj in preferences) {
//			NSInteger myInt = [value intValue];
//			
//			if( myInt == obj.Id){
//				[smPickerView selectRow:i inComponent:0 animated:YES];
//				cell.textField.text = obj.friendlyname;
//				
//				break;
//			}
//			i++;
//		}
		
		
		cell.textField.inputView = pickerView;
	}
	
	return cell;
}

- (LBHSwitchCell *) getSwitchCellForFieldDict:(NSDictionary *)fieldDict inTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = [fieldDict objectForKey:@"cell_identifier"];
	
	LBHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if (cell == nil) {
		cell = [[LBHSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	
	id value = [self.object valueForKey:[fieldDict objectForKey:@"id"]];
	
	cell.label.text = [fieldDict objectForKey:@"name"];
	
	[cell.switchView setOn:[value boolValue] animated:NO];
	cell.switchView.fieldName = [fieldDict objectForKey:@"id"];
	[cell.switchView addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
	
	return cell;
}


- (void)setState:(id)sender {}


#pragma mark - Picker Actions -

- (IBAction)dateChangedAction:(id)sender
{
//	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//	SM_LabelTextFieldCell *cell = (SM_LabelTextFieldCell *)[self.tableView cellForRowAtIndexPath:indexPath];
	
	NSDate *date = ((UIDatePicker *)sender).date;
	
	self.activeField.text = [self.dateFormatter stringFromDate:date];
	
	[self.object setValue:date forKey:self.activeField.fieldName];
}






#pragma mark - UIPickerView DataSource


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(LBHPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [[self.preferences objectForKey:pickerView.section] count];
}

#pragma mark - UIPickerView Delegate



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 30.0;
}

- (NSString *)pickerView:(LBHPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//	SM_Preference *preference = [[self.preferences objectForKey:pickerView.section] objectAtIndex:row];
//	
//	if (preference) {
//		return preference.friendlyname;
//	}
//	
	return nil;
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(LBHPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//	SM_Preference *preference = [[self.preferences objectForKey:pickerView.section] objectAtIndex:row];
//	
//	self.activeField.text = preference.friendlyname;
//
//	[self setPickerData:preference.Id forKey:pickerView.section];
}

- (void) setPickerData:(NSInteger)data forKey:(NSString *)key {}









#pragma mark -
#pragma mark UITextField Delegate Methods
#pragma mark -

- (IBAction)next:(id)sender {
	[self textFieldShouldReturn:self.activeField];
}

- (IBAction)done:(id)sender {
	[self.activeField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	
	LBHTableViewCell *currentCell = (LBHTableViewCell *) textField.superview.superview;
	NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:currentCell];
	
	NSIndexPath *nextIndexPath = [self nextIndexPath:currentIndexPath];
	int tag = [self tagForEditFieldAtIndexPath:nextIndexPath];
	
//	[self.tableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	
	[[self.view viewWithTag:tag] becomeFirstResponder];
	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	LBHTableViewCell *currentCell = (LBHTableViewCell *) textField.superview.superview;
	NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:currentCell];
	
	[self.tableView scrollToRowAtIndexPath:currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	
	BOOL isLastTextField = (textField.tag >= [[self.fields objectAtIndex:0] count]);
	
	self.navigationItem.leftBarButtonItem = nil;
	
	if (isLastTextField) {
		self.navigationItem.rightBarButtonItem = self.doneButton;
		textField.returnKeyType = UIReturnKeyDone;
	} else {
		self.navigationItem.rightBarButtonItem = self.nextButton;
		textField.returnKeyType = UIReturnKeyNext;
	}
	
	if ([textField.inputView isKindOfClass:[UIDatePicker class]]) {
		UIDatePicker *dateView = (UIDatePicker *)textField.inputView;
		textField.text = [self.dateFormatter stringFromDate:dateView.date];
	}
	
	self.activeField = (LBHTextField*)textField;
}


- (void)textFieldDidEndEditing:(LBHTextField *)textField
{
	if (![textField.inputView isKindOfClass:[UIPickerView class]] && ![textField.inputView isKindOfClass:[UIDatePicker class]]) {
		[self.object setValue:textField.text forKey:textField.fieldName];
	}
	
	self.activeField = nil;
	
	self.navigationItem.leftBarButtonItem = self.cancelButton;
	self.navigationItem.rightBarButtonItem = self.saveButton;
}

- (int) tagForEditFieldAtIndexPath:(NSIndexPath *) indexPath {
	int tag = 1; // start from 1 to avoid duplicates at 0
	
	for (int i=0; i<indexPath.section; i++) {
		int tmp = [self tableView:self.tableView numberOfRowsInSection:i];
			tag += tmp;
	}
	
	tag += indexPath.row;
	
	return tag;
}

- (NSIndexPath *) nextIndexPath:(NSIndexPath *) indexPath {
	int numOfSections = [self numberOfSectionsInTableView:self.tableView];
	int nextSection = ((indexPath.section + 1) % numOfSections);
	
	if ((indexPath.row +1) == [self tableView:self.tableView numberOfRowsInSection:indexPath.section]) {
		return [NSIndexPath indexPathForRow:0 inSection:nextSection];
	} else {
		return [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
	}
	
	return nil;
}












//
//
//
//
//
//
//
//
//
//
//
//
//
//- (IBAction)numericButtonPressed:(UIButton *)sender {
//	
//	NSMutableString *newText = self.numberEntry.text.mutableCopy;
//	
//	[newText appendString:sender.titleLabel.text];
//	
//	self.numberEntry.text = newText;
//}
//
//- (IBAction)clearButtonPressed:(id)sender {
//	self.numberEntry.text = @"";
//}
//
//- (IBAction)deleteButtonPressed:(id)sender {
//	
//}




@end
