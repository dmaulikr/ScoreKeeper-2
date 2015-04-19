//
//  InputViewController.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "InputViewController.h"
#import "SKCoreDataManager.h"
#import "Player.h"
#import "Penalty.h"
#import "Goal.h"

@interface InputViewController ()
{
    CGRect parentRect;
    int displayType;
    
    NSMutableArray *typeOne;
    NSMutableArray *typeTwo;
    NSMutableArray *typeThree;
    
    UILabel *labelOne;
    UITextField *fieldOne;
    
    UILabel *labelTwo;
    UITextField *fieldTwo;
    
    UILabel *labelThree;
    UITextField *fieldThree;
    
    UILabel *labelFour;
    UITextField *fieldFour;
    
    UILabel *labelFive;
    UITextField *fieldFive;
    
    NSMutableArray *updateArray;
}
@property (nonatomic, strong)SKCoreDataManager *coreDataManager;
@end

@implementation InputViewController

@synthesize editMode,delegate;

-(id)initWithFrame:(CGRect)frame withType:(int)type source:(NSMutableArray *)sourceData
{
    self=[super init];
    
    if (self)
    {
        parentRect=frame;
        displayType=type;
        
        typeOne=[[NSMutableArray alloc] initWithObjects:@"Position", @"Player Name", nil];
        typeTwo=[[NSMutableArray alloc] initWithObjects:@"PER",@"JERSEY",@"TIME OFF",@"DESCRIPTION", nil];
        typeThree=[[NSMutableArray alloc] initWithObjects:@"PER",@"TIME",@"GOAL",@"ASSIST",@"ASSIST", nil];
        
        updateArray=sourceData;
        self.coreDataManager = [SKCoreDataManager sharedInstance];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    labelOne=[self createLabel:CGRectMake(10, 10, 100, 30) withTag:0];
    fieldOne=[self createTextField:CGRectMake(parentRect.size.width-180, 10, 150, 30) withTag:0];
    
    labelTwo=[self createLabel:CGRectMake(10, labelOne.frame.size.height+labelOne.frame.origin.y+10, 100, 30) withTag:1];
    fieldTwo=[self createTextField:CGRectMake(parentRect.size.width-180, labelOne.frame.size.height+labelOne.frame.origin.y+10, 150, 30) withTag:1];
    
    labelThree=[self createLabel:CGRectMake(10, labelTwo.frame.size.height+labelTwo.frame.origin.y+10, 100, 30) withTag:2];
    fieldThree=[self createTextField:CGRectMake(parentRect.size.width-180, labelTwo.frame.size.height+labelTwo.frame.origin.y+10, 150, 30) withTag:2];
    
    labelFour=[self createLabel:CGRectMake(10, labelThree.frame.size.height+labelThree.frame.origin.y+10, 100, 30) withTag:3];
    fieldFour=[self createTextField:CGRectMake(parentRect.size.width-180, labelThree.frame.size.height+labelThree.frame.origin.y+10, 150, 30) withTag:3];
    
    labelFive=[self createLabel:CGRectMake(10, fieldFour.frame.size.height+fieldFour.frame.origin.y+10, 100, 30) withTag:4];
    fieldFive=[self createTextField:CGRectMake(parentRect.size.width-180, fieldFour.frame.size.height+fieldFour.frame.origin.y+10, 150, 30) withTag:4];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneBtn addTarget:self action:@selector(doneEventFired:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    doneBtn.backgroundColor=[UIColor redColor];
    doneBtn.titleLabel.textColor=[UIColor whiteColor];
    doneBtn.frame = CGRectMake(parentRect.size.width/2-60, 230, 100, 30.0);
    [self.view addSubview:doneBtn];
    
    [self manageInputs];
    [self updateInitialData];
}

-(void)manageInputs
{
    [self showOrHide:YES count:5 lblArr:NULL];
    
    switch (displayType)
    {
        case 1:
        {
            [self showOrHide:NO count:2 lblArr:typeOne];
            break;
        }
        case 2:
        {
            [self showOrHide:NO count:4 lblArr:typeTwo];
            break;
        }
        case 3:
        {
            [self showOrHide:NO count:5 lblArr:typeThree];
            break;
        }
        default:
            break;
    }
    
}

-(void)updateInitialData
{
    if(editMode == -1)
        return;
    switch (displayType)
    {
        case 1:
        {
            Player *player = [updateArray objectAtIndex:editMode];
            for (int i = 0; i<typeOne.count; i++) {
                UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                if (!textFiled.isHidden)
                {
                    switch (i) {
                        case 0:
                            textFiled.text=player.player_position;
                            break;
                        case 1:
                            textFiled.text=player.player_name;
                            break;
                        default:
                            textFiled.text= @"";
                            break;
                    }
                }
            }
            break;
        }
        case 2:
        {
            Penalty *penalty = [updateArray objectAtIndex:editMode];
            for (int i = 0; i<typeTwo.count; i++) {
                UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                if (!textFiled.isHidden)
                {
                    switch (i) {
                        case 0:
                            textFiled.text=penalty.per;
                            break;
                        case 1:
                            textFiled.text=penalty.jersey;
                            break;
                        case 2:
                            textFiled.text=penalty.time_off;
                            break;
                        case 3:
                            textFiled.text=penalty.desc;
                            break;
                        default:
                            textFiled.text= @"";
                            break;
                    }
                }
            }
            break;
        }
        case 3:
        {
            Goal *goal = [updateArray objectAtIndex:editMode];
            for (int i = 0; i<typeThree.count; i++) {
                UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                if (!textFiled.isHidden)
                {
                    switch (i) {
                        case 0:
                            textFiled.text=goal.per;
                            break;
                        case 1:
                            textFiled.text=goal.time;
                            break;
                        case 2:
                            textFiled.text=goal.goal;
                            break;
                        case 3:
                            textFiled.text=goal.assist1;
                            break;
                        case 4:
                            textFiled.text=goal.assist2;
                            break;
                        default:
                            textFiled.text= @"";
                            break;
                    }
                }
            }
            break;
        }
        default:
            break;
    }
}

-(void)showOrHide:(BOOL)isHidden count:(int)count lblArr:(NSMutableArray *)lblArr
{
    for (int i=0; i<count; i++)
    {
        ((UILabel *)[self.view viewWithTag:200+i]).hidden=isHidden;
        ((UITextField *)[self.view viewWithTag:300+i]).hidden=isHidden;
        
        if (lblArr!=NULL)
        {
            ((UILabel *)[self.view viewWithTag:200+i]).text=[lblArr objectAtIndex:i];
        }
    }
}

-(UILabel *)createLabel:(CGRect)frame withTag:(int)tag
{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.textColor=[UIColor whiteColor];
    label.tag=(200+tag);
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentLeft;
    
    [self.view addSubview:label];
    
    return label;
}

-(UITextField *)createTextField:(CGRect)frame withTag:(int)tag
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];

    textField.textAlignment = NSTextAlignmentLeft;
    textField.tag=(300+tag);
    textField.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    textField.textColor = [UIColor blackColor];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    textField.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:textField];
    
    return textField;
}

