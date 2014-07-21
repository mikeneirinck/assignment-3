//
//  SetCardDeck.m
//  Matchismo
//
//  Created by App  on 29/06/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
- (instancetype)init
{
    self = [super init];
    
    if (self){
        for (int number = 1; number <= [SetCard maxNumber]; number++) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSString *symbol in [SetCard validSymbols]) {
                        SetCard *card = [[SetCard alloc]init];
                        card.number = number;
                        card.color = color;
                        card.shading = shading;
                        card.symbol = symbol;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
