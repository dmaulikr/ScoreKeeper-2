//
//  HomeCell.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "GoalCell.h"

@interface GoalCell ()
{
    UILabel *indexLbl;
    UILabel *playerName;
    UILabel *timeLbl;
    UILabel *goalLbl;
    UILabel *assistOneLbl;
    UILabel *assistTwoLbl;
}
@end

@implementation GoalCell

-(id) initCellWithData:(NSMutableArray *)dataArr forRowNum:(int) row ofTotalRows:(int)total andNoOfCols:(int)noOfCols
{
    self=[super initCellWithData:dataArr forRowNum:row ofTotalRows:total andNoOfCols:noOfCols];
    
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if(!indexLbl)
        {
            [self createViews];
        }
        
        if (dataArr==NULL)
        {
            indexLbl.text=@"#";
            playerName.text=@"PER";
            timeLbl.text=@"TIME";
            goalLbl.text=@"GOAL";
            assistOneLbl.text=@"ASSIST";
            assistTwoLbl.text=@"ASSIST";
        }
        else
        {
            indexLbl.text=[dataArr objectAtIndex:0];
            playerName.text=[dataArr objectAtIndex:1];
            timeLbl.text=[dataArr objectAtIndex:2];
            goalLbl.text=[dataArr objectAtIndex:3];
            assistOneLbl.text=[dataArr objectAtIndex:4];
            assistTwoLbl.text=[dataArr objectAtIndex:5];
        }
    }
    
    return self;
}

-(void)createViews
{
    indexLbl=[self createLabel];
    playerName=[self createLabel];
    timeLbl=[self createLabel];
    goalLbl=[self createLabel];
    assistOneLbl=[self createLabel];
    assistTwoLbl=[self createLabel];
}

-(UILabel *)createLabel
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.backgroundColor=[UIColor blackColor];
    label.layer.borderWidth=1;
    label.layer.borderColor=[UIColor grayColor].CGColor;
    label.textAlignment=NSTextAlignmentCenter;
    
    [self addSubview:label];
    
    return label;
}

-(void)layoutSubviews
{
    indexLbl.frame=CGRectMake(0, 0, 30, 30);
    
    int totalWidth=(self.frame.size.width-(indexLbl.frame.size.width));
    
    playerName.frame=CGRectMake(indexLbl.frame.size.width, 0, totalWidth*0.20, 30);
    timeLbl.frame=CGRectMake(playerName.frame.size.width+playerName.frame.origin.x, 0, totalWidth*0.20, 30);
    goalLbl.frame=CGRectMake(timeLbl.frame.size.width+timeLbl.frame.origin.x, 0, totalWidth*0.20, 30);
    assistOneLbl.frame=CGRectMake(goalLbl.frame.size.width+goalLbl.frame.origin.x, 0, totalWidth*0.20, 30);
    assistTwoLbl.frame=CGRectMake(assistOneLbl.frame.size.width+assistOneLbl.frame.origin.x, 0, totalWidth*0.20, 30);
}

@end
