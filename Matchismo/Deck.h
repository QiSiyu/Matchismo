//
//  Deck.h
//  Matchismo
//
//  Created by Siyu Qi on 11/15/14.
//  Copyright (c) 2014 Siyu Qi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;
@end
