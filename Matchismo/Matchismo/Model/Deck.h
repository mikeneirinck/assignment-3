//
//  Deck.h
//  Matchismo
//
//  Created by App  on 21/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addCard: (Card *)card atTop: (BOOL)atTop;
- (void) addCard:(Card *)card;

- (Card *) drawRandomCard;
@end
