//
//  SetCard.h
//  Matchismo
//
//  Created by App  on 29/06/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

+ (NSArray *)cardsFromText: (NSString *)text;
@end
