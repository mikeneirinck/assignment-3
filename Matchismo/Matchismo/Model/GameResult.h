//
//  GameResult.h
//  Matchismo
//
//  Created by App  on 12/07/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; // of gameresults
@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
@property (strong, nonatomic) NSString *gameType;

- (NSComparisonResult)compareScore: (GameResult *)result;
- (NSComparisonResult)compareDuration: (GameResult *)result;
- (NSComparisonResult) compareDate: (GameResult *)result;
@end
