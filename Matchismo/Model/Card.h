//
//  Card.h
//  Matchismo
//
//  Created by Siyu Qi on 11/15/14.
//  Copyright (c) 2014 Siyu Qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;
@end
