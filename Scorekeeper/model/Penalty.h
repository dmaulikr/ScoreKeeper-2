//
//  Penalty.h
//  Scorekeeper
//
//  Created by Nandhakumar V on 19/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Penalty : NSManagedObject

@property (nonatomic, retain) NSNumber * game_type;
@property (nonatomic, retain) NSString * jersey;
@property (nonatomic, retain) NSNumber * penalty_id;
@property (nonatomic, retain) NSString * per;
@property (nonatomic, retain) NSString * time_off;
@property (nonatomic, retain) NSString * desc;

@end
