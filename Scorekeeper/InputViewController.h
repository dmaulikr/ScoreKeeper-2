//
//  InputViewController.h
//  Scorekeeper
//
//  Created by suresh ramasamy on 12/04/15.
//  Copyright (c) 2015 suresh ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputViewControllerDelegate <NSObject>

-(void)doneButtonClicked;

@end

@interface InputViewController : UIViewController<UITextFieldDelegate>
{
    __weak id<InputViewControllerDelegate> delegate;
}

@property (weak) id<InputViewControllerDelegate> delegate;
@property int editMode;
@property int gameType;

-(id)initWithFrame:(CGRect)frame withType:(int)type source:(NSMutableArray *)sourceData;

@end
