//
//  LoginViewController.h
//  fitbit-rewards
//
//  Created by Rhed Shi on 10/5/13.
//  Copyright (c) 2013 Rhed Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (void)loginFailed;

@end
