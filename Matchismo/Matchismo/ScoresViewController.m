//
//  ScoresViewController.m
//  Matchismo
//
//  Created by App  on 12/07/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "ScoresViewController.h"
#import "GameResult.h"

@interface ScoresViewController ()
@property (weak, nonatomic) IBOutlet UITextView *scoresTextView;
@property (strong, nonatomic) NSArray * scores;

@end

@implementation ScoresViewController
- (IBAction)sortByScore {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI];
}

- (IBAction)sortByDate {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI];
}

- (IBAction)sortByDuration {
    self.scores = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scores = [GameResult allGameResults];
    [self updateUI];
}

- (NSString *)stringFromResult: (GameResult *)result
{
    return [NSString stringWithFormat:@"%@: %d (%@ in %gs)\n", result.gameType, result.score, [NSDateFormatter localizedStringFromDate:result.end dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle], result.duration];
}

- (void)changeScore: (GameResult *)result toColor: (UIColor *)color
{
    NSRange range = [self.scoresTextView.text rangeOfString:[self stringFromResult:result]];
    [self.scoresTextView.textStorage addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)updateUI
{
    NSString *text = @"";
    for (GameResult *result in self.scores) {
        text = [text stringByAppendingString:[self stringFromResult:result]];
    }
    
    self.scoresTextView.text = text;
    
    NSArray *sortedArray = [self.scores sortedArrayUsingSelector:@selector(compareScore:)];
    [self changeScore:[sortedArray firstObject] toColor:[UIColor redColor]];
    [self changeScore:[sortedArray lastObject] toColor:[UIColor redColor]];
    sortedArray = [self.scores sortedArrayUsingSelector:@selector(compareDuration:)];
    [self changeScore:[sortedArray firstObject] toColor:[UIColor purpleColor]];
    [self changeScore:[sortedArray lastObject] toColor:[UIColor purpleColor]];

}
@end
