//
//  CardMatchingGame.h
//  Matchismo2
//
//  Created by Sonny Back on 7/24/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer. Only initialized if called
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)selectSetCardAtIndex:(NSUInteger)index;

// readonly is only for the public api (no setter method)
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) BOOL match;
@property (nonatomic, readonly) Card *lastFlippedCard;
@end
