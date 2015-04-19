//
//  DefaultRow.m
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "DefaultRow.h"

@implementation DefaultRow

-(id) initWithStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *)identifier
{
    self=[super initWithStyle:style reuseIdentifier:identifier];
    
    self.backgroundView.opaque = YES;
   
    return self;
}

-(id) initCellWithData:(id)obj forRowNum:(int) row ofTotalRows:(int)total andNoOfCols:(int)noOfCols
{
    return self;
}

@end
