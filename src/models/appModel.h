//
//  appModel.h
//  mujik
//
//  Created by jonbroFERrealz on 9/7/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bankModel.h"

@interface appModel : NSObject <NSCoding> {
	bankModel *currentBank;
	NSMutableString *currentScreen;
}

@end