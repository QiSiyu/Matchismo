//
//  ViewController.m
//  Matchismo
//
//  Created by Siyu Qi on 11/15/14.
//  Copyright (c) 2014 Siyu Qi. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *NewGameButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *GameSwitch;
@property (weak, nonatomic) IBOutlet UILabel *ResultLabel;
@property (weak, nonatomic) IBOutlet UISlider *HistorySlider;
@end

@implementation ViewController
#define default_card_number 2

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]
                                                        cardPairing:default_card_number];
    return _game;
}



- (Deck *)deck{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.ResultLabel.alpha = 1.0;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)slide:(UISlider *)sender
{
    self.ResultLabel.text = [self.game.History objectAtIndex:sender.value];
    self.ResultLabel.alpha = 0.3;
}

- (IBAction)GameSwtich:(UISegmentedControl *)sender
{
    self.game.pairingnumber = sender.selectedSegmentIndex + 2;
}

- (IBAction)touchNewGameButton:(UIButton *)sender
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                                cardPairing:self.game.pairingnumber];
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game CardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.ResultLabel.text = self.game.Result;
        self.HistorySlider.maximumValue = [self.game.History count] - 1;
        self.HistorySlider.value = [self.game.History count] - 1;
    }
    self.GameSwitch.enabled = !self.game.GameStarted;
    
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end
