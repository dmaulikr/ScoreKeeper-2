//
//  DataManager.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "DataManager.h"

static DataManager *instance;

@interface SKCoreDataManager()

@end

@implementation DataManager

@synthesize skCoreDataManager;

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
    skCoreDataManager = [SKCoreDataManager sharedInstance];
    return self;
}

-(NSArray *)getData:(NSString *)type forMode:(int)mode
{
    switch (mode)
    {
        case HOME_DICT:
        {
            if([type isEqualToString:@"HOME"])
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game_type == %@",[NSNumber numberWithInt:HOME_GAME]];
                return [self.skCoreDataManager fetchRecords:@"Player" forPredicate:predicate];
            }
            else
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game_type == %@", [NSNumber numberWithInt:AWAY_GAME]];
                return [self.skCoreDataManager fetchRecords:@"Player" forPredicate:predicate];
            }
            
            break;
        }
        case PENALTY_DICT:
        {
            if([type isEqualToString:@"HOME"])
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game_type == %@", [NSNumber numberWithInt:HOME_GAME]];
                return [self.skCoreDataManager fetchRecords:@"Penalty" forPredicate:predicate];
            }
            else
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game_type == %@", [NSNumber numberWithInt:AWAY_GAME]];
                return [self.skCoreDataManager fetchRecords:@"Penalty" forPredicate:predicate];
            }
            break;
        }
        case GOAL_DICT:
        {
            if([type isEqualToString:@"HOME"])
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game_type == %@", [NSNumber numberWithInt:HOME_GAME]];
                return [self.skCoreDataManager fetchRecords:@"Goal" forPredicate:predicate];
            }
            else
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game_type == %@", [NSNumber numberWithInt:AWAY_GAME]];
                return [self.skCoreDataManager fetchRecords:@"Goal" forPredicate:predicate];
            }
            break;
        }
        default:
            break;
    }
    
    return NULL;
}

@end
