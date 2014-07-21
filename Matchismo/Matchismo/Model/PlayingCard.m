//
//  PlayingCard.m
//  Matchismo
//
//  Created by App  on 21/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    // creating a new array containing all PlayingCards (so also the Card within self. This new allCards array then will be used within a while loop. This while loop will take each time one PlayingCard and compare it to the other PlayingCards. If a match arises, the score is augmented.
    NSMutableArray *allCards = [[NSMutableArray alloc]initWithArray:otherCards];
    [allCards addObject:self];
    
    // when allCards is equal to 1 it make no sense to do the comparison any longer as there will be no longer any PlayingCards to compare to
    while ([allCards count]>1)
    {
        PlayingCard *cardToBeComparedTo = [allCards lastObject];
        [allCards removeLastObject];
        for (PlayingCard *otherCard in allCards)
        {
            if ([cardToBeComparedTo.suit isEqualToString:otherCard.suit])
            {
                score += 1;
            } else if(cardToBeComparedTo.rank == otherCard.rank)
            {
                score += 4;
            }
        }
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♣︎", @"♠︎", @"♥︎", @"♦︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank
{
    return [[self rankStrings]count]-1;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits]containsObject: suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit? _suit: @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
