//
//  MenuCell.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import "DefaultRow.h"

@interface MenuCell : DefaultRow

@property (retain) UILabel *titleLbl;

-(id) initCellWithData:(NSString *)dataArr forRowNum:(int)row ofTotalRows:(int)total andNoOfCols:(int)noOfCols;
@end
