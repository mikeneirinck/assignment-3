//
//  CardGameViewController.h
//  Matchismo
//
//  Created by App  on 20/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//
// Abstract class. Must be overriden.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController
- (NSAttributedString *)titleForCard: (Card *)card;
- (UIImage *)backgroundImageForCard: (Card *)card;
- (void)updateUI;

@property (weak, nonatomic) IBOutlet UILabel *flipDescription;
@property (strong, nonatomic) NSMutableArray *flipHistory;

@property (strong, nonatomic)NSString *gameType;

// protected
// for subclasses
- (Deck *) createDeck; //abstract
@end
