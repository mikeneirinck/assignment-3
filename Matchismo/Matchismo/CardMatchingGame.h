//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by App  on 22/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount: (NSUInteger)count
                        usingDeck: (Deck *)deck;

- (void)chooseCardAtIndex: (NSUInteger)index;
- (Card *)cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly)NSInteger score;
@property (nonatomic) NSUInteger maxMatchingCards;
@property (strong, nonatomic, readonly) NSArray *lastChosenCards;
@property (nonatomic, readonly) NSInteger lastScore;

@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (nonatomic) int flipCost;
@end
