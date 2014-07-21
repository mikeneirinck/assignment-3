//
//  GameSettings.h
//  Matchismo
//
//  Created by App  on 13/07/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSettings : NSObject

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;

@end