//
//  AppDelegate.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 11/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navController;
    UIViewController *viewController;
}
@property (retain) UINavigationController *navController;
@property (retain) UIViewController *viewController;

@property (strong, nonatomic) UIWindow *window;

@end

