//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Siyu Qi on 11/17/14.
//  Copyright (c) 2014 Siyu Qi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                      cardPairing:(NSUInteger)pairingNumber;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)CardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSUInteger score;
@property (nonatomic) NSUInteger pairingnumber;
@property (nonatomic) BOOL GameStarted;
@property (nonatomic) NSString *Result;
@property (nonatomic) NSMutableArray *History;
@end
