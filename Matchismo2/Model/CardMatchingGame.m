//
//  CardMatchingGame.m
//  Matchismo2
//
//  Created by Sonny Back on 7/24/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, strong) NSMutableArray *cards; // of Card - for the Matchismo game
@property (nonatomic, readwrite) int score; // readwrite is only to make it clear that the public property is readonly
@property (nonatomic, readwrite) BOOL match; // used for updating the UI appropriately
@property (nonatomic, readwrite) Card *lastFlippedCard; // used for updating the UI statusLabel appropriately
@end

@implementation CardMatchingGame
@synthesize cards = _cards;
@synthesize lastFlippedCard = _lastFlippedCard;

// getter method with lazy instantiation
- (NSMutableArray *)cards {
    
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

// getter method with lazy instantiation
- (Card *)lastFlippedCard {
    
    if (!_lastFlippedCard) _lastFlippedCard = [[Card alloc] init];
    
    return _lastFlippedCard;
}

/**
 * Designated initializer. That means it's not legally initialized unless it gets called at some point. We
 * must always call our superclass' designated initializer from *our* designated initializer. NSObject's
 * designated initializer is init.
 *
 * @param NSUInteger count
 * @param Deck *deck
 * @return (id) self
 */
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    
    NSLog(@"Calling initWithCardCount:usingDeck for count: %d", count);
    NSLog(@"Calling initWithCardCount:usingDeck for deck: %@", deck.description);
    
    self = [super init]; // this is the ONLY place to ever assign a value to self and MUST be called within designated initialier
    
    if (self) {
        // loop through the specificed count of cards, i.e. count
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard]; // get a random card from the deck
            //NSLog(@"Current card is: %@", card.contents);
            NSLog(@"Current card is: %@", card.description);
            if (!card) { // protect against bad or insufficient *deck passed as an argument
                self = nil;
                break; // break out of the loop if we can't get a card
            } else {
                self.cards[i] = card; // assign the random card to the card in the array
            }
        }
    }
    
    return self;
}

/**
 * Method for getting a specific card in the deck via the index passed
 *
 * @param NSUInteger index
 * @return Card *
 */
- (Card *)cardAtIndex:(NSUInteger)index {
    
    // if the index value is < then array size, get the card, else return nil
    return (index < [self.cards count] ? self.cards[index] : nil);
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

/**
 * Method to flip the card at a given index and perform main game logic for Matchismo, i.e. matching.
 *
 * @param NSUInteger index
 * @return void
 */
- (void)flipCardAtIndex:(NSUInteger)index {
    
    NSLog(@"Entered flipCardAtIndex (%lu)", (unsigned long)index);
    Card *card = [self cardAtIndex:index];
    self.match = NO; // to let the UI know if there is match for updating the currentStatusLabel
    self.lastFlippedCard = nil; // used to make the lastflipped Card available to the UI to display to statusLabel
    
    if (!card.isUnplayable) { // make sure the card is playable
        if (!card.isFaceUp) { // if the card is playable and is *being* flipped up, do match logic, not if being flipped *down*
            // loop through the cards and look for a playable, faceup card to match with
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) { // make sure the card is face up and playable
                    self.lastFlippedCard = otherCard; // for tracking last flipped card to display in current status label
                    int matchScore = [card match:@[otherCard]]; // create an array on the fly because PlayingCard.match takes an array
                    if (matchScore) {
                        otherCard.unplayable = YES; // set other card to unplayable since it matched
                        card.unplayable = YES; // set card to unplayable since it matched
                        self.score += matchScore * MATCH_BONUS;
                        self.match = YES;
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.match = NO;
                    }
                    break; // determined if it matched or not, so break out of the loop
                }
            }
            self.score -= FLIP_COST; // charge a penalty for each time card is flipped
        }
        card.faceUp = !card.isFaceUp; // set the card to the opposite state (face up/down). Use the getter (isFaceUp) to set it
    }
}

/**
 * Method to select the card at a given index and perform main game logic for Set game, i.e. matching.
 *
 * @param NSUInteger index
 * @return void
 */
- (void)selectSetCardAtIndex:(NSUInteger)index {
    
    NSLog(@"Entered selectSetCardAtIndex");
    NSMutableArray *matchingArray = [[NSMutableArray alloc] init];
    Card *card = [self cardAtIndex:index];
    self.match = NO; // to let the UI know if there is match for updating the currentStatusLabel
    
    
    if (!card.isUnplayable) { // make sure the card is playable
        if (!card.isSelected) { // if card is *being* selected, do match logic, not if being de-selected
            // loop through the cards to find any playable, selected cards to match
            for (Card *otherCard in self.cards) {
                if (otherCard.isSelected && !otherCard.unplayable) {
                    NSLog(@"Playable Set card - %@", otherCard.description);
                    [matchingArray addObject:otherCard];
                    if ([matchingArray count] > 1) {
                        int matchScore = [card match:matchingArray];
                        if (matchScore) {
                            NSLog(@"match!");
                            self.match = YES; 
                            card.unplayable = YES; // set the card to unplayable since it's a match
                            // go through the array of cards that are being matched and set them to unplayable
                            for (Card *anotherCard in matchingArray) {
                                anotherCard.unplayable = YES;
                                if (anotherCard.unplayable == YES) NSLog(@"Unplayable card - %@", anotherCard.description);
                            }
                            // match made, so remove all the playable cards from the matching array
                            [matchingArray removeAllObjects];
                        } else {
                            NSLog(@"No match!");
                            self.match = NO;
                            for (Card *anotherCard in matchingArray) {
                                anotherCard.selected = !anotherCard.isSelected;
                            }
                            // cards are not matched, but clear out the array to start over
                            [matchingArray removeAllObjects];
                        }
                        break; // match determined, so break out of loop
                    }
                }
            }
        }
    }

    card.selected = !card.isSelected; // set the card to the opposite state (face up/down).
    /*if (card.isSelected) {
        NSLog(@"card is selected!");
    } else {
        NSLog(@"card is NOT selected!");
    }*/
}

@end
