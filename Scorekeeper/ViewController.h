//
//  ViewController.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 11/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableView.h"
#import "MenuView.h"

@interface ViewController : UIViewController<TableViewDelegate,UIPopoverControllerDelegate,MenuViewDelegate>

@property (retain) UIPopoverController *popoverController;

@end

