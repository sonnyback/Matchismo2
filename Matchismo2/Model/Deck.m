//
//  Deck.m
//  Matchismo2
//
//  Created by Sonny Back on 7/22/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of card
@end

@implementation Deck
@synthesize cards = _cards;

// getter method for *cards array using lazy instantiation
- (NSMutableArray *)cards {
    
    //NSLog(@"Getter method for @cards!");
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

/**
 * Method for adding a card to the deck and determing if it goes on top of the deck or the bottom
 *
 * @param Card *card
 * @param BOOL atTop
 * @return void
 */
- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    
    //NSLog(@"Entered addCard:atTop...card is %@", card.description);
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

/**
 * Method for drawing a random card from the deck
 *
 * @return Card *
 */
- (Card *)drawRandomCard {
    
    NSLog(@"Entered drawRandomCard");
    Card *randomCard = nil;
    //NSLog(@"cards array size is %lu", (unsigned long)[self.cards count]); // count is not a property so we call method notation
    
    if ([self.cards count]) { // if *card array is not empty
        unsigned index = arc4random() % [self.cards count]; // get a random number for the index
        //NSLog(@"drawRandomCard.index is %d", index);
        randomCard = self.cards[index]; // draw a random card from the deck
        [self.cards removeObjectAtIndex:index]; // remove the current card from the deck
    }
    
    //NSLog(@"randomCard is: %@", [NSString stringWithFormat:@"%@", randomCard.description]);
    return randomCard;
}

@end
