//
//  GameSettingsController.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "GameSettingsController.h"

@interface GameSettingsController ()
{
    UIView *gameSettings;
}
@end

@implementation GameSettingsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title=@"Game Details";
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    [self createViews];
}

-(void)createViews
{
    NSArray *keyArr=NULL;
    NSArray *valueArr=NULL;
    
    gameSettings=[[UIView alloc] initWithFrame:CGRectMake(20, 90, self.view.frame.size.height-40, self.view.frame.size.width-120)];
    gameSettings.backgroundColor=[UIColor clearColor];
    [self.view addSubview:gameSettings];

    keyArr=@[@"Tournament",@"Flight"];
    valueArr=@[@"US Pond Hockey Championship 2015",@"Rink Rat - Day"];
    
    [self itemView:keyArr valueArr:valueArr yAxis:0];

    int height=120;
    
    keyArr=@[@"Date",@"Time"];
    valueArr=@[@"Friday, June 8,2015",@"11:30a CST"];
    
    [self itemView:keyArr valueArr:valueArr yAxis:height+20];
    
    keyArr=@[@"Visiting Team",@"Home Team"];
    valueArr=@[@"Hawkeyes",@"Stampede"];
    
    [self itemView:keyArr valueArr:valueArr yAxis:(height+20)*2];
    
    keyArr=@[@"Venue",@"Rank"];
    valueArr=@[@"National Sports Center",@"Schwans SR-4"];
    
    [self itemView:keyArr valueArr:valueArr yAxis:(height+20)*3];
    
    keyArr=@[@"Status"];
    valueArr=@[@"Scheduled"];
    
    [self itemView:keyArr valueArr:valueArr yAxis:(height+20)*4];
}

-(UIView *)itemView:(NSArray *)keyArr valueArr:(NSArray *)valueArr yAxis:(int)yAxis
{
    BOOL showSep=([keyArr count]>1)?YES:NO;
    
    UIView *itemView=[[UIView alloc] initWithFrame:CGRectMake(0, yAxis, gameSettings.frame.size.width,(showSep)?120:60)];
    itemView.backgroundColor=[UIColor whiteColor];
    itemView.layer.cornerRadius=5;
    itemView.layer.borderWidth=2;
    itemView.layer.borderColor=[UIColor grayColor].CGColor;
    [itemView.layer setShadowColor:[UIColor blackColor].CGColor];
    [itemView.layer setShadowOpacity:0.8];
    [itemView.layer setShadowRadius:3.0];
    [itemView.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    itemView.layer.rasterizationScale=0;
    [gameSettings addSubview:itemView];
    
    int originY=0;
    
    for (int i=0; i<[keyArr count]; i++)
    {
        UILabel *labelOne=[self createLabel];
        labelOne.text=[keyArr objectAtIndex:i];
        labelOne.textColor=[UIColor blackColor];
        labelOne.frame=CGRectMake(30, originY, 250, 60);
        [itemView addSubview:labelOne];
        
        UILabel *labelTwo=[self createLabel];
        labelTwo.text=[valueArr objectAtIndex:i];
        labelTwo.textColor=[UIColor redColor];
        labelTwo.frame=CGRectMake(gameSettings.frame.size.width/2-80, originY, gameSettings.frame.size.width/2, 60);
        [itemView addSubview:labelTwo];
        
        UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(gameSettings.frame.size.width-30, originY+10, 30, 40)];
        image.image=[UIImage imageNamed:@"arrow.png"];
        image.backgroundColor=[UIColor clearColor];
        [itemView addSubview:image];
        
        originY=60;
    }

    if (showSep)
    {
        UILabel *sep=[[UILabel alloc] initWithFrame:CGRectMake(0, itemView.frame.size.height/2, gameSettings.frame.size.width,1)];
        sep.backgroundColor=[UIColor grayColor];
        [itemView addSubview:sep];
    }

    return itemView;
}

-(UILabel *)createLabel
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentLeft;
    
    return label;
}

@end
