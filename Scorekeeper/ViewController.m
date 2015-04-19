//
//  ViewController.m
//  MHR
//
//  Created by suresh ramasamy on 19/03/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"
#import "TableView.h"
#import "DataManager.h"
#import "InputViewController.h"
#import "GameSettingsController.h"
#import <QuartzCore/QuartzCore.h>
#import "SKCoreDataManager.h"

@interface ViewController ()
{
    MenuView *menuView;
    
    UIButton *button;
    
    UIView *homeView;
    TableView *mainHomeTable;
    TableView *homeSubTable;
    TableView *homeSubTableTwo;
    
    UIView *awayView;
    TableView *mainAwayTable;
    TableView *awaySubTable;
    TableView *awaySubTableTwo;
}
@end

@implementation ViewController

@synthesize popoverController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor clearColor];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.view.layer.masksToBounds=YES;

    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor=[UIColor clearColor];
    [button addTarget:self action:@selector(eventFired:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 20, 40, 40);
    [self.view addSubview:button];
    
    UILabel *headerTitle=[[UILabel alloc] initWithFrame:CGRectMake(120, 20, 824, 40)];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"DATE: 1/4/15    GAME #: 1158112    START TIME: 2:00 PM    DIVISION: 2001 AAA    ARENA: BILL GRAYS ICEPLEX    RINK:1"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    headerTitle.attributedText=attributeString;
    headerTitle.textColor=[UIColor whiteColor];
    headerTitle.textAlignment=NSTextAlignmentCenter;
    headerTitle.font=[UIFont fontWithName:@"Helvetica-BOLD" size:14];
    headerTitle.backgroundColor=[UIColor clearColor];
    [self.view addSubview:headerTitle];
    
    [self createHomeTable];
    [self createGoalTableForHome];
    [self createPenaltyTableForHome];

    [self createGoalTableForAway];
    [self createPenaltyTableForAway];
    [self createAwayTable];

    menuView=[[MenuView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    menuView.delegate=self;
    [self.view addSubview:menuView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)createHomeTable
{
    UILabel *homeLbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 95, 180, 20)];
    homeLbl.text=@"HOME";
    homeLbl.textColor=[UIColor whiteColor];
    homeLbl.textAlignment=NSTextAlignmentCenter;
    homeLbl.font=[UIFont fontWithName:@"Helvetica-BOLD" size:20];
    homeLbl.backgroundColor=[UIColor clearColor];
    [self.view addSubview:homeLbl];
    
    homeView=[[UIView alloc] initWithFrame:CGRectMake(5,homeLbl.frame.size.height+homeLbl.frame.origin.y+5,180,640)];
    homeView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:homeView];
    
    UILabel *homeNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(5,5,homeView.frame.size.width-10,17)];
    homeNameLbl.text=@"Ottawa String";
    homeNameLbl.textColor=[UIColor yellowColor];
    homeNameLbl.textAlignment=NSTextAlignmentCenter;
    homeNameLbl.font=[UIFont fontWithName:@"Helvetica" size:14];
    homeNameLbl.backgroundColor=[UIColor blackColor];
    homeNameLbl.layer.cornerRadius=5;
    homeNameLbl.layer.borderWidth=1;
    homeNameLbl.layer.masksToBounds=YES;
    [homeView addSubview:homeNameLbl];
    
    mainHomeTable=[[TableView alloc] initWithFrame:CGRectMake(2,homeNameLbl.frame.size.height+homeNameLbl.frame.origin.y+5,homeView.frame.size.width-4,630) btnLbl:@"" cellClass:@"HomeCell" tableID:HOME_DICT];
    mainHomeTable.backgroundColor=[UIColor clearColor];
    mainHomeTable.delegate=self;
    mainHomeTable.gameType = HOME_GAME;
    mainHomeTable.dataArray=[[[DataManager getInstance] getData:@"HOME" forMode:HOME_DICT] mutableCopy];
    [homeView addSubview:mainHomeTable];
    [mainHomeTable reloadData];
    
    [self createAddButton:500 withRect:CGRectMake(homeLbl.frame.size.width+homeLbl.frame.origin.x-40, 85, 35, 35)];
}

