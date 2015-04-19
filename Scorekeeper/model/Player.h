//
//  Player.h
//  Scorekeeper
//
//  Created by Nandhakumar V on 19/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject

@property (nonatomic, retain) NSNumber * game_type;
@property (nonatomic, retain) NSNumber * player_id;
@property (nonatomic, retain) NSString * player_name;
@property (nonatomic, retain) NSString * player_position;

@end
