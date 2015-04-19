//
//  LoginController.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 11/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "LoginController.h"
#import "ViewController.h"

@interface LoginController ()

@end

@implementation LoginController

@synthesize loginButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *appTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 350, 60)];
    appTitle.center=CGPointMake(self.view.frame.size.height/2,self.view.frame.size.width/2-80);
    appTitle.font=[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:60];
    appTitle.text=@"Scorekeeper";
    appTitle.textAlignment=NSTextAlignmentCenter;
    appTitle.textColor=[UIColor grayColor];
    appTitle.backgroundColor=[UIColor clearColor];
    [self.view addSubview:appTitle];
    
    self.loginButton=[[FBLoginView alloc] initWithFrame:CGRectMake(10, 10, 200, 200)];
    self.loginButton.center=CGPointMake(self.view.frame.size.height/2,self.view.frame.size.width/2);
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    [self.view addSubview:self.loginButton];
}

#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
}


-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:NO];
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}


@end
