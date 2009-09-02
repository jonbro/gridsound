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
#import "menuController.h"

@interface mainController : CustomEventResponder {
	bankController *bankC;
	parentController *parentC;
	menuController *menuC;
}
@property (nonatomic, retain) bankController *bankC;
@property (nonatomic, retain) parentController *parentC;
@property (nonatomic, retain) menuController *menuC;

-(void)switchToBank:(NSNotification *)notification;
-(void)switchToMain:(NSNotification *)notification;

@end
