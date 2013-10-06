//
//  MainViewController.m
//  fitbit-rewards
//
//  Created by Rhed Shi on 10/5/13.
//  Copyright (c) 2013 Rhed Shi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface MainViewController ()

- (void)logoutPressed:(id)sender;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfile;
@property (strong, nonatomic) IBOutlet UILabel *userName;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutPressed:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateChanged:) name:SessionStateChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

- (void)logoutPressed:(id)sender
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)sessionStateChanged:(id)sender
{
    [self populateUserDetails];
}

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.userName.text = user.name;
                 self.userProfile.profileID = user.id;
             }
         }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
