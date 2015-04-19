//
//  HomeCell.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "HomeCell.h"
#import "Player.h"

@interface HomeCell ()
{
    UILabel *indexLbl;
    UILabel *playerName;
}
@end

@implementation HomeCell

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
            playerName.text=@"HOME Players Name";
        }
        else
        {
            if([obj isKindOfClass:[Player class]])
            {
                Player *player = (Player*)obj;
                indexLbl.text = player.player_position;
                playerName.text = player.player_name;
            }
        }
    }
    
    return self;
}

-(void)createViews
{
    indexLbl=[self createLabel];
    playerName=[self createLabel];
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
    playerName.frame=CGRectMake(indexLbl.frame.size.width, 0, (self.frame.size.width-(indexLbl.frame.size.width)), 30);
}

@end
