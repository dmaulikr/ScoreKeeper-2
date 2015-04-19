//
//  MenuView.h
//  MHR
//
//  Created by suresh ramasamy on 19/03/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate <NSObject>

-(void)selectedItem:(int)index;

@end

@interface MenuView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    __weak id<MenuViewDelegate> delegate;
}
@property (weak) id<MenuViewDelegate> delegate;

+(MenuView *)getInstance;
-(void)manageMenuView;
@end
