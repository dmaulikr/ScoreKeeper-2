//
//  DataManager.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKCoreDataManager.h"

#define HOME_DICT 1
#define PENALTY_DICT 2
#define GOAL_DICT 3



@interface DataManager : NSObject
{
}

@property(nonatomic, strong)SKCoreDataManager *skCoreDataManager;

+(DataManager *)getInstance;
-(NSArray *)getData:(NSString *)type forMode:(int)mode;

@end