-(void)doneEventFired:(id)sender
{

    switch (displayType)
    {
        case 1:
        {
            NSError *error;
            if (editMode==-1)
            {
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.coreDataManager.managedObjectContext];
                Player *player = [[Player alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext];
                long playerId = [updateArray count] + 1;
                
                player.player_id = [NSNumber numberWithLong:playerId];
                player.game_type = [NSNumber numberWithInt:self.gameType];
                
                for (int i = 0; i<typeOne.count; i++) {
                    UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                    if (!textFiled.isHidden)
                    {
                        switch (i) {
                            case 0:
                                player.player_position = textFiled.text;
                                break;
                            case 1:
                                player.player_name = textFiled.text;
                                break;
                            default:
                                break;
                        }
                    }
                }
                if ([self.coreDataManager.managedObjectContext save:&error]) {
                    [updateArray addObject:player];
                }
                
            }
            else
            {
                Player *player = [updateArray objectAtIndex:editMode];
                for (int i = 0; i<typeOne.count; i++) {
                    UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                    if (!textFiled.isHidden)
                    {
                        switch (i) {
                            case 0:
                                player.player_position = textFiled.text;
                                break;
                            case 1:
                                player.player_name = textFiled.text;
                                break;
                            default:
                                break;
                        }
                    }
                }
                if ([self.coreDataManager.managedObjectContext save:&error]) {
                }
            }
            break;
        }
        case 2:
        {
            NSError *error;
            if (editMode==-1)
            {
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Penalty" inManagedObjectContext:self.coreDataManager.managedObjectContext];
                Penalty *penalty = [[Penalty alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext];
                long penaltyId = [updateArray count] + 1;
                
                penalty.penalty_id = [NSNumber numberWithLong:penaltyId];
                penalty.game_type = [NSNumber numberWithInt:self.gameType];
                
                for (int i = 0; i<typeTwo.count; i++) {
                    UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                    if (!textFiled.isHidden)
                    {
                        switch (i) {
                            case 0:
                                penalty.per = textFiled.text;
                                break;
                            case 1:
                                penalty.jersey = textFiled.text;
                                break;
                            case 2:
                                penalty.time_off = textFiled.text;
                                break;
                            case 3:
                                penalty.desc = textFiled.text;
                                break;
                            default:
                                break;
                        }
                    }
                }
                if ([self.coreDataManager.managedObjectContext save:&error]) {
                    [updateArray addObject:penalty];
                }
                
            }
            else
            {
                Penalty *penalty = [updateArray objectAtIndex:editMode];
                for (int i = 0; i<typeTwo.count; i++) {
                    UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                    if (!textFiled.isHidden)
                    {
                        switch (i) {
                            case 0:
                                penalty.per = textFiled.text;
                                break;
                            case 1:
                                penalty.jersey = textFiled.text;
                                break;
                            case 2:
                                penalty.time_off = textFiled.text;
                                break;
                            case 3:
                                penalty.desc = textFiled.text;
                                break;
                            default:
                                break;
                        }
                    }
                }
                if ([self.coreDataManager.managedObjectContext save:&error]) {
                }
            }
            break;
        }
        case 3:
        {
            NSError *error;
            if (editMode==-1)
            {
                NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.coreDataManager.managedObjectContext];
                Goal *goal = [[Goal alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext];
                long penaltyId = [updateArray count] + 1;
                
                goal.goal_id = [NSNumber numberWithLong:penaltyId];
                goal.game_type = [NSNumber numberWithInt:self.gameType];
            
                for (int i = 0; i<typeThree.count; i++) {
                    UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                    if (!textFiled.isHidden)
                    {
                        switch (i) {
                            case 0:
                                goal.per = textFiled.text;
                                break;
                            case 1:
                                goal.time = textFiled.text;
                                break;
                            case 2:
                                goal.goal = textFiled.text;
                                break;
                            case 3:
                                goal.assist1 = textFiled.text;
                                break;
                            case 4:
                                goal.assist2 = textFiled.text;
                                break;
                            default:
                                break;
                        }
                    }
                }
                if ([self.coreDataManager.managedObjectContext save:&error]) {
                    [updateArray addObject:goal];
                }
                
            }
            else
            {
                Goal *goal = [updateArray objectAtIndex:editMode];
                for (int i = 0; i<typeThree.count; i++) {
                    UITextField *textFiled=((UITextField *)[self.view viewWithTag:300+i]);
                    if (!textFiled.isHidden)
                    {
                        switch (i) {
                            case 0:
                                goal.per = textFiled.text;
                                break;
                            case 1:
                                goal.time = textFiled.text;
                                break;
                            case 2:
                                goal.goal = textFiled.text;
                                break;
                            case 3:
                                goal.assist1 = textFiled.text;
                                break;
                            case 4:
                                goal.assist2 = textFiled.text;
                                break;
                            default:
                                break;
                        }
                    }
                }

                if ([self.coreDataManager.managedObjectContext save:&error]) {
                }
            }
            break;
        }
        default:
            break;
    }

    [delegate doneButtonClicked];
}

@end
