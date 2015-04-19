//
//  LoginController.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 11/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginController : UIViewController<FBLoginViewDelegate>

@property (retain,nonatomic) FBLoginView *loginButton;

@end
