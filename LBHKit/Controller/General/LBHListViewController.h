//
//  SM_CompaniesListViewController.h
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 3/24/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBHDetailViewController.h"
#import "LBHApiSync.h"
#import "LBHTableViewCell.h"

@interface LBHListViewController : UITableViewController <LBHDetailViewControllerDelegate,NSFetchedResultsControllerDelegate>
{
	@protected NSString *_sortOrder;
	@protected NSArray *_sections;
	
	@protected NSDictionary *_preferences;
	
	@protected NSArray *_data;
}

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) LBHDetailViewController *detailView;

@property (nonatomic, strong) IBOutlet UISegmentedControl *sortControl;

@property (nonatomic, strong) NSString *sortOrder;
@property (nonatomic, strong) NSDictionary *preferences;

- (IBAction)reload:(id)sender;





- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (NSFetchRequest *)fetchRequest;
- (NSPredicate *)predicateForSearchString:(NSString *)searchString searchScope:(NSInteger)searchOption;
@end
