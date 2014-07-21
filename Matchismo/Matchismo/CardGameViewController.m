//
//  CardGameViewController.m
//  Matchismo
//
//  Created by App  on 20/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"
#import "GameResult.h"
#import "GameSettings.h"


@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;

@property (strong, nonatomic) GameResult *gameResult;
@property (strong, nonatomic) GameSettings *gameSettings;
@end


@implementation CardGameViewController
- (GameResult *)gameResult
{
    if(!_gameResult)_gameResult = [[GameResult alloc]init];
    _gameResult.gameType = self.gameType;
    return _gameResult;

}

- (GameSettings *)gameSettings
{
    if(!_gameSettings)_gameSettings = [[GameSettings alloc]init];
    return _gameSettings;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.game.matchBonus = self.gameSettings.matchBonus;
    self.game.mismatchPenalty = self.gameSettings.mismatchPenalty;
    self.game.flipCost = self.gameSettings.flipCost;
}

- (IBAction)changeSlider:(UISlider *)sender
{
    int sliderValue = 0;
    sliderValue = lroundf([self.historySlider value]);
    [self.historySlider setValue:sliderValue animated:NO];
    if ([self.flipHistory count]) {
        if (sliderValue + 1 < [self.flipHistory count]) {
            self.flipDescription.alpha = 0.4;
            self.flipDescription.text = self.flipHistory[sliderValue];
        }
    }
}

- (NSMutableArray *)flipHistory
{
    if (!_flipHistory) _flipHistory = [[NSMutableArray alloc]init];
    return _flipHistory;
}

- (IBAction)changeModeSelector:(UISegmentedControl *)sender
{
    self.game.maxMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex]integerValue];
}

- (IBAction)touchDealButton:(id)sender
{
    self.modeSelector.enabled = YES;
    self.game = nil;
    self.flipHistory = nil;
    self.gameResult = nil;
    [self updateUI];
}


- (CardMatchingGame *)game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        
        _game.matchBonus = self.gameSettings.matchBonus;
        _game.mismatchPenalty = self.gameSettings.mismatchPenalty;
        _game.flipCost = self.gameSettings.flipCost;
        
        [self changeModeSelector:self.modeSelector];
    }
    
    return _game;
}

- (Deck *)createDeck //abstract
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.modeSelector.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = ! card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.gameResult.score = self.game.score;
    }
    
    [self fillDescriptionAndHistory];
}

- (void) fillDescriptionAndHistory
{
    NSString *description = @"Nothing";
    if ([self.game.lastChosenCards count]){
        NSMutableArray *cardContents = [[NSMutableArray alloc]init];
        for (Card *card in self.game.lastChosenCards)[cardContents addObject:card.contents];
        description = [cardContents componentsJoinedByString:@""];
    }
    
    if (self.game.lastScore > 0) {
        description = [NSString stringWithFormat:@"Matched %@ for %d points", description, self.game.lastScore];
    } else if (self.game.lastScore < 0){
        description = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", description, self.game.lastScore];
    }else{
        description = [NSString stringWithFormat:@"%@ selected", description];
    }
    self.flipDescription.text = description;
    self.flipDescription.alpha = 1;
    
    if (![[self.flipHistory lastObject]isEqualToString:description]) {
        [self.flipHistory addObject:description];
        [self setSliderRange];
    }
}

- (void)setSliderRange
{
    int maxValue = [self.flipHistory count]-1;
    self.historySlider.maximumValue = maxValue;
    [self.historySlider setValue:maxValue animated:YES];
}

- (NSAttributedString *)titleForCard: (Card *)card
{
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:card.isChosen? card.contents: @"?"];
    return title;
}

- (UIImage *)backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed: card.isChosen? @"cardfront": @"cardback"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            [hvc setHistory:self.flipHistory];
        }
    }
}

@end
