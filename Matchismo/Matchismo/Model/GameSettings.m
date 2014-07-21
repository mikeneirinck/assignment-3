//
//  GameSettings.m
//  Matchismo
//
//  Created by App  on 13/07/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

#define GAME_SETTINGS_KEY @"Game_Settings_Key"
#define MATCHBONUS_KEY @"MatchBonus_Key"
#define MISMATCHPENALTY_KEY @"MismatchPenalty_Key"
#define FLIPCOST_KEY @"FlipCost_Key"
#define NUMBERPLAYINGCARDS_KEY @"NumberPlayingCards_Key"

- (int)intValueForKey:(NSString *)key withDefault:(int)defaultValue
{
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    if (!settings) return defaultValue;
    if (![[settings allKeys] containsObject:key]) return defaultValue;
    return [settings[key] intValue];
}

- (int)matchBonus
{
    return [self intValueForKey:MATCHBONUS_KEY withDefault:4];
}

- (int)mismatchPenalty
{
    return [self intValueForKey:MISMATCHPENALTY_KEY withDefault:2];
}

- (int)flipCost
{
    return [self intValueForKey:FLIPCOST_KEY withDefault:1];
}

- (void)setIntValue:(int)value forKey:(NSString *)key
{
    NSMutableDictionary *settings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY] mutableCopy];
    if (!settings) {
        settings = [[NSMutableDictionary alloc] init];
    }
    settings[key] = @(value);
    [[NSUserDefaults standardUserDefaults] setObject:settings
                                              forKey:GAME_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setMatchBonus:(int)matchBonus
{
    [self setIntValue:matchBonus forKey:MATCHBONUS_KEY];
}

- (void)setMismatchPenalty:(int)mismatchPenalty
{
    [self setIntValue:mismatchPenalty forKey:MISMATCHPENALTY_KEY];
}

- (void)setFlipCost:(int)flipCost
{
    [self setIntValue:flipCost forKey:FLIPCOST_KEY];
}

@end