-(void)createPenaltyTableForHome
{
    homeSubTable=[[TableView alloc] initWithFrame:CGRectMake(homeView.frame.size.width+homeView.frame.origin.x+10,homeSubTableTwo.frame.size.height+homeSubTableTwo.frame.origin.y+20,310,300) btnLbl:@"PENALTY HOME" cellClass:@"PenaltyCell" tableID:PENALTY_DICT];
    homeSubTable.backgroundColor=[UIColor clearColor];
    homeSubTable.dataArray=[[[DataManager getInstance] getData:@"HOME" forMode:PENALTY_DICT] mutableCopy];
    [self.view addSubview:homeSubTable];
    homeSubTable.delegate=self;
    homeSubTable.gameType = HOME_GAME;
    [homeSubTable reloadData];
    
    [self createAddButton:501 withRect:CGRectMake(homeSubTable.frame.size.width+homeSubTable.frame.origin.x-40, homeSubTable.frame.origin.y, 35, 35)];
}

-(void)createGoalTableForHome
{
    homeSubTableTwo=[[TableView alloc] initWithFrame:CGRectMake(homeView.frame.size.width+homeView.frame.origin.x+10,110,310,300) btnLbl:@"GOAL HOME" cellClass:@"GoalCell" tableID:GOAL_DICT];
    homeSubTableTwo.backgroundColor=[UIColor clearColor];
    homeSubTableTwo.delegate=self;
    homeSubTableTwo.gameType = HOME_GAME;
    homeSubTableTwo.dataArray=[[[DataManager getInstance] getData:@"HOME" forMode:GOAL_DICT] mutableCopy];
    [self.view addSubview:homeSubTableTwo];
    [homeSubTableTwo reloadData];
    
    [self createAddButton:502 withRect:CGRectMake(homeSubTableTwo.frame.size.width+homeSubTableTwo.frame.origin.x-40, homeSubTableTwo.frame.origin.y, 35, 35)];
}

-(void)createPenaltyTableForAway
{
    awaySubTable=[[TableView alloc] initWithFrame:CGRectMake(homeSubTable.frame.size.width+homeSubTable.frame.origin.x+15,awaySubTableTwo.frame.size.height+awaySubTableTwo.frame.origin.y+20,310,300)btnLbl:@"PENALTY AWAY" cellClass:@"PenaltyCell" tableID:PENALTY_DICT];
    awaySubTable.backgroundColor=[UIColor clearColor];
    awaySubTable.delegate=self;
    awaySubTable.gameType = AWAY_GAME;
    awaySubTable.dataArray=[[[DataManager getInstance] getData:@"AWAY" forMode:PENALTY_DICT] mutableCopy];
    [self.view addSubview:awaySubTable];
    [awaySubTable reloadData];
    
    [self createAddButton:503 withRect:CGRectMake(awaySubTable.frame.size.width+awaySubTable.frame.origin.x-40, awaySubTable.frame.origin.y, 35, 35)];
}

-(void)createGoalTableForAway
{
    awaySubTableTwo=[[TableView alloc] initWithFrame:CGRectMake(homeSubTable.frame.size.width+homeSubTable.frame.origin.x+15,110,310,300) btnLbl:@"GOAL AWAY" cellClass:@"GoalCell" tableID:GOAL_DICT];
    awaySubTableTwo.backgroundColor=[UIColor clearColor];
    awaySubTableTwo.delegate=self;
    awaySubTableTwo.gameType = AWAY_GAME;
    awaySubTableTwo.dataArray=[[[DataManager getInstance] getData:@"AWAY" forMode:GOAL_DICT] mutableCopy];
    [self.view addSubview:awaySubTableTwo];
    [awaySubTableTwo reloadData];
    
    [self createAddButton:504 withRect:CGRectMake(awaySubTableTwo.frame.size.width+awaySubTableTwo.frame.origin.x-40, awaySubTableTwo.frame.origin.y, 35, 35)];
}

