//
//  TableView.h
//  MHR
//
//  Created by suresh ramasamy on 20/03/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"

@protocol TableViewDelegate <NSObject>

-(void)editButtonEvent:(CGRect)rect indexPath:(NSIndexPath*)indexPath;

@end

@interface TableView : UIView<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate,InputViewControllerDelegate>
{
    NSMutableDictionary *dataDict;
    
    id<TableViewDelegate> delegate;
    
    int tableID;
}

@property (retain) id<TableViewDelegate> delegate;
@property (retain) NSMutableDictionary *dataDict;
@property (retain) UIPopoverController *popoverController;
@property (retain) NSString *tableSide;

-(id)initWithFrame:(CGRect)frame btnLbl:(NSString *)btnLbl cellClass:(NSString *)cell tableID:(int)tableId;

-(void)reloadData;

-(void)editButtonEvent:(CGRect)rect withObj:(id)parent editMode:(int)editMode;

@end