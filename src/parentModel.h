//
//  parentModel.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface parentModel : NSObject {
	NSMutableArray* gridModels;
	NSMutableString* currentState;
	NSNumber* currentGrid;	
}
@property NSMutableArray *gridModels;
@property NSMutableString* currentState;
@property NSNumber *currentGrid;

@end
