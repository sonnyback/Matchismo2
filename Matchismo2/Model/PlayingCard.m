//
//  PlayingCard.m
//  Matchismo2
//
//  Created by Sonny Back on 7/22/13.
//  Copyright (c) 2013 sback. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit; // in iOS6 this is only needed we define getter AND setter

/**
 * This method overrides Card's implementation so that we can match based on rank or suit
 *
 * @param NSArray *otherCards
 * @return int - the score
 */
- (int)match:(NSArray *)otherCards {
    
    NSLog(@"Entered PlayingCard.match...");
    int score = 0;
    
    // check to see if the current playingcard (self) matches the suit or rank of the other playingcard. if not, return score=0
    if ([otherCards count] == 1) { // need to make sure we have another card to match against 
        //PlayingCard *otherCard = [otherCards lastObject]; // lastObject will always return nil if empty, never AIOoB
        id otherCard = [otherCards lastObject]; // lastObject will always return nil if empty, never AIOoB
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            //NSLog(@"otherCard is a PlayingCard!");
            /* using introspection to make sure we have a PlayingCard in the array and not some other type of Card (From lecture 4) */
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard; // (PlayingCard *)casting not required, but just for clarity
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                //NSLog(@"%@ is a match for %@", otherCard.suit, self.suit);
                score = 1; // less points for matching suit
            } else if (otherPlayingCard.rank == self.rank) {
                //NSLog(@"%lu is a match for %lu", (unsigned long)otherCard.rank, (unsigned long)self.rank);
                score = 4; // more points for matching rank
            }
        }
    }
    
    
    return score;
}

- (NSString *)contents {
    
    //NSLog(@"Entered contents...");
    // array of the ranking strings. @[] is iOS6 syntax for creating arrays on the fly
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    // return the string with the rank and suit appended
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

/**
 * Class method for returning an array of the valid card suits
 *
 * @return NSArray *validSuits
 */
+ (NSArray *)validSuits {
    
    //NSLog(@"Entered validSuits...");
    return @[@"♥",@"♦",@"♠",@"♣"]; // array of valid suits
}

// setter method for NSString *suit
- (void)setSuit:(NSString *)suit {
    
    // set the suit if it contains one of the valid ones, otherwise it's 0
    if ([[PlayingCard validSuits] containsObject:suit]) { // this is calling a CLASS method
        _suit = suit;
    }
}

// getter method for NSString *suit
- (NSString *)suit {
    
    // if the suit is one of the valid ones in the array use that otherwise use "?"
    return _suit ? _suit : @"?";
}

/**
 * Class method for returning an array of card rank strings
 *
 * @return NSArray *rankStrings
 */

+ (NSArray *)rankStrings {
    
    //NSLog(@"Entered rankStrings...");
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

/**
 * CLASS method to return the max card rank.
 *
 * @return NSArray *rankStrings
 */
+ (NSUInteger)maxRank {
    
    //NSLog(@"Entered maxRank");
    
    //return [self rankStrings].count-1;
    return [[self rankStrings] count]-1; // proper way to call since count is not a proper. above line does work though
}

// setter method for rank
- (void)setRank:(NSUInteger)rank {
    
    //NSLog(@"Entered maxRank...");
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
