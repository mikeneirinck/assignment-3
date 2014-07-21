//
//  PlayingCard.h
//  Matchismo
//
//  Created by App  on 21/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
