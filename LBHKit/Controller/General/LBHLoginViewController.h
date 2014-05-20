//
//  SVLoginViewController.h
//  Ripple
//
//  Created by Kevin Hallmark on 10/18/13.
//  Copyright (c) 2013 Store Vantage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBHLoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic , strong) IBOutlet UITableView *entryTableView;
@property (nonatomic , strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic , strong) IBOutlet UILabel  *errorLabel;


@property (nonatomic , strong) UITextField *usernameField;
@property (nonatomic , strong) UITextField *passwordField;


@property (nonatomic , strong) IBOutlet UIButton *loginButton;

- (IBAction)login:(id)sender;

- (void)keyboardWillShow:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;

@end
