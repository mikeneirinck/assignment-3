//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by App  on 22/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (strong, nonatomic, readwrite) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;
@end


@implementation CardMatchingGame
- (NSUInteger)maxMatchingCards
{
    Card *card = [self.cards firstObject];
    if (_maxMatchingCards < card.numberOfMatchingCards)
    {
        _maxMatchingCards = card.numberOfMatchingCards;
    }
    
    return _maxMatchingCards;
}

- (NSMutableArray *)cards
{
    if (!_cards)_cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            } else
            {
                return nil;
                break;
            }
        }
        _matchBonus = MATCH_BONUS;
        _mismatchPenalty = MISMATCH_PENALTY;
        _flipCost = COST_TO_CHOOSE;
    }
    
    return  self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count])? self.cards[index] : nil;
}

static const int COST_TO_CHOOSE = 1;
static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;


- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched)
    {
        if (card.isChosen)
        {
            card.chosen = NO;
        } else
        {
            self.lastScore = 0;
            NSMutableArray *otherCards = [[NSMutableArray alloc]init];
            // match against another card
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)[otherCards addObject:otherCard];
 
            }
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            if ([otherCards count]==self.maxMatchingCards-1)
            {
                
                int matchScore = [card match:otherCards];
                if (matchScore)
                {
                    self.lastScore = matchScore * self.matchBonus;
                    card.matched = YES;
                    for (Card *otherCard in otherCards)otherCard.matched = YES;
                } else
                {
                    self.lastScore = - self.mismatchPenalty;
                    for (Card *otherCard in otherCards)otherCard.chosen = NO;
                }
                 
             }
            card.chosen = YES;
            self.score += self.lastScore - self.flipCost;
        }
    }
}
@end
