//
//  DataManager.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "DataManager.h"

static DataManager *instance;

@implementation DataManager

@synthesize homeDataDict,penaltyHomeDict,goalHomeDict;
@synthesize awayDataDict,penaltyAwayDict,goalAwayDict;

+(DataManager *)getInstance
{
    if (instance==NULL)
    {
        instance=[self new];
    }
    
    return instance;
}

-(id)init
{
    [self initializeData];
    
    return self;
}

-(void)initializeData
{
    homeDataDict=[[NSMutableDictionary alloc] init];
    penaltyHomeDict=[[NSMutableDictionary alloc] init];
    goalHomeDict=[[NSMutableDictionary alloc] init];
    
    awayDataDict=[[NSMutableDictionary alloc] init];
    penaltyAwayDict=[[NSMutableDictionary alloc] init];
    goalAwayDict=[[NSMutableDictionary alloc] init];
}

-(NSMutableDictionary *)getDataDict:(NSString *)type forMode:(int)mode
{
    switch (mode)
    {
        case HOME_DICT:
        {
            return [type isEqualToString:@"HOME"]?homeDataDict:awayDataDict;
            
            break;
        }
        case PENALTY_DICT:
        {
            return [type isEqualToString:@"HOME"]?penaltyHomeDict:penaltyAwayDict;
            
            break;
        }
        case GOAL_DICT:
        {
            return [type isEqualToString:@"HOME"]?goalHomeDict:goalAwayDict;
            
            break;
        }
        default:
            break;
    }
    
    return NULL;
}

@end
