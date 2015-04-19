//
//  DataManager.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HOME_DICT 1
#define PENALTY_DICT 2
#define GOAL_DICT 3


@interface DataManager : NSObject
{
    NSMutableDictionary *homeDataDict;
    NSMutableDictionary *penaltyHomeDict;
    NSMutableDictionary *goalHomeDict;
    
    NSMutableDictionary *awayDataDict;
    NSMutableDictionary *penaltyAwayDict;
    NSMutableDictionary *goalAwayDict;
}

@property (retain) NSMutableDictionary *homeDataDict;
@property (retain) NSMutableDictionary *penaltyHomeDict;
@property (retain) NSMutableDictionary *goalHomeDict;

@property (retain) NSMutableDictionary *awayDataDict;
@property (retain) NSMutableDictionary *penaltyAwayDict;
@property (retain) NSMutableDictionary *goalAwayDict;

+(DataManager *)getInstance;
-(NSMutableDictionary *)getDataDict:(NSString *)type forMode:(int)mode;

@end
