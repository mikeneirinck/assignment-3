//
//  SetCard.m
//  Matchismo
//
//  Created by App  on 29/06/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (instancetype)init
{
    self = [super init];
    
    if(self){
        self.numberOfMatchingCards = 3;
    }
    
    return self;
}

@synthesize color = _color, symbol = _symbol, shading = _shading;
- (NSString *)color
{
    return _color? _color: @"?";
}

- (void)setColor:(NSString *)color
{
    if([[SetCard validColors]containsObject:color])_color = color;
}

- (NSString *)symbol
{
    return _symbol? _symbol: @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if([[SetCard validSymbols]containsObject:symbol])_symbol = symbol;
}

- (NSString *)shading
{
    return _shading? _shading: @"?";
}

- (void)setShading:(NSString *)shading
{
    if([[SetCard validShadings]containsObject:shading])_shading = shading;
}

- (void)setNumber:(NSUInteger)number
{
    if(number <= [SetCard maxNumber])_number = number;
}

- (NSString *)contents
{
    return [[NSString alloc]initWithFormat:@"%d %@ %@ %@",self.number, self.color, self.shading, self.symbol];
}
/*
- (int)match:(NSArray *)otherCards
{
    int score = 0;
        
    NSMutableArray *colors = [[NSMutableArray alloc]initWithObjects:self.color, nil];
    NSMutableArray *symbols = [[NSMutableArray alloc]initWithObjects:self.symbol, nil];
    NSMutableArray *shadings = [[NSMutableArray alloc]initWithObjects:self.shading, nil];
    NSMutableArray *numbers = [[NSMutableArray alloc]initWithObjects:@(self.number), nil];
  
    for(SetCard *otherCard in otherCards){
        if (![colors containsObject:otherCard.color])[colors addObject:otherCard.color];
        if (![symbols containsObject:otherCard.symbol])[symbols addObject:otherCard.symbol];
        if (![shadings containsObject:otherCard.shading])[shadings addObject:otherCard.shading];
        if (![numbers containsObject:@(otherCard.number)]) [numbers addObject:@(otherCard.number)];
    }
        
   // if([colors count]%2 == 1 && [symbols count]%2 == 1 && [shadings count]%2 == 1 && [numbers count]%2 == 1)score = 4;
    //website schreef:
     if (([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
    && ([symbols count] == 1 || [symbols count] == self.numberOfMatchingCards)
    && ([shadings count] == 1 || [shadings count] == self.numberOfMatchingCards)
    && ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards))
        score = 4;
    
    return score;
}
 */

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == self.numberOfMatchingCards - 1) {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                if (![colors containsObject:otherSetCard.color])
                    [colors addObject:otherSetCard.color];
                if (![symbols containsObject:otherSetCard.symbol])
                    [symbols addObject:otherSetCard.symbol];
                if (![shadings containsObject:otherSetCard.shading])
                    [shadings addObject:otherSetCard.shading];
                if (![numbers containsObject:@(otherSetCard.number)])
                    [numbers addObject:@(otherSetCard.number)];
                if (([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
                    && ([symbols count] == 1 || [symbols count] == self.numberOfMatchingCards)
                    && ([shadings count] == 1 || [shadings count] == self.numberOfMatchingCards)
                    && ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards)) {
                    score = 4;
                }
            }
        }
    }
    
    return score;
}


+ (NSArray *)validColors
{
    return @[@"red",@"green",@"purple"];
}
+ (NSArray *)validSymbols
{
    return @[@"oval",@"squiggle",@"diamond"];
}
+ (NSArray *)validShadings
{
    return @[@"solid",@"open",@"striped"];
}
+ (NSUInteger)maxNumber
{
    return 3;
}
/*
+ (NSArray *)cardsFromText:(NSString *)text
{
    NSString *pattern = [NSString stringWithFormat:@"(%@):(%@):(%@):(\\d+)",
                         [[SetCard validSymbols] componentsJoinedByString:@"|"],
                         [[SetCard validColors] componentsJoinedByString:@"|"],
                         [[SetCard validShadings] componentsJoinedByString:@"|"]];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) return nil;
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, [text length])];
    if (![matches count]) return nil;
    
    NSMutableArray *setCards = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in matches) {
        SetCard *setCard = [[SetCard alloc] init];
        setCard.symbol = [text substringWithRange:[match rangeAtIndex:1]];
        setCard.color = [text substringWithRange:[match rangeAtIndex:2]];
        setCard.shading = [text substringWithRange:[match rangeAtIndex:3]];
        setCard.number = [[text substringWithRange:[match rangeAtIndex:4]] intValue];
        [setCards addObject:setCard];
    }
    
    return setCards;
}
 */


+ (NSArray *)cardsFromText:(NSString *)text
{
    
     NSString *pattern = [NSString stringWithFormat:@"(1|2|3) (%@) (%@) (%@)",
     [[SetCard validColors]componentsJoinedByString:@"|"],
     [[SetCard validShadings]componentsJoinedByString:@"|"],
     [[SetCard validSymbols]componentsJoinedByString:@"|"]];
     NSError *error = NULL;
     NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
     options:NSRegularExpressionCaseInsensitive
     error:&error];
     if(error)return nil;
     NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
     
     if (![matches count])return nil;
     
     NSMutableArray *setCards = [[NSMutableArray alloc]init];
     for (NSTextCheckingResult *match in matches) {
     SetCard *setCard = [[SetCard alloc]init];
     setCard.number = [[text substringWithRange:[match rangeAtIndex:1]]intValue];
     setCard.color = [text substringWithRange:[match rangeAtIndex:2]];
     setCard.shading = [text substringWithRange:[match rangeAtIndex:3]];
     setCard.symbol = [text substringWithRange:[match rangeAtIndex:4]];
     [setCards addObject:setCard];
     }
     
     return setCards;

}
@end
