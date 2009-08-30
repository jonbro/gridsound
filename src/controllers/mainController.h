//
//  mainController.h
//  mujik
//
//  Created by jonbroFERrealz on 8/30/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomEventResponder.h"
#import "bankController.h"
#import "parentController.h"

@interface mainController : CustomEventResponder {
	bankController *bankC;
	parentController *parentC;
}
@property (nonatomic, retain) bankController *bankC;
@property (nonatomic, retain) parentController *parentC;

-(void)switchToBank:(NSNotification *)notification;
-(void)switchToMain:(NSNotification *)notification;

@end
