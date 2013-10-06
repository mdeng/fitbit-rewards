//
//  AppDelegate.m
//  fitbit-rewards
//
//  Created by Rhed Shi on 10/5/13.
//  Copyright (c) 2013 Rhed Shi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FriendsViewController.h"
#import "GiftsViewController.h"
#import "PlusViewController.h"
#import "LoginViewController.h"

NSString *const SessionStateChangeNotification = @"com.facebook.FitBit+:SessionStateChangeNotification";

@interface AppDelegate ()

@property (strong, nonatomic) UINavigationController *navigationController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *main_nvc = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    main_nvc.navigationBar.barTintColor = [UIColor colorWithRed:85.0/256 green:194.0/256 blue:194.0/256 alpha:1.0];
    main_nvc.navigationBar.tintColor = [UIColor whiteColor];
    main_nvc.navigationBar.topItem.title = @"Profile";
    main_nvc.tabBarItem.title = @"Profile";
    main_nvc.tabBarItem.image = [UIImage imageNamed:@"me-white"];
    self.navigationController = main_nvc;
    [array addObject:main_nvc];
    
    FriendsViewController *friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];
    UINavigationController *friends_nvc = [[UINavigationController alloc] initWithRootViewController:friendsViewController];
    friends_nvc.navigationBar.barTintColor = [UIColor colorWithRed:85.0/256 green:194.0/256 blue:194.0/256 alpha:1.0];
    friends_nvc.navigationBar.tintColor = [UIColor whiteColor];
    friends_nvc.navigationBar.topItem.title = @"Friends";
    friends_nvc.tabBarItem.title = @"Friends";
    friends_nvc.tabBarItem.image = [UIImage imageNamed:@"friends-white"];
    [array addObject:friends_nvc];
    
    GiftsViewController *giftsViewController = [[GiftsViewController alloc] initWithNibName:@"GiftsViewController" bundle:nil];
    UINavigationController *gifts_nvc = [[UINavigationController alloc] initWithRootViewController:giftsViewController];
    gifts_nvc.navigationBar.barTintColor = [UIColor colorWithRed:85.0/256 green:194.0/256 blue:194.0/256 alpha:1.0];
    gifts_nvc.navigationBar.tintColor = [UIColor whiteColor];
    gifts_nvc.navigationBar.topItem.title = @"Gifts";
    gifts_nvc.tabBarItem.title = @"Gifts";
    gifts_nvc.tabBarItem.image = [UIImage imageNamed:@"gift-white"];
    [array addObject:gifts_nvc];
    
    PlusViewController *plusViewController = [[PlusViewController alloc] initWithNibName:@"PlusViewController" bundle:nil];
    UINavigationController *plus_nvc = [[UINavigationController alloc] initWithRootViewController:plusViewController];
    plus_nvc.navigationBar.barTintColor = [UIColor colorWithRed:85.0/256 green:194.0/256 blue:194.0/256 alpha:1.0];
    plus_nvc.navigationBar.tintColor = [UIColor whiteColor];
    plus_nvc.navigationBar.topItem.title = @"Add";
    plus_nvc.tabBarItem.title = @"Add";
    plus_nvc.tabBarItem.image = [UIImage imageNamed:@"plus-white"];
    [array addObject:plus_nvc];
    
    self.tabViewController = [[UITabBarController alloc] init];
    self.tabViewController.viewControllers = array;
    self.tabViewController.tabBar.tintColor = [UIColor colorWithRed:85.0/256 green:194.0/256 blue:194.0/256 alpha:1.0];
    
    self.window.rootViewController = self.tabViewController;
    
    [self.window makeKeyAndVisible];
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [self openSession];
    }
    else {
        [self showLogin];
    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSession.activeSession handleDidBecomeActive];
}

-(void)showLogin
{
    UIViewController *topViewController = [self.navigationController topViewController];
    UIViewController *presentedViewController = [topViewController presentedViewController];
    
    if (![presentedViewController isKindOfClass:[LoginViewController class]]) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [topViewController presentViewController:loginViewController animated:NO completion:nil];
    } else {
        LoginViewController *loginViewController = (LoginViewController *)presentedViewController;
        [loginViewController loginFailed];
    }
    
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            UIViewController *topViewController =
            [self.navigationController topViewController];
            if ([[topViewController presentedViewController]
                 isKindOfClass:[LoginViewController class]]) {
                [topViewController dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [self.navigationController popToRootViewControllerAnimated:NO];
            [FBSession.activeSession closeAndClearTokenInformation];
            [self showLogin];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SessionStateChangeNotification object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

@end
