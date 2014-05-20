//
//  SM_CompaniesListViewController.m
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 3/24/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import "LBHListViewController.h"
//#import "SM_ApiSync.h"
#import "Db.h"
#import "LBHAppDelegate.h"
#import "LBHObject.h"
#import "LBHDetailViewController.h"
//#import "SVMainTabBarViewController.h"

#import "DejalActivityView.h"

@interface LBHListViewController ()

- (void) sync;

@property (nonatomic, strong) DejalActivityView *activityView;

@end

@implementation LBHListViewController


- (void) sync {}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.managedObjectContext = [LBHAppDelegate current].managedObjectContext;
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(reload:)
												 name:@"loginSuccessful"
											   object:nil];
	
	[self reload:self];
}

- (IBAction)reload:(id)sender {
	self.tableView.scrollEnabled = FALSE;
	
	//self.activityView = [DejalBezelActivityView activityViewForView:self.tableView withLabel:@"Loading..."];
	
	[self sync];
	
	_fetchedResultsController = nil;
	
	[self.tableView reloadData];
	
	self.tableView.scrollEnabled = TRUE;

}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
	LBHDetailViewController *vc = [segue destinationViewController];
	
	[vc setDelegate:self];
	
	self.detailView = vc;

	vc.managedObjectContext = self.managedObjectContext;
	
	if ([[segue identifier] isEqualToString:@"detailPush"]) {
		
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		
		[vc setObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
	} else if ([[segue identifier] isEqualToString:@"addPush"]) {
		[vc setObject:nil];
	}
}



- (void)detailsViewControllerDidCancel:(LBHDetailViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)detailsViewControllerDidSave:(LBHDetailViewController *)controller {
	//[self sync];
	
	[self.tableView reloadData];
	
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[self.fetchedResultsController sections] count];

}

- (NSString *)tableView:(UITableView *)tableView  titleForHeaderInSection:(NSInteger)section {
	// Display the dates as section headings.
	return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	id <NSFetchedResultsSectionInfo> sectionInfo = nil;
	
	
	sectionInfo = [self.fetchedResultsController sections][section];
	
	return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"listCell";
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (cell == nil) {
		/*
		 * Actually create a new cell (with an identifier so that it can be dequeued).
		 */
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	// Set up the cell, override in subclasses
	[self configureCell:cell atIndexPath:indexPath];
	
	return cell;
}



- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
}







- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
	NSInteger searchOption = controller.searchBar.selectedScopeButtonIndex;
	return [self searchDisplayController:controller shouldReloadTableForSearchString:searchString searchScope:searchOption];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
	NSString* searchString = controller.searchBar.text;
	return [self searchDisplayController:controller shouldReloadTableForSearchString:searchString searchScope:searchOption];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString*)searchString searchScope:(NSInteger)searchOption {
	
	NSPredicate *predicate = nil;
	if ([searchString length]){
		predicate = [self predicateForSearchString:searchString searchScope:searchOption];
	}

	[self.fetchedResultsController.fetchRequest setPredicate:predicate];
	
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
	
	return YES;
}






- (IBAction) logout:(id)sender{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setValue:nil forKey:@"savedUsername"];
	[defaults setValue:nil forKey:@"savedPassword"];
	[defaults setValue:nil forKey:@"savedSite"];
	
	[defaults synchronize];
	
	
	//[[LBHAppDelegate current] shockeyClient].is_authenticated = false;
	
	//UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
	
	//SM_MainTabBarViewController *tabController = [storyboard instantiateViewControllerWithIdentifier:@"mainTabController"];
	
	//[tabController performLoginIfRequired:self];
}



- (NSEntityDescription *)entityDescription {
	return [[NSEntityDescription alloc] init];
}

- (NSFetchRequest *)fetchRequest {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	return fetchRequest;
}

- (NSPredicate *)predicateForSearchString:(NSString *)searchString searchScope:(NSInteger)searchOption {
	NSPredicate *predicate = [[NSPredicate alloc] init];
	
	return predicate;
}

- (NSFetchedResultsController *)fetchedResultsController
{
	if (_fetchedResultsController != nil) {
		return _fetchedResultsController;
	}
	
	NSFetchRequest *fetchRequest = [self fetchRequest];
	
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the section name key path and cache name if appropriate.
	// nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"day" cacheName:nil];
	
	aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
		// Replace this implementation with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _fetchedResultsController;
}




- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
	UITableView *tableView = self.tableView;
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[self.tableView endUpdates];
}























#pragma mark - SM_ApiSyncDelegate Methods
//
//- (void) syncFinished:(SM_ApiSync *)sync {
//	[self load];
//
//	[self.tableView reloadData];
//
//	[self.activityView animateRemove];
//
//	self.tableView.scrollEnabled = TRUE;
//}
//
//- (void) sync:(SM_ApiSync *)sync failedWithError:(NSError *)error {
//	[self.activityView animateRemove];
//
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The data could not be loaded"
//													message:@"Please try again in a few minutes."
//												   delegate:nil
//										  cancelButtonTitle:@"OK"
//										  otherButtonTitles:nil];
//	[alert show];
//
//	self.tableView.scrollEnabled = TRUE;
//}

@end
