//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Siyu Qi on 11/17/14.
//  Copyright (c) 2014 Siyu Qi. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}


- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck cardPairing:(NSUInteger)pairingNumber
{
    self = [super init];
    self.History = [[NSMutableArray alloc]init];
    self.GameStarted = NO;
    self.Result = @"";
    self.pairingnumber = pairingNumber;
    if (self){
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)CardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    self.Result = @"";
    if (!self.GameStarted) {
        self.GameStarted = YES;
    }
    NSUInteger cardAmount = [self.cards count];
    Card *card = [self CardAtIndex:index];
    if (!card.isMatched)
    {
        if (card.isChosen)
        {
            card.chosen = NO;
        } else
        {
            if (self.pairingnumber == 2)
            {
                for (Card *otherCard in self.cards)
                {
                    if (otherCard.isChosen && !otherCard.isMatched)
                    {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore)
                        {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                            self.Result = [NSString stringWithFormat:@"Matched %@,%@ for %d points!", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                        } else
                        {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.Result = [NSString stringWithFormat:@"%@ and %@ do not match! %d points of penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        }
                        break;
                    }
                }
            }
            else
            {
                for (int i = 0; i < (cardAmount - 1); i++)
                {
                    for (int j = i + 1; j < cardAmount; j++)
                    {
                        Card *otherCard1 = [self CardAtIndex:i];
                        Card *otherCard2 = [self CardAtIndex:j];
                        
                        if (otherCard1.isChosen && !otherCard1.isMatched && otherCard2.isChosen && !otherCard2.isMatched)
                        {
                            int matchScore = [card match:@[otherCard1, otherCard2]];
                            if (matchScore)
                            {
                                self.score += matchScore * MATCH_BONUS;
                                card.matched = YES;
                                otherCard1.matched = YES;
                                otherCard2.matched = YES;
                                self.Result = [NSString stringWithFormat:@"Matched %@,%@ and %@ for %d points!", card.contents, otherCard1.contents, otherCard2.contents, matchScore * MATCH_BONUS];

                            } else
                            {
                                self.score -= MISMATCH_PENALTY;
                                otherCard1.chosen = NO;
                                otherCard2.chosen = NO;
                                self.Result = [NSString stringWithFormat:@"%@, %@ and %@ do not match! %d points of penalty!", card.contents, otherCard1.contents, otherCard2.contents, MISMATCH_PENALTY];
                            }
                            break;
                        }
                    }
                }
                
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            if (self.Result.length){
                [self.History addObject:self.Result];
            }
        }
    }
}


@end
