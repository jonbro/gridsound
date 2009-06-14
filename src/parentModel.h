//
//  parentModel.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gridModel.h"

@interface parentModel : NSObject <NSCoding> {
	NSMutableArray* gridModels;
	NSMutableArray* mutes;
	NSMutableArray* volumes;
	NSMutableArray* directions;
	NSString* currentState;
	NSNumber* currentGrid;	
}
@property (retain) NSMutableArray *gridModels;
@property (retain) NSMutableArray *mutes;
@property (retain) NSMutableArray *volumes;
@property (retain) NSMutableArray *directions;
@property (copy) NSString* currentState;
@property (retain) NSNumber* currentGrid;

-(void)encodeWithCoder:(NSCoder *)coder;
-(id)initWithCoder:(NSCoder *)coder;
- (void)setCurrentState:(NSString*)aValue;

@end
