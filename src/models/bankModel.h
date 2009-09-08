//
//  bankModel.h
//  mujik
//
//  Created by jonbroFERrealz on 9/7/09.
//  Copyright 2009 Heavy Ephemera Industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "parentModel.h"

@interface bankModel : NSObject <NSCoding> {
	NSMutableArray *phraseSet;
	NSMutableString *bankName;
	parentModel *currentParent;
}

@property (nonatomic, retain) NSMutableString *bankName;
@property (nonatomic, retain) parentModel *currentParent;
@property (nonatomic, retain) NSMutableArray *phraseSet;

@end
