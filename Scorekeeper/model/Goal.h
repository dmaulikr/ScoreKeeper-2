//
//  Goal.h
//  Scorekeeper
//
//  Created by Nandhakumar V on 19/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Goal : NSManagedObject

@property (nonatomic, retain) NSString * assist1;
@property (nonatomic, retain) NSString * assist2;
@property (nonatomic, retain) NSString * goal;
@property (nonatomic, retain) NSNumber * goal_id;
@property (nonatomic, retain) NSString * per;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSNumber * game_type;

@end
