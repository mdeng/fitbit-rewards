//
//  LoginViewController.m
//  fitbit-rewards
//
//  Created by Rhed Shi on 10/5/13.
//  Copyright (c) 2013 Rhed Shi. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface LoginViewController ()

- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view from its nib.f
}

- (IBAction)login:(id)sender
{
    [self.activityIndicator startAnimating];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void)loginFailed
{
    [self.activityIndicator stopAnimating];
}

@end
