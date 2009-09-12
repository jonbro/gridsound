//
//  gridModel.h
//  iPhone Graphics Example
//
//  Created by jonbroFERrealz on 5/24/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface gridModel : NSObject <NSCoding, NSCopying> {
	NSMutableArray* steps;
	NSMutableArray* mutes;
	NSNumber* currentSample;
	NSNumber* autoMujik;
}

@property (retain) NSMutableArray *steps;
@property (retain) NSMutableArray *mutes;
@property (retain) NSNumber *currentSample;
@property (retain) NSNumber *autoMujik;

@end