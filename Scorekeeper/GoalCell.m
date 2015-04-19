//
//  HomeCell.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "GoalCell.h"
#import "Goal.h"

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

-(id) initCellWithData:(id)obj forRowNum:(int) row ofTotalRows:(int)total andNoOfCols:(int)noOfCols
{
    self=[super initCellWithData:obj forRowNum:row ofTotalRows:total andNoOfCols:noOfCols];
    
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if(!indexLbl)
        {
            [self createViews];
        }
        
        if (obj==nil)
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
         
            if([obj isKindOfClass:[Goal class]])
            {
                Goal *goalObj = (Goal*)obj;
                indexLbl.text= [NSString stringWithFormat:@"%@", goalObj.goal_id];
                playerName.text=goalObj.per;
                timeLbl.text=goalObj.time;
                goalLbl.text=goalObj.goal;
                assistOneLbl.text=goalObj.assist1;
                assistTwoLbl.text=goalObj.assist2;
            }
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
