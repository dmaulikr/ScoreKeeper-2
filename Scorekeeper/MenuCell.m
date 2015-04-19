//
//  MenuCell.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "MenuCell.h"

@interface MenuCell ()
{
    UILabel *titleLbl;
    UISwitch *mySwitch;
}
@end

@implementation MenuCell

@synthesize titleLbl;

-(id) initCellWithData:(NSString *)dataStr forRowNum:(int)row ofTotalRows:(int)total andNoOfCols:(int)noOfCols
{
    self=[super initCellWithData:dataStr forRowNum:row ofTotalRows:total andNoOfCols:noOfCols];
    
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (!titleLbl)
        {
            [self createViews];
        }
        
        titleLbl.text=dataStr;
        mySwitch.hidden=(row==0)?NO:YES;
    }
    return self;
}

-(void)createViews
{
    titleLbl=[self createLabel];
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
    image.image=[UIImage imageNamed:@"Settings.png"];
    image.backgroundColor=[UIColor clearColor];
    [self addSubview:image];
    
    mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(220, 15, 60, 30)];
    [self addSubview:mySwitch];
    
    UILabel *sep=[[UILabel alloc] initWithFrame:CGRectMake(0, 59, self.frame.size.width, 1)];
    sep.backgroundColor=[UIColor grayColor];
    [self addSubview:sep];
    
}

-(void)layoutSubviews
{
    titleLbl.frame=CGRectMake(50,0,160,60);
}

-(UILabel *)createLabel
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor=[UIColor blackColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentLeft;
    
    [self addSubview:label];
    
    return label;
}

@end
