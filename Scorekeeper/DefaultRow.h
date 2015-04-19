//
//  DefaultRow.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultRow : UITableViewCell

-(id) initWithStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *)identifier;
-(id) initCellWithData:(NSMutableArray *)dataArr forRowNum:(int) row ofTotalRows:(int)total andNoOfCols:(int)noOfCols;

@end
