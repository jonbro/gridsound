//
//  gridModel.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface gridModel : NSObject <NSCoding> {
	NSMutableArray* steps;
	NSNumber* currentSample;
}

@property (retain) NSMutableArray *steps;
@property (retain) NSNumber *currentSample;

-(void)encodeWithCoder:(NSCoder *)coder;
-(id)initWithCoder:(NSCoder *)coder;

@end