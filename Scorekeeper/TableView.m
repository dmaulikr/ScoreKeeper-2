//
//  TableView.m
//  MHR
//
//  Created by suresh ramasamy on 20/03/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "TableView.h"
#import <QuartzCore/QuartzCore.h>
#import "HomeCell.h"
#import "DefaultRow.h"
#import "InputViewController.h"

@interface TableView ()
{
    UITableView *mainTable;
    NSString *btnLblStr;
    NSString *cellClass;
    
    UIView *headerView;
    
    BOOL isShowBtn;
    
    
}
@end

@implementation TableView

@synthesize delegate;
@synthesize popoverController,dataDict,tableSide;

-(id)initWithFrame:(CGRect)frame btnLbl:(NSString *)btnLbl cellClass:(NSString *)cell tableID:(int)tableId
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        btnLblStr=btnLbl;
        cellClass=cell;
        tableID=tableId;

        isShowBtn=([btnLblStr length]>0)?YES:NO;
        
        [self createComponents];
    }
    
    return self;
}

-(void)createComponents
{
    dataDict=NULL;
    
    UIView *tableBackgroundOne=[[UIView alloc] initWithFrame:CGRectMake(-2, isShowBtn?40:0, self.frame.size.width+4, self.frame.size.height-30)];
    tableBackgroundOne.backgroundColor=[UIColor grayColor];
    
    if (isShowBtn)
    {
        [self addSubview:tableBackgroundOne];
    }
    
    headerView=[[UIView alloc] initWithFrame:CGRectMake(0, isShowBtn?45:0, self.frame.size.width, 30)];
    headerView.backgroundColor=[UIColor blackColor];
    [self addSubview:headerView];
    
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0,headerView.frame.size.height+headerView.frame.origin.y, self.frame.size.width,self.frame.size.height-70) style:UITableViewStylePlain];
    
    [mainTable setShowsVerticalScrollIndicator:NO];
    
    mainTable.backgroundColor=[UIColor clearColor];
    mainTable.layer.cornerRadius=5;
    mainTable.layer.masksToBounds=YES;
    [mainTable setDataSource:self];
    mainTable.separatorColor=[UIColor clearColor];
    [mainTable setDelegate:self];
    [self addSubview:mainTable];
    
    UILabel *tableTitle=[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-(self.frame.size.width/4), 0, self.frame.size.width/2, 40)];
    tableTitle.backgroundColor=[UIColor redColor];
    tableTitle.text=btnLblStr;
    tableTitle.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    tableTitle.backgroundColor=([btnLblStr isEqualToString:@"GOAL HOME"]||[btnLblStr isEqualToString:@"GOAL AWAY"])?[UIColor greenColor]:[UIColor redColor];
    tableTitle.textColor=[UIColor whiteColor];
    tableTitle.textAlignment=NSTextAlignmentCenter;
    tableTitle.layer.cornerRadius=10;
    tableTitle.layer.borderWidth=1;
    tableTitle.layer.masksToBounds=YES;
    tableTitle.layer.borderColor=[UIColor clearColor].CGColor;
    
    UILabel *tableBackgroundTwo=[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-(self.frame.size.width/4)-5,-3,self.frame.size.width/2+10,50)];
    tableBackgroundTwo.layer.cornerRadius=15;
    tableBackgroundTwo.backgroundColor=[UIColor grayColor];
    
    if (isShowBtn)
    {
        [self addSubview:tableBackgroundTwo];
        [self addSubview:tableTitle];
    }
    
    [self sendSubviewToBack:tableBackgroundTwo];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataDict allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *klass = cellClass;

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:klass];
    
    if(!cell)
    {
        cell = [[NSClassFromString(klass) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:klass];
    }

    cell=[(DefaultRow *)cell initCellWithData:[dataDict objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]] forRowNum:indexPath.row ofTotalRows:1 andNoOfCols:1];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor clearColor];

    cell.alpha = 0.6f;
    cell.transform=CGAffineTransformMakeScale(0.8,0.8);
    [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        cell.alpha = 1;
        cell.transform=CGAffineTransformMakeScale(1,1);
    } completion:nil];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        
        rect.origin.y=0;

        DefaultRow *row = ((DefaultRow *)[tableView cellForRowAtIndexPath:indexPath]);
        
        [self editButtonEvent:rect withObj:row editMode:indexPath.row];
        
        [mainTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Edit";
}

-(void)editButtonEvent:(CGRect)rect withObj:(id)parent editMode:(int)editMode
{
    InputViewController *newViewController = [[InputViewController alloc] initWithFrame:CGRectMake(0, 0, 320, 280) withType:tableID source:dataDict];
    newViewController.delegate=self;
    newViewController.editMode=editMode;

    popoverController = [[UIPopoverController alloc] initWithContentViewController:newViewController];
    popoverController.backgroundColor=[UIColor darkGrayColor];
    popoverController.delegate=self;
    popoverController.popoverContentSize = CGSizeMake(300, 280);
    
    [popoverController presentPopoverFromRect:rect inView:parent permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)reloadData
{
    UITableViewCell *head = [[NSClassFromString(cellClass) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClass];
    
    head = [(DefaultRow *)head initCellWithData:NULL forRowNum:0 ofTotalRows:1 andNoOfCols:1];
    
    head.frame=CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
    
    [headerView addSubview:head];
    
    [mainTable reloadData];
}

-(void)doneButtonClicked
{
    [popoverController dismissPopoverAnimated:YES];
    [mainTable reloadData];
}

@end
