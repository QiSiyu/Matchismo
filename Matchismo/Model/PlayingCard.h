//
//  PlayingCard.h
//  Matchismo
//
//  Created by Siyu Qi on 11/15/14.
//  Copyright (c) 2014 Siyu Qi. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
