//
//  gridModel.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface gridModel : NSObject {
	NSMutableArray* steps;
	NSNumber* currentSample;
}

@property NSMutableArray *steps;
@property NSNumber *currentSample;

@end