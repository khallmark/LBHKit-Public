//
//  SM_TextFieldCell.h
//  ShockeyMonkey
//
//  Created by Kevin Hallmark on 3/3/13.
//  Copyright (c) 2013 Own Web Now. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBHTextFieldCell : UITableViewCell
{
	IBOutlet UITextField *textField;
}

@property (nonatomic, strong) IBOutlet UITextField *textField;

@end
