//
//  AppDelegate.h
//  fitbit-rewards
//
//  Created by Rhed Shi on 10/5/13.
//  Copyright (c) 2013 Rhed Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

extern NSString *const SessionStateChangeNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabViewController;

- (void)openSession;

@end
