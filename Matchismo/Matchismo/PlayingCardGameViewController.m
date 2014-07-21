//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by App  on 26/06/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"


@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    self.gameType = @"Playing Cards";
    return [[PlayingCardDeck alloc]init];
}

@end
