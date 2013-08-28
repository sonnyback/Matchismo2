//
//  PlayingCardDeck.m
//  Matchismo2
//
//  Created by Sonny Back on 7/22/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init {
    
    /**IMPORTANT! An initializer such as this is the ONLY time we assign a value to self!**/
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init]; // allocate a new PlayingCard
                card.rank = rank; // set the rank, can also be done like this - [card setRank:rank];
                card.suit = suit; // set the suit, can also be done like this - [card setSuit:suit];
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

@end