-(void)createAwayTable
{
    UILabel *awayLbl=[[UILabel alloc] initWithFrame:CGRectMake(awaySubTableTwo.frame.size.width+awaySubTableTwo.frame.origin.x+10, 100, 180, 20)];
    awayLbl.text=@"AWAY";
    awayLbl.textColor=[UIColor whiteColor];
    awayLbl.textAlignment=NSTextAlignmentCenter;
    awayLbl.font=[UIFont fontWithName:@"Helvetica-BOLD" size:20];
    awayLbl.backgroundColor=[UIColor clearColor];
    [self.view addSubview:awayLbl];
    
    awayView=[[UIView alloc] initWithFrame:CGRectMake(awaySubTable.frame.size.width+awaySubTable.frame.origin.x+10,awayLbl.frame.size.height+awayLbl.frame.origin.y,180,640)];
    awayView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:awayView];
    
    UILabel *awayNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(5,5,awayView.frame.size.width-10,17)];
    awayNameLbl.text=@"Ottawa String";
    awayNameLbl.textColor=[UIColor yellowColor];
    awayNameLbl.textAlignment=NSTextAlignmentCenter;
    awayNameLbl.font=[UIFont fontWithName:@"Helvetica" size:14];
    awayNameLbl.backgroundColor=[UIColor blackColor];
    awayNameLbl.layer.cornerRadius=5;
    awayNameLbl.layer.masksToBounds=YES;
    [awayView addSubview:awayNameLbl];
    
    mainAwayTable=[[TableView alloc] initWithFrame:CGRectMake(2,awayNameLbl.frame.size.height+awayNameLbl.frame.origin.y+5,awayView.frame.size.width-4,630) btnLbl:@"" cellClass:@"HomeCell" tableID:HOME_DICT];
    mainAwayTable.backgroundColor=[UIColor clearColor];
    mainAwayTable.delegate=self;
    mainAwayTable.gameType = AWAY_GAME;
    mainAwayTable.dataArray=[[[DataManager getInstance] getData:@"AWAY" forMode:HOME_DICT] mutableCopy];
    [awayView addSubview:mainAwayTable];
    [mainAwayTable reloadData];
    
    [self createAddButton:505 withRect:CGRectMake(awayLbl.frame.size.width+awayLbl.frame.origin.x-40, 85, 35, 35)];
}

-(void)createAddButton:(int)tag withRect:(CGRect)frame
{
    UIButton *addbtn = [[UIButton alloc] initWithFrame:frame];
    addbtn.tag=tag;
    [addbtn addTarget:self action:@selector(addButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [addbtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addbtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateSelected];
    addbtn.backgroundColor=[UIColor clearColor];
    [self.view addSubview:addbtn];
}

-(void)addButtonEvent:(UIButton *)btn
{
    if (btn.tag==500)
    {
        [mainHomeTable editButtonEvent:btn.frame withObj:self.view editMode:-1];
    }
    else if(btn.tag==501)
    {
        [homeSubTable editButtonEvent:btn.frame withObj:self.view editMode:-1];
    }
    else if(btn.tag==502)
    {
        [homeSubTableTwo editButtonEvent:btn.frame withObj:self.view editMode:-1];
    }
    else if (btn.tag==503)
    {
        [awaySubTable editButtonEvent:btn.frame withObj:self.view editMode:-1];
    }
    else if(btn.tag==504)
    {
        [awaySubTableTwo editButtonEvent:btn.frame withObj:self.view editMode:-1];
    }
    else if(btn.tag==505)
    {
        [mainAwayTable editButtonEvent:btn.frame withObj:self.view editMode:-1];
    }       
}

-(void)eventFired:(id)sender
{
    [menuView manageMenuView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)selectedItem:(int)index
{
    NSLog(@"INDES:::");
    
    GameSettingsController *settings=[[GameSettingsController alloc] init];
    
    [self.navigationController pushViewController:settings animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [menuView manageMenuView];
}

@end
