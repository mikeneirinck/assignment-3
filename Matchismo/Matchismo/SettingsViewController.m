//
//  SettingsViewController.m
//  Matchismo
//
//  Created by App  on 13/07/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//
#import "SettingsViewController.h"
#import "GameSettings.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *matchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *mismatchPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipCostLabel;
@property (weak, nonatomic) IBOutlet UISlider *matchBonusSlider;
@property (weak, nonatomic) IBOutlet UISlider *mismatchPenaltySlider;
@property (weak, nonatomic) IBOutlet UISlider *flipCostSlider;

@property (strong, nonatomic) GameSettings *gameSettings;

@end

@implementation SettingsViewController

- (GameSettings *)gameSettings
{
    if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
    return _gameSettings;
}

- (void)setLabel:(UILabel *)label forSlider:(UISlider *)slider
{
    int sliderValue;
    sliderValue = lroundf(slider.value);
    [slider setValue:sliderValue animated:NO];
    
    label.text = [NSString stringWithFormat:@"%d", sliderValue];
}

- (IBAction)matchBonusSliderChanged:(UISlider *)sender {
    [self setLabel:self.matchBonusLabel forSlider:sender];
    self.gameSettings.matchBonus = floor(sender.value);
}

- (IBAction)mismatchPenaltySliderChanged:(UISlider *)sender {
    [self setLabel:self.mismatchPenaltyLabel forSlider:sender];
    self.gameSettings.mismatchPenalty = floor(sender.value);
}

- (IBAction)flipCostSliderChanged:(UISlider *)sender {
    [self setLabel:self.flipCostLabel forSlider:sender];
    self.gameSettings.flipCost = floor(sender.value);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.matchBonusSlider.value = self.gameSettings.matchBonus;
    self.mismatchPenaltySlider.value = self.gameSettings.mismatchPenalty;
    self.flipCostSlider.value = self.gameSettings.flipCost;
    
    [self setLabel:self.matchBonusLabel forSlider:self.matchBonusSlider];
    [self setLabel:self.mismatchPenaltyLabel forSlider:self.mismatchPenaltySlider];
    [self setLabel:self.flipCostLabel forSlider:self.flipCostSlider];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
}

@end