//
//  InputViewController.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "InputViewController.h"

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
    
    NSMutableDictionary *updateDict;
}
@end

@implementation InputViewController

@synthesize editMode,delegate;

-(id)initWithFrame:(CGRect)frame withType:(int)type source:(NSMutableDictionary *)sourceData
{
    self=[super init];
    
    if (self)
    {
        parentRect=frame;
        displayType=type;
        
        typeOne=[[NSMutableArray alloc] initWithObjects:@"Player Name", nil];
        typeTwo=[[NSMutableArray alloc] initWithObjects:@"PER",@"JERSEY",@"TIME OFF",@"DESCRIPTION", nil];
        typeThree=[[NSMutableArray alloc] initWithObjects:@"PER",@"TIME",@"GOAL",@"ASSIST",@"ASSIST", nil];
        
        updateDict=sourceData;
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
            [self showOrHide:NO count:1 lblArr:typeOne];
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
    NSMutableArray *internalArr=[updateDict objectForKey:[NSString stringWithFormat:@"%i",editMode]];

    for (int i=0; i<5; i++)
    {
        UITextField *field=((UITextField *)[self.view viewWithTag:(300+i)]);
        
        if (!field.isHidden)
        {
            field.text=[internalArr objectAtIndex:i+1];
        }
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
    if (editMode==-1)
    {
        NSMutableArray *internalArr=[[NSMutableArray alloc] init];

        [internalArr addObject:[NSString stringWithFormat:@"%i",[[updateDict allKeys] count]+1]];
        
        for (int i=0; i<5; i++)
        {
            UITextField *field=((UITextField *)[self.view viewWithTag:300+i]);
            
            if (!field.isHidden)
            {
                [internalArr addObject:field.text];
            }
        }
        [updateDict setObject:internalArr forKey:[NSString stringWithFormat:@"%i",([[updateDict allKeys] count])]];
    }
    else
    {
        NSMutableArray *internalArr=[updateDict objectForKey:[NSString stringWithFormat:@"%i",editMode]];
        
        for (int i=0; i<5; i++)
        {
            UITextField *field=((UITextField *)[self.view viewWithTag:300+i]);
            
            if (!field.isHidden)
            {
                [internalArr replaceObjectAtIndex:(i+1) withObject:field.text];
            }
        }
    }
    
    [delegate doneButtonClicked];
}

@end
