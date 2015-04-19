//
//  HomeCell.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "PenaltyCell.h"
#import "Penalty.h"

@interface PenaltyCell ()
{
    UILabel *indexLbl;
    UILabel *playerName;
    UILabel *jerseyLbl;
    UILabel *timeOffLbl;
    UILabel *descriptionLbl;
}
@end

@implementation PenaltyCell

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
            jerseyLbl.text=@"JERSEY#";
            timeOffLbl.text=@"TIME OFF";
            descriptionLbl.text=@"DESCRIPTION";
        }
        else
        {
            if([obj isKindOfClass:[Penalty class]])
            {
                Penalty *penalty = (Penalty*)obj;
                indexLbl.text=[NSString stringWithFormat:@"%@", penalty.penalty_id];
                playerName.text=penalty.per;
                jerseyLbl.text=penalty.jersey;
                timeOffLbl.text=penalty.time_off;
                descriptionLbl.text=penalty.desc;
            }
        }
        
    }
    
    return self;
}

-(void)createViews
{
    indexLbl=[self createLabel];
    playerName=[self createLabel];
    jerseyLbl=[self createLabel];
    timeOffLbl=[self createLabel];
    descriptionLbl=[self createLabel];
}

-(UILabel *)createLabel
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:12];
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
    
    playerName.frame=CGRectMake(indexLbl.frame.size.width, 0, totalWidth*0.15, 30);
    jerseyLbl.frame=CGRectMake(playerName.frame.size.width+playerName.frame.origin.x, 0, totalWidth*0.22, 30);
    timeOffLbl.frame=CGRectMake(jerseyLbl.frame.size.width+jerseyLbl.frame.origin.x, 0, totalWidth*0.22, 30);
    descriptionLbl.frame=CGRectMake(timeOffLbl.frame.size.width+timeOffLbl.frame.origin.x, 0, totalWidth*0.41, 30);
    
}

@end
