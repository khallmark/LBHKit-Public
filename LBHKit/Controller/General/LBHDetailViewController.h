//
//  SM_DetailViewController.h
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 3/24/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBHObject.h"
#import "LBHPickerView.h"
#import "LBHTextField.h"

@class LBHDetailViewController;

@protocol LBHDetailViewControllerDelegate <NSObject>

- (void)detailsViewControllerDidCancel:(LBHDetailViewController *)controller;
- (void)detailsViewControllerDidSave:(LBHDetailViewController *)controller;

@end

@interface LBHDetailViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>
{
}

@property (nonatomic, strong) NSString *sectionName;

@property (nonatomic, strong) NSArray *fields;
@property (nonatomic, strong) NSArray *sections;

@property (nonatomic, strong) NSMutableDictionary *preferences;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *saveButton;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, strong) NSManagedObject *object;
@property (nonatomic, strong) NSMutableDictionary *data;

@property (nonatomic, weak) id <LBHDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) LBHTextField *activeField;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (IBAction)next:(id)sender;
- (IBAction)done:(id)sender;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction)dateChangedAction:(id)sender;


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


//- (void)setDetailTextLabelForCell:(UITableViewCell *)cell andData:(NSArray *)data atIndexPath:(NSIndexPath *)indexPath;

@end


