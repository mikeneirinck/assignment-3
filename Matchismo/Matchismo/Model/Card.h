//
//  Card.h
//  Matchismo
//
//  Created by App  on 20/04/14.
//  Copyright (c) 2014 appgriffie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString * contents;
@property (nonatomic) NSUInteger numberOfMatchingCards;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) match: (NSArray *)otherCards;
@end
