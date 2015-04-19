//
//  MenuView.m
//  MHR
//
//  Created by suresh ramasamy on 19/03/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "MenuView.h"
#import "MenuCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MenuView ()
{
    UIView *sliderView;
    
    UITableView *mainTable;
    
    UIView *backgroundView;
    
    NSMutableArray *menuItems;
}
@end

static MenuView *instance;

@implementation MenuView

@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        [self createMenuComponents:frame];
        
        self.hidden=YES;
        
        menuItems=[[NSMutableArray alloc] initWithObjects:@"ScoreSheet",@"Game Details",@"Periods",@"ClockFormat",@"Officials",@"Post Live Updates",@"Track Shots", @"Track Play Location",nil];
    }

    return self;
}

-(void)createMenuComponents:(CGRect)frame
{
    backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    backgroundView.hidden=YES;
    [self addSubview:backgroundView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manageMenuView)];
    singleTap.numberOfTapsRequired = 1;
    [backgroundView addGestureRecognizer:singleTap];
    
    sliderView=[[UIView alloc] initWithFrame:CGRectMake(-280,0, 280,frame.size.height)];
    sliderView.backgroundColor=[UIColor clearColor];
    [self addSubview:sliderView];
    
    UILabel *headingLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 70)];
    headingLbl.text=@"  Scorekeeper";
    headingLbl.font=[UIFont fontWithName:@"Helvetica-BOLD" size:20];
    headingLbl.textColor=[UIColor whiteColor];
    headingLbl.backgroundColor=[UIColor blackColor];
    headingLbl.layer.borderWidth=1;
    headingLbl.layer.borderColor=[UIColor grayColor].CGColor;
    [sliderView addSubview:headingLbl];
    
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0,70, 280,frame.size.height-70) style:UITableViewStylePlain];
    
    mainTable.backgroundColor=[UIColor grayColor];
    [mainTable setShowsVerticalScrollIndicator:NO];
    mainTable.separatorColor=[UIColor clearColor];
    [mainTable setDataSource:self];
    [mainTable setDelegate:self];
    
    [sliderView addSubview:mainTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *tableCell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!tableCell)
    {
        tableCell = [[NSClassFromString(@"MenuCell") alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
    }
    
    int show=1;
    
    if (indexPath.row>=5)
    {
        show=0;
    }

    tableCell=[(DefaultRow *)tableCell initCellWithData:[menuItems objectAtIndex:indexPath.row] forRowNum:show ofTotalRows:1 andNoOfCols:1];
    
    tableCell.backgroundColor = [UIColor whiteColor];
    
    tableCell.titleLbl.text=[menuItems objectAtIndex:indexPath.row];
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1)
    {
        [delegate selectedItem:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)manageMenuView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    
    CGRect sliderViewRect=sliderView.frame;
    
    if (sliderView.frame.origin.x==0)
    {
        sliderViewRect.origin.x=-280;
        
        self.hidden=YES;
        
        backgroundView.alpha=0;
        backgroundView.hidden=YES;
    }
    else
    {
        sliderViewRect.origin.x=0;
        
        self.hidden=NO;
        
        backgroundView.alpha=0.6;
        backgroundView.hidden=NO;
    }
    
    sliderView.frame=sliderViewRect;

    [UIView commitAnimations];
}

@end
