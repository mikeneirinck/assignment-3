//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by App  on 29/06/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "HistoryViewController.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    self.gameType = @"Set Cards";
    return [[SetCardDeck alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI
{
    [super updateUI];
    [self.flipDescription setAttributedText:[self replaceCardDescriptionsInText:self.flipDescription.attributedText]];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen? @"setCardSelected":@"cardfront"];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        
        if([setCard.symbol isEqualToString:@"oval"])symbol = @"●";
        if([setCard.symbol isEqualToString:@"squiggle"])symbol = @"▲";
        if([setCard.symbol isEqualToString:@"diamond"])symbol = @"◼︎";
        
        symbol = [symbol stringByPaddingToLength:setCard.number withString:symbol startingAtIndex:0];
        
        if([setCard.color isEqualToString:@"red"])[attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        if([setCard.color isEqualToString:@"green"])[attributes setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
        if([setCard.color isEqualToString:@"purple"])[attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
        
        if([setCard.shading isEqualToString:@"solid"])[attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        if([setCard.shading isEqualToString:@"open"])[attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        if([setCard.shading isEqualToString:@"striped"])[attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName: @-5,
                                                                                               NSStrokeColorAttributeName: attributes[NSForegroundColorAttributeName],
                                                                                               NSForegroundColorAttributeName: [attributes[NSForegroundColorAttributeName]colorWithAlphaComponent:0.1]}];
    }
    
    return [[NSAttributedString alloc]initWithString:symbol attributes:attributes];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            NSMutableArray *attributedHistory = [[NSMutableArray alloc]init];
            for (NSString *flip in self.flipHistory) {
                NSAttributedString *attributedFlip = [[NSAttributedString alloc]initWithString:flip];
                [attributedHistory addObject:[self replaceCardDescriptionsInText: attributedFlip]];
            }
            [hvc setHistory:attributedHistory];
        }
    }
}

- (NSAttributedString *)replaceCardDescriptionsInText: (NSAttributedString *)text
{
    NSMutableAttributedString *newText = [text mutableCopy];
    NSArray *setCards = [SetCard cardsFromText:text.string];
    
    if(setCards) {
        for (SetCard *setCard in setCards) {
            NSRange range = [newText.string rangeOfString:setCard.contents];
            if (range.location != NSNotFound) {
                [newText replaceCharactersInRange:range withAttributedString:[self titleForCard:setCard]];
            }
        }
    }
    return newText;
}
@end